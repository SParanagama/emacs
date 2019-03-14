(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; sagara-functions

(defun previous-blank-line ()
  "Moves to the previous line containing nothing but whitespace."
  (interactive)
  (search-backward-regexp "^[ \t]*\n")
)

(defun next-blank-line ()
  "Moves to the next line containing nothing but whitespace."
  (interactive)
  (forward-line)
  (search-forward-regexp "^[ \t]*\n")
  (forward-line -1)
)

(defun run-post-load ()
  (interactive)
  (menu-bar-mode -1)
)
;;(add-hook 'window-setup-hook 'run-post-load t)

(defun find-other-file-in-other-window ()
  (interactive)
  (find-file-other-window buffer-file-name)
  (ff-find-other-file)
  ;;(other-window -1)
) 

;; sagara-settings

; Determine the underlying operating system
(setq sagara-aquamacs (featurep 'aquamacs))
(setq sagara-linux (featurep 'x))
(setq sagara-win32 (not (or sagara-aquamacs sagara-linux)))

(setq ring-bell-function 'ignore)

(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(setq default-directory "d:/workspace")

;; sagara-c-cpp-settings

(setq cc-search-directories '("."
                              "../inc" "../inc/*" "../../inc/*" "../../../inc/*"
                              "../../inc/*/*" "../../../inc/*/*/*"
                              "../src" "../src/*" "../../src/*" "../../../src/*"
                              "../../src/*/*" "../../../src/*/*/*"
                              "/usr/include" "/usr/local/include/*"))


;; sagara-editor-appearance-settings

;; casey-theme
(set-foreground-color "burlywood3")
(set-background-color "#161616")
(set-cursor-color "#40FF40")
(set-face-attribute 'default t :font "Liberation Mono-11")
(set-face-attribute 'font-lock-builtin-face nil :foreground "#DAB98F")
(set-face-attribute 'font-lock-comment-face nil :foreground "gray50")
(set-face-attribute 'font-lock-constant-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-doc-face nil :foreground "gray50")
(set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-type-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")

;; Load dracula if available
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)


(set-default-font "Liberation Mono 9")
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(split-window-horizontally)
(menu-bar-mode -1)

;; bright-red TODOs
 (setq fixme-modes '(c++-mode c-mode emacs-lisp-mode))
 (make-face 'font-lock-fixme-face)
 (make-face 'font-lock-study-face)
 (make-face 'font-lock-important-face)
 (make-face 'font-lock-note-face)
 (mapc (lambda (mode)
	 (font-lock-add-keywords
	  mode
	  '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
	    ("\\<\\(STUDY\\)" 1 'font-lock-study-face t)
	    ("\\<\\(IMPORTANT\\)" 1 'font-lock-important-face t)
            ("\\<\\(NOTE\\)" 1 'font-lock-note-face t))))
	fixme-modes)
 (modify-face 'font-lock-fixme-face "Red" nil nil t nil t nil nil)
 (modify-face 'font-lock-study-face "Yellow" nil nil t nil t nil nil)
 (modify-face 'font-lock-important-face "Yellow" nil nil t nil t nil nil)
 (modify-face 'font-lock-note-face "Dark Green" nil nil t nil t nil nil)

;; sagara-key-bindings
(global-set-key (kbd "C-M-k") 'next-line)
(global-set-key (kbd "C-M-i") 'previous-line)
(global-set-key (kbd "C-M-j") 'backward-char)
(global-set-key (kbd "C-M-l") 'forward-char)
(global-set-key (kbd "C-M-S-k") 'c-end-of-defun)
(global-set-key (kbd "C-M-S-i") 'c-beginning-of-defun)
(global-set-key (kbd "C-M-S-j") 'backward-word)
(global-set-key (kbd "C-M-S-l") 'forward-word)
(global-set-key (kbd "C-M-,") 'previous-blank-line)
(global-set-key (kbd "C-M-.") 'next-blank-line)
(global-set-key (kbd "C-M-o") 'other-window)
(global-set-key (kbd "C-M-S-o") 'find-other-file-in-other-window)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
