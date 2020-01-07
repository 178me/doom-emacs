(use-package! youdao-dictionary
  :config
  (map!
   :leader
   :prefix ("e" . "178me插件")
   :desc "翻译单词"
   :n "y" #'youdao-dictionary-search-at-point-posframe
   :desc "播放单词"
   :n "p" #'youdao-dictionary-play-voice-at-point
   :desc "查找单词"
   :n "s" #'youdao-dictionary-search-from-input))
