(in-package #:nyxt/visual-mode)
(define-command copy-and-exit ()
  (nyxt/web-mode:copy)
  (toggle-mark)
  (visual-mode)  
  )
(define-configuration visual-mode
    ((keymap-scheme (let ((scheme %slot-default%))
                      (keymap:define-key (gethash scheme:vi-normal scheme)
                          "!" 'beginning-line
                          "h" 'end-line
                          "i" 'backward-char
                          "o" 'forward-word
                          "u" 'backward-word
                          "." 'forward-sentence
                          "," 'backward-sentence
                          "m" 'toggle-mark
                          "return" 'copy-and-exit
                          )
                      scheme))))

(in-package #:nyxt-user)
(define-command scroll-half-page-down ()
  "Scroll down by half page height."
  (pflet ((scroll-page-down ()
                            (ps:chain window (scroll-by 0 (/ (ps:@ window inner-height) 2)))))
         (scroll-page-down)))

(define-command scroll-half-page-up ()
  "Scroll up by half page height."
  (pflet ((scroll-page-up ()
                          (ps:chain window (scroll-by 0 (- (/ (ps:@ window inner-height) 2))))))
         (scroll-page-up)))


(defvar *my-global-keymap* (make-keymap "*my-global-keymap*"))
(define-key *my-global-keymap*
    "C-s-isolefttab" 'switch-buffer-previous
    "C-tab" 'switch-buffer-next
    "C-g" 'nyxt/prompt-buffer-mode:cancel-input
    )

(defvar *my-command-mode-keymap* (make-keymap "*my-command-mode-keymap*"))
(define-key *my-command-mode-keymap*
    "," 'nyxt/web-mode:history-backwards
    "." 'nyxt/web-mode:history-forwards
    "t" 'set-url-new-buffer
    "d" 'scroll-half-page-down
    "c" 'nyxt/web-mode:copy
    "v" 'nyxt/web-mode:paste
    "e" 'scroll-half-page-up
    "a" 'nyxt/web-mode:follow-hint-new-buffer-focus
    "f" 'nyxt/vi-mode:vi-insert-mode
    "m" 'nyxt/visual-mode:visual-mode
    "i" 'nyxt/web-mode:scroll-left
    "n" 'nyxt/web-mode:search-buffer
    "N" 'nyxt/web-mode:search-buffers
    "!" 'nyxt/web-mode:focus-first-input-field
    "s" 'nyxt/web-mode:follow-hint
    "p n" 'save-new-password
    "p c" 'copy-password
    "space f" 'execute-command
    "space d" 'delete-buffer
    "space r" 'load-init-file
    "r" 'reopen-last-buffer
    "x" 'delete-current-buffer
    "escape" 'nyxt/prompt-buffer-mode:cancel-input
    )

(defvar *my-insert-mode-keymap* (make-keymap "*my-insert-mode-keymap*"))
(define-key *my-insert-mode-keymap*
    "end" 'nyxt/vi-mode:vi-normal-mode
    ;; "escape" 'nyxt/prompt-buffer-mode:cancel-input
    )

(define-mode my-state-mode ()
  "Dummy mode for the custom key bindings in `*my-command-mode-keymap*'."
  ((keymap-scheme (keymap:make-scheme
                   scheme:vi-insert *my-insert-mode-keymap*
                   scheme:vi-normal *my-command-mode-keymap*))))

(define-mode my-global-mode ()
  "Mode to add custom keybindings"
  ((keymap-scheme :initform (keymap:make-scheme
                             scheme:emacs *my-global-keymap*
                             scheme:vi-normal *my-global-keymap*
                             scheme:vi-insert *my-global-keymap*))))

(define-configuration (buffer web-buffer)
    ((default-modes (append '(my-global-mode my-state-mode vi-normal-mode) %slot-default%))))


(defvar *my-search-engines*
  (list
   '("github" "https://github.com/search?q=~a" "https://github.com/")
   '("google" "https://www.google.com/search?q=~a" "https://www.google.com/")
   ))

(define-configuration buffer
    ((search-engines (append %slot-default%
                             (mapcar (lambda (engine) (apply 'make-search-engine engine))
                                     *my-search-engines*)))))



