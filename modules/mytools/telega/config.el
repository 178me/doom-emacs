;;; ~/telega-config.el -*- lexical-binding: t; -*-


;; copied from https://github.com/sarg/dotfiles/
(use-package! telega
  :commands (telega)
  :hook (telega-chat-mode . doom-mark-buffer-as-real-h)
  :config
  (map!
   :leader
   :prefix ("e" . "178me插件")
   :desc "查找联系人"
   :n "t" #'ivy-telega-chat-with)

  (telega-mode-line-mode 1)
  (set-popup-rule! (regexp-quote telega-root-buffer-name)
    :side 'left :size 50 :quit nil :modeline t :select t)
  (set-popup-rule! "^◀[[({<].*[\])>}]$"
    :side 'right :size 94 :quit nil :modeline t :select t)
  (setq telega-use-tracking t
        telega-chat-footer-show-pinned-message nil
        telega-known-inline-bots '("@shufmbot")
        telega-sticker-set-download t
        telega-chat-button-width 28
        telega-root-fill-column 48
        telega-proxies (list '(:server "127.0.0.1" :port 1080 :enable t
                                       :type (:@type "proxyTypeSocks5"))))
  (when (featurep! :completion ivy)
    (load! "+ivy")
    (map! :map (telega-root-mode-map telega-chat-mode-map)))

  (when (featurep! :completion company)
    (add-hook 'telega-chat-mode-hook
              (lambda ()
                (set (make-local-variable 'company-backends)
                     (append '(telega-company-emoji
                               telega-company-username
                               telega-company-hashtag)
                             (when (telega-chat-bot-p telega-chatbuf--chat)
                               '(telega-company-botcmd)))))))
  (when (featurep! :editor evil)
    (map!
     (:map telega-msg-button-map
       "k" nil
       "l" nil)))
  (after! all-the-icons
    (add-to-list 'all-the-icons-mode-icon-alist
                 '(telega-root-mode all-the-icons-fileicon "telegram"
                                    :heigt 1.0
                                    :v-adjust -0.2
                                    :face all-the-icons-yellow))
    (add-to-list 'all-the-icons-mode-icon-alist
                 '(telega-chat-mode all-the-icons-fileicon "telegram"
                                    :heigt 1.0
                                    :v-adjust -0.2
                                    :face all-the-icons-blue))))
