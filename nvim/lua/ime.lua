-- ノーマル・ビジュアルのモードでは日本語入力を使えなくする。いらなくなったら、このファイルと init.lua の require("ime") を消す
--
-- なぜ要るか（2026-10-18 にキーを記録して確認、docs/log.md）
--   ノーマルモードで日本語入力がオンだと、変換中の文字（ひらがなにできなかった英字が混ざる）が確定して届き、
--   s や a などがコマンドとして効いてインサートモードに入り、そのあとの文字が本文に書き込まれてしまう
--   Neovim からは日本語入力の s とキーボードの s を区別できないので、日本語入力そのものをオフにしておくしかない
--   macOS にもターミナルにも「このモードの間だけ日本語入力を止める」設定は無いので、オンになったらすぐ英字に戻す
--
-- 仕組み
--   1. 編集モードを抜けたとき・起動したとき・Neovim の画面に戻ったときに英字（ABC）にする（一般的なプラグインと同じこと）
--   2. ノーマル・ビジュアルのモードで日本語入力をオンにした瞬間に英字へ戻す（これに当たる一般的なプラグインは無い）
--      入力ソースが切り替わると macOS が通知を配るので、それを osascript（macOS に最初から入っている）で受け取る
--      この Neovim を使っていないとき（ほかのアプリ・ほかの tmux の画面）は戻さない
--   切り替えは macism（home.nix で入れている）。日本語を打つときは、インサートモードで自分で切り替える

if vim.fn.executable("macism") ~= 1 then
  return
end

local ABC = "com.apple.keylayout.ABC"

local function to_abc()
  vim.system({ "macism", ABC })
end

local function in_normal_or_visual()
  return vim.api.nvim_get_mode().mode:match("^[nvV\22]") ~= nil
end

-- 1. 日本語入力のまま編集モードを抜けても、入力の切り替えは起きないので 2 では気づけない。ここで英字にする
vim.api.nvim_create_autocmd({ "InsertLeave", "VimEnter", "FocusGained" }, { callback = to_abc })

-- 2. 入力ソースが切り替わるたびに1行出す見張り役（JavaScript for Automation）
-- 中に ]] が含まれるので、Lua の文字列は [==[ ]==] で囲む
local watcher = [==[
ObjC.import("Foundation");
const out = $.NSFileHandle.fileHandleWithStandardOutput;
ObjC.registerSubclass({
  name: "ImeWatcher",
  methods: {
    "changed:": {
      types: ["void", ["id"]],
      implementation: function (_) {
        out.writeData($("changed\n").dataUsingEncoding($.NSUTF8StringEncoding));
      },
    },
  },
});
$.NSDistributedNotificationCenter.defaultCenter.addObserverSelectorNameObject(
  $.ImeWatcher.alloc.init, "changed:",
  "com.apple.Carbon.TISNotifySelectedKeyboardInputSourceChanged", $());
$.NSRunLoop.currentRunLoop.run;
]==]

local focused = true
vim.api.nvim_create_autocmd("FocusGained", { callback = function() focused = true end })
vim.api.nvim_create_autocmd("FocusLost", { callback = function() focused = false end })

-- Neovim を閉じると一緒に終わる
vim.fn.jobstart({ "osascript", "-l", "JavaScript", "-e", watcher }, {
  on_stdout = function()
    if not focused or not in_normal_or_visual() then
      return
    end
    -- 英字に戻したときにも通知が来るので、いまの入力ソースを見て英字でないときだけ切り替える
    vim.system({ "macism" }, { text = true }, function(r)
      if vim.trim(r.stdout or "") ~= ABC then
        to_abc()
      end
    end)
  end,
})
