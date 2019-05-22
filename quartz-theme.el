;;; quartz-theme.el --- Chill theme inspired by Nikita Tonsky's Alabaster and infamous Nord theme

;; Copyright (c) 2017-present by Filip Miletic

;; Title: Quartz Theme
;; Project: quartz-emacs
;; Version: 0.1.0
;; Author: Filip Miletic <dothemath011@icloud.com>
;; Package-Requires: ((emacs "24"))
;; License: MIT

;;; Commentary:

;; Quartz is a 16 colorspace theme build to run in GUI- and terminal
;; mode with support for many third-party syntax- and UI packages.

;;; References:
;; Awesome Emacs
;;   https://github.com/arcticicestudio/nord-emacs

;;; Code:

(unless (>= emacs-major-version 24)
  (error "Quartz theme requires Emacs 24 or later!"))

(deftheme quartz "An arctic, north-bluish clean and elegant theme")

(defgroup quartz nil
  "Quartz theme customizations.
  The theme has to be reloaded after changing anything in this group."
  :group 'faces)

(defcustom quartz-comment-brightness 10
  "Allows to define a custom comment color brightness with percentage adjust.
The comment color brightness has been increased by 10% by default.
Please see https://github.com/arcticicestudio/quartz-emacs/issues/73 for more details."
  :type 'integer
  :group 'quartz)

(make-obsolete-variable
  'quartz-comment-brightness
  "The custom color brightness feature has been deprecated and will be removed in version 1.0.0!
  The comment color brightness has been increased by 10% by default.
  Please see https://github.com/arcticicestudio/quartz-emacs/issues/73 for more details."
  "0.4.0")

(defcustom quartz-region-highlight nil
  "Allows to set a region highlight style based on the Quartz components.
Valid styles are
    - 'snowstorm' - Uses 'quartz0' as foreground- and 'quartz4' as background
    - 'frost' - Uses 'quartz0' as foreground- and 'quartz8' as background color"
  :type 'string
  :group 'quartz)

(defcustom quartz-uniform-mode-lines nil
  "Enables uniform activate- and inactive mode lines using 'quartz3' as background."
  :type 'boolean
  :group 'quartz)

(setq quartz-theme--brightened-comments '("#4c566a" "#4e586d" "#505b70" "#525d73" "#556076" "#576279" "#59647c" "#5b677f" "#5d6982" "#5f6c85" "#616e88" "#63718b" "#66738e" "#687591" "#6a7894" "#6d7a96" "#6f7d98" "#72809a" "#75829c" "#78859e" "#7b88a1"))

(defun quartz-theme--brightened-comment-color (percent)
  "I need to deprecate comment brightness PERCENT function."
  (nth 10 quartz-theme--brightened-comments))

(make-obsolete
  'quartz-theme--brightened-comment-color
  "The custom color brightness feature has been deprecated and will be removed in version 1.0.0!\
  The comment color brightness has been increased by 10% by default.\
  Please see https://github.com/arcticicestudio/quartz-emacs/issues/73 for more details."
  "0.4.0")

;;;; Color Constants
(let ((class '((class color) (min-colors 89)))
  (quartz0 (if (display-graphic-p) "#0e1416" nil))
  (quartz1 (if (display-graphic-p) "#1B2222" "black"))
  (quartz2 (if (display-graphic-p) "#333C3E" "#434C5E"))
  (quartz3 (if (display-graphic-p) "#3C465A" "brightblack"))
  (quartz4 (if (display-graphic-p) "#9DbFc2" "#D8DEE9"))
  (quartz5 (if (display-graphic-p) "#E5E9F0" "white"))
  (quartz6 (if (display-graphic-p) "#ECEFF4" "brightwhite"))
  (quartz7 (if (display-graphic-p) "#8FdCaB" "cyan"))
  (quartz8 (if (display-graphic-p) "#88C9a9" "brightcyan"))
  (quartz9 (if (display-graphic-p) "#81A1e1" "blue"))
  (quartz10 (if (display-graphic-p) "#5E81bC" "brightblue"))
  (quartz11 (if (display-graphic-p) "#BF616A" "red"))
  (quartz12 (if (display-graphic-p) "#D08770" "brightyellow"))
  (quartz13 (if (display-graphic-p) "#EBCB8B" "yellow"))
  (quartz14 (if (display-graphic-p) "#A3BE8C" "green"))
  (quartz15 (if (display-graphic-p) "#fa5faf" "magenta"))
  (quartz-annotation (if (display-graphic-p) "#D08770" "brightyellow"))
  (quartz-attribute (if (display-graphic-p) "#8FBCBB" "cyan"))
  (quartz-class (if (display-graphic-p) "#8FBCBB" "cyan"))
  (quartz-comment (if (display-graphic-p) (quartz-theme--brightened-comment-color quartz-comment-brightness) "brightblack"))
  (quartz-escape (if (display-graphic-p) "#D08770" "brightyellow"))
  (quartz-method (if (display-graphic-p) "#88C0D0" "brightcyan"))
  (quartz-keyword (if (display-graphic-p) "#daeafa" "blue"))
  (quartz-numeric (if (display-graphic-p) "#B48EAD" "magenta"))
  (quartz-operator (if (display-graphic-p) "#81A1C1" "blue"))
  (quartz-preprocessor (if (display-graphic-p) "#5E81AC" "brightblue"))
  (quartz-punctuation (if (display-graphic-p) "#D8DEE9" "#D8DEE9"))
  (quartz-regexp (if (display-graphic-p) "#EBCB8B" "yellow"))
  (quartz-string (if (display-graphic-p) "#A3BE8C" "green"))
  (quartz-tag (if (display-graphic-p) "#81A1C1" "blue"))
  (quartz-variable (if (display-graphic-p) "#D8DEE9" "#D8DEE9"))
  (quartz-region-highlight-foreground (if (or
    (string= quartz-region-highlight "frost")
    (string= quartz-region-highlight "snowstorm")) "#2E3440" nil))
  (quartz-region-highlight-background (if
    (string= quartz-region-highlight "frost") "#88C0D0"
      (if (string= quartz-region-highlight "snowstorm") "#D8DEE9" "#434C5E")))
  (quartz-uniform-mode-lines-background (if quartz-uniform-mode-lines "#4C566A" "#3B4252")))

;;;; +------------+
;;;; + Core Faces +
;;;; +------------+
  (custom-theme-set-faces
    'quartz
    ;; +--- Base ---+
    `(bold ((,class (:weight bold))))
    `(bold-italic ((,class (:weight bold :slant italic))))
    `(default ((,class (:foreground ,quartz4 :background ,quartz0))))
    `(error ((,class (:foreground ,quartz11 :weight bold))))
    `(escape-glyph ((,class (:foreground ,quartz12))))
    `(font-lock-builtin-face ((,class (:foreground ,quartz9))))
    `(font-lock-comment-face ((,class (:foreground "#00CD30")))) ;;#dfdf8e
    `(font-lock-comment-delimiter-face ((,class (:foreground "#00CD30"))))
    `(font-lock-constant-face ((,class (:foreground ,quartz9))))
    `(font-lock-doc-face ((,class (:foreground "#DFDF8E"))))
    `(font-lock-number-face ((,class ())))
    `(highlight-numbers-number ((,class (:foreground "orchid"))))
    `(font-lock-function-name-face ((,class (:foreground ,quartz8))))
    `(font-lock-keyword-face ((,class (:foreground ,quartz-keyword))))
    `(font-lock-negation-char-face ((,class (:foreground ,quartz9))))
    `(font-lock-preprocessor-face ((,class (:foreground ,quartz10 :weight bold))))
    `(font-lock-reference-face ((,class (:foreground ,quartz9))))
    `(font-lock-regexp-grouping-backslash ((,class (:foreground ,quartz13))))
    `(font-lock-regexp-grouping-construct ((,class (:foreground ,quartz13))))
    `(font-lock-string-face ((,class (:foreground "cyan3"))))
    `(font-lock-type-face ((,class (:foreground ,quartz7))))
    `(font-lock-variable-name-face ((,class (:foreground ,quartz4))))
    `(font-lock-warning-face ((,class (:foreground ,quartz13))))
    `(italic ((,class (:slant italic))))
    `(shadow ((,class (:foreground ,quartz3))))
    `(underline ((,class (:underline t))))
    `(warning ((,class (:foreground ,quartz13 :weight bold))))

    ;; +--- Syntax ---+
    ;; > C
    `(c-annotation-face ((,class (:foreground ,quartz-annotation))))

    ;; > diff
    `(diff-added ((,class (:foreground ,quartz14))))
    `(diff-changed ((,class (:foreground ,quartz13))))
    `(diff-context ((,class (:inherit default))))
    `(diff-file-header ((,class (:foreground ,quartz8))))
    `(diff-function ((,class (:foreground ,quartz7))))
    `(diff-header ((,class (:foreground ,quartz9 :weight bold))))
    `(diff-hunk-header ((,class (:foreground ,quartz9 :background ,quartz0))))
    `(diff-indicator-added ((,class (:foreground ,quartz14))))
    `(diff-indicator-changed ((,class (:foreground ,quartz13))))
    `(diff-indicator-removed ((,class (:foreground ,quartz11))))
    `(diff-nonexistent ((,class (:foreground ,quartz11))))
    `(diff-refine-added ((,class (:foreground ,quartz14))))
    `(diff-refine-changed ((,class (:foreground ,quartz13))))
    `(diff-refine-removed ((,class (:foreground ,quartz11))))
    `(diff-removed ((,class (:foreground ,quartz11))))

    ;; +--- UI ---+
    `(border ((,class (:foreground ,quartz4))))
    `(buffer-menu-buffer ((,class (:foreground ,quartz4 :weight bold))))
    `(button ((,class (:background ,quartz0 :foreground ,quartz8 :box (:line-width 2 :color ,quartz4 :style sunken-button)))))
    `(completions-annotations ((,class (:foreground ,quartz9))))
    `(completions-common-part ((,class (:foreground ,quartz8 :weight bold))))
    `(completions-first-difference ((,class (:foreground ,quartz11))))
    `(custom-button ((,class (:background ,quartz0 :foreground ,quartz8 :box (:line-width 2 :color ,quartz4 :style sunken-button)))))
    `(custom-button-mouse ((,class (:background ,quartz4 :foreground ,quartz0 :box (:line-width 2 :color ,quartz4 :style sunken-button)))))
    `(custom-button-pressed ((,class (:background ,quartz6 :foreground ,quartz0 :box (:line-width 2 :color ,quartz4 :style sunken-button)))))
    `(custom-button-pressed-unraised ((,class (:background ,quartz4 :foreground ,quartz0 :box (:line-width 2 :color ,quartz4 :style sunken-button)))))
    `(custom-button-unraised ((,class (:background ,quartz0 :foreground ,quartz8 :box (:line-width 2 :color ,quartz4 :style sunken-button)))))
    `(custom-changed ((,class (:foreground ,quartz13))))
    `(custom-comment ((,class (:foreground ,quartz-comment))))
    `(custom-comment-tag ((,class (:foreground ,quartz7))))
    `(custom-documentation ((,class (:foreground ,quartz4))))
    `(custom-group-tag ((,class (:foreground ,quartz8 :weight bold))))
    `(custom-group-tag-1 ((,class (:foreground ,quartz8 :weight bold))))
    `(custom-invalid ((,class (:foreground ,quartz11))))
    `(custom-modified ((,class (:foreground ,quartz13))))
    `(custom-rogue ((,class (:foreground ,quartz12 :background ,quartz2))))
    `(custom-saved ((,class (:foreground ,quartz14))))
    `(custom-set ((,class (:foreground ,quartz8))))
    `(custom-state ((,class (:foreground ,quartz14))))
    `(custom-themed ((,class (:foreground ,quartz8 :background ,quartz2))))
    `(cursor ((,class (:background "#FF25A7"))))
    `(fringe ((,class (:foreground ,quartz4 :background ,quartz0))))
    `(file-name-shadow ((,class (:inherit shadow))))
    `(header-line ((,class (:foreground ,quartz4 :background ,quartz2))))
    `(help-argument-name ((,class (:foreground ,quartz8))))
    `(highlight ((,class (:foreground ,quartz8 :background ,quartz2))))
    `(hl-line ((,class (:background ,quartz1))))
    `(info-menu-star ((,class (:foreground ,quartz9))))
    `(isearch ((,class (:foreground ,quartz0 :background ,quartz8))))
    `(isearch-fail ((,class (:foreground ,quartz11))))
    `(link ((,class (:underline t))))
    `(link-visited ((,class (:underline t))))
    `(linum ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(linum-relative-current-face ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(match ((,class (:inherit isearch))))
    `(message-cited-text ((,class (:foreground ,quartz4))))
    `(message-header-cc ((,class (:foreground ,quartz9))))
    `(message-header-name ((,class (:foreground ,quartz7))))
    `(message-header-newsgroup ((,class (:foreground ,quartz14))))
    `(message-header-other ((,class (:foreground ,quartz4))))
    `(message-header-subject ((,class (:foreground ,quartz8))))
    `(message-header-to ((,class (:foreground ,quartz9))))
    `(message-header-xheader ((,class (:foreground ,quartz13))))
    `(message-mml ((,class (:foreground ,quartz10))))
    `(message-separator ((,class (:inherit shadow))))
    `(minibuffer-prompt ((,class (:foreground ,quartz8 :weight bold))))
    `(mm-command-output ((,class (:foreground ,quartz8))))
    `(mode-line ((,class (:foreground ,quartz4 :background ,quartz1 :box (:line-width 4 :color ,quartz1)))))
    `(mode-line-buffer-id ((,class (:foreground ,quartz15))))
    `(mode-line-highlight ((,class (:inherit highlight))))
    `(mode-line-inactive ((,class (:foreground ,quartz3 :background ,quartz0 :box (:line-width 4 :color ,quartz0)))))
    `(next-error ((,class (:inherit error))))
    `(nobreak-space ((,class (:foreground ,quartz3))))
    `(outline-1 ((,class (:foreground ,quartz8 :weight bold))))
    `(outline-2 ((,class (:inherit outline-1))))
    `(outline-3 ((,class (:inherit outline-1))))
    `(outline-4 ((,class (:inherit outline-1))))
    `(outline-5 ((,class (:inherit outline-1))))
    `(outline-6 ((,class (:inherit outline-1))))
    `(outline-7 ((,class (:inherit outline-1))))
    `(outline-8 ((,class (:inherit outline-1))))
    `(package-description ((,class (:foreground ,quartz4))))
    `(package-help-section-name ((,class (:foreground ,quartz8 :weight bold))))
    `(package-name ((,class (:foreground ,quartz8))))
    `(package-status-available ((,class (:foreground ,quartz7))))
    `(package-status-avail-obso ((,class (:foreground ,quartz7 :slant italic))))
    `(package-status-built-in ((,class (:foreground ,quartz9))))
    `(package-status-dependency ((,class (:foreground ,quartz8 :slant italic))))
    `(package-status-disabled ((,class (:foreground ,quartz3))))
    `(package-status-external ((,class (:foreground ,quartz12 :slant italic))))
    `(package-status-held ((,class (:foreground ,quartz4 :weight bold))))
    `(package-status-new ((,class (:foreground ,quartz14))))
    `(package-status-incompat ((,class (:foreground ,quartz11))))
    `(package-status-installed ((,class (:foreground ,quartz7 :weight bold))))
    `(package-status-unsigned ((,class (:underline ,quartz13))))
    `(query-replace ((,class (:foreground ,quartz8 :background ,quartz2))))
    `(region ((,class (:foreground ,quartz-region-highlight-foreground :background ,quartz-region-highlight-background))))
    `(scroll-bar ((,class (:background ,quartz3))))
    `(secondary-selection ((,class (:background ,quartz2))))
    `(show-paren-match-face ((,class (:foreground ,quartz0 :background ,quartz8))))
    `(show-paren-mismatch-face ((,class (:background ,quartz11))))
    `(success ((,class (:foreground ,quartz14))))
    `(term ((,class (:foreground ,quartz4 :background ,quartz0))))
    `(term-color-black ((,class (:foreground ,quartz1 :background ,quartz1))))
    `(term-color-white ((,class (:foreground ,quartz5 :background ,quartz5))))
    `(term-color-cyan ((,class (:foreground ,quartz7 :background ,quartz7))))
    `(term-color-blue ((,class (:foreground ,quartz8 :background ,quartz8))))
    `(term-color-red ((,class (:foreground ,quartz11 :background ,quartz11))))
    `(term-color-yellow ((,class (:foreground ,quartz13 :background ,quartz13))))
    `(term-color-green ((,class (:foreground ,quartz14 :background ,quartz14))))
    `(term-color-magenta ((,class (:foreground ,quartz15 :background ,quartz15))))
    `(tool-bar ((,class (:foreground ,quartz4 :background ,quartz3))))
    `(tooltip ((,class (:foreground ,quartz0 :background ,quartz4))))
    `(trailing-whitespace ((,class (:foreground ,quartz3))))
    `(tty-menu-disabled-face ((,class (:foreground ,quartz1))))
    `(tty-menu-enabled-face ((,class (:background ,quartz2 foreground ,quartz4))))
    `(tty-menu-selected-face ((,class (:foreground ,quartz8 :underline t))))
    `(undo-tree-visualizer-current-face ((,class (:foreground ,quartz8))))
    `(undo-tree-visualizer-default-face ((,class (:foreground ,quartz4))))
    `(undo-tree-visualizer-unmodified-face ((,class (:foreground ,quartz4))))
    `(undo-tree-visualizer-register-face ((,class (:foreground ,quartz9))))
    `(vc-conflict-state ((,class (:foreground ,quartz12))))
    `(vc-edited-state ((,class (:foreground ,quartz13))))
    `(vc-locally-added-state ((,class (:underline ,quartz14))))
    `(vc-locked-state ((,class (:foreground ,quartz10))))
    `(vc-missing-state ((,class (:foreground ,quartz11))))
    `(vc-needs-update-state ((,class (:foreground ,quartz12))))
    `(vc-removed-state ((,class (:foreground ,quartz11))))
    `(vc-state-base ((,class (:foreground ,quartz4))))
    `(vc-up-to-date-state ((,class (:foreground ,quartz8))))
    `(vertical-border ((,class (:foreground ,quartz2))))
    `(which-func ((,class (:foreground ,quartz8))))
    `(whitespace-big-indent ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-empty ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-hspace ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-indentation ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-line ((,class (:background ,quartz0))))
    `(whitespace-newline ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-space ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-space-after-tab ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-space-before-tab ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-tab ((,class (:foreground ,quartz3 :background ,quartz0))))
    `(whitespace-trailing ((,class (:inherit trailing-whitespace))))
    `(widget-button-pressed ((,class (:foreground ,quartz9 :background ,quartz1))))
    `(widget-documentation ((,class (:foreground ,quartz4))))
    `(widget-field ((,class (:background ,quartz2 :foreground ,quartz4))))
    `(widget-single-line-field ((,class (:background ,quartz2 :foreground ,quartz4))))
    `(window-divider ((,class (:background ,quartz3))))
    `(window-divider-first-pixel ((,class (:background ,quartz3))))
    `(window-divider-last-pixel ((,class (:background ,quartz3))))

    ;;;; +-----------------+
    ;;;; + Package Support +
    ;;;; +-----------------+
    ;; +--- Syntax ---+
    ;; > Auctex
    `(font-latex-bold-face ((,class (:inherit bold))))
    `(font-latex-italic-face ((,class (:inherit italic))))
    `(font-latex-math-face ((,class (:foreground ,quartz8))))
    `(font-latex-sectioning-0-face ((,class (:foreground ,quartz8 :weight bold))))
    `(font-latex-sectioning-1-face ((,class (:inherit font-latex-sectioning-0-face))))
    `(font-latex-sectioning-2-face ((,class (:inherit font-latex-sectioning-0-face))))
    `(font-latex-sectioning-3-face ((,class (:inherit font-latex-sectioning-0-face))))
    `(font-latex-sectioning-4-face ((,class (:inherit font-latex-sectioning-0-face))))
    `(font-latex-sectioning-5-face ((,class (:inherit font-latex-sectioning-0-face))))
    `(font-latex-script-char-face ((,class (:inherit font-lock-warning-face))))
    `(font-latex-string-face ((,class (:inherit font-lock-string-face))))
    `(font-latex-warning-face ((,class (:inherit font-lock-warning-face))))

    ;; > Elixir
    `(elixir-attribute-face ((,class (:foreground ,quartz-annotation))))
    `(elixir-atom-face ((,class (:foreground ,quartz4 :weight bold))))

    ;; > Enhanced Ruby
    `(enh-ruby-heredoc-delimiter-face ((,class (:foreground ,quartz14))))
    `(enh-ruby-op-face ((,class (:foreground ,quartz9))))
    `(enh-ruby-regexp-delimiter-face ((,class (:foreground ,quartz13))))
    `(enh-ruby-regexp-face ((,class (:foreground ,quartz13))))
    `(enh-ruby-string-delimiter-face ((,class (:foreground ,quartz14))))
    `(erm-syn-errline ((,class (:foreground ,quartz11 :underline t))))
    `(erm-syn-warnline ((,class (:foreground ,quartz13 :underline t))))

    ;; > Java Development Environment for Emacs
    `(jdee-db-active-breakpoint-face ((,class (:background ,quartz2 :weight bold))))
    `(jdee-bug-breakpoint-cursor ((,class (:background ,quartz2))))
    `(jdee-db-requested-breakpoint-face ((,class (:foreground ,quartz13 :background ,quartz2 :weight bold))))
    `(jdee-db-spec-breakpoint-face ((,class (:foreground ,quartz14 :background ,quartz2 :weight bold))))
    `(jdee-font-lock-api-face ((,class (:foreground ,quartz4))))
    `(jdee-font-lock-code-face ((,class (:slant italic))))
    `(jdee-font-lock-constant-face ((,class (:foreground ,quartz-keyword))))
    `(jdee-font-lock-constructor-face ((,class (:foreground ,quartz-method))))
    `(jdee-font-lock-doc-tag-face ((,class (:foreground ,quartz7))))
    `(jdee-font-lock-link-face ((,class (:underline t))))
    `(jdee-font-lock-modifier-face ((,class (:foreground ,quartz-keyword))))
    `(jdee-font-lock-number-face ((,class (:foreground ,quartz-numeric))))
    `(jdee-font-lock-operator-fac ((,class (:foreground ,quartz-operator))))
    `(jdee-font-lock-package-face ((,class (:foreground ,quartz-class))))
    `(jdee-font-lock-pre-face ((,class (:foreground ,quartz-comment :slant italic))))
    `(jdee-font-lock-private-face ((,class (:foreground ,quartz-keyword))))
    `(jdee-font-lock-public-face ((,class (:foreground ,quartz-keyword))))
    `(jdee-font-lock-variable-face ((,class (:foreground ,quartz-variable))))

    ;; > JavaScript 2
    `(js2-function-call ((,class (:foreground ,quartz8))))
    `(js2-private-function-call ((,class (:foreground ,quartz8))))
    `(js2-jsdoc-html-tag-delimiter ((,class (:foreground ,quartz6))))
    `(js2-jsdoc-html-tag-name ((,class (:foreground ,quartz9))))
    `(js2-external-variable ((,class (:foreground ,quartz4))))
    `(js2-function-param ((,class (:foreground ,quartz4))))
    `(js2-jsdoc-value ((,class (:foreground ,quartz-comment))))
    `(js2-jsdoc-tag ((,class (:foreground ,quartz7))))
    `(js2-jsdoc-type ((,class (:foreground ,quartz7))))
    `(js2-private-member ((,class (:foreground ,quartz4))))
    `(js2-object-property ((,class (:foreground ,quartz4))))
    `(js2-error ((,class (:foreground ,quartz11))))
    `(js2-warning ((,class (:foreground ,quartz13))))
    `(js2-instance-member ((,class (:foreground ,quartz4))))

    ;; > JavaScript 3
    `(js3-error-face ((,class (:foreground ,quartz11))))
    `(js3-external-variable-face ((,class (:foreground ,quartz4))))
    `(js3-function-param-face ((,class (:foreground ,quartz4))))
    `(js3-instance-member-face ((,class (:foreground ,quartz4))))
    `(js3-jsdoc-html-tag-delimiter-face ((,class (:foreground ,quartz6))))
    `(js3-jsdoc-html-tag-name-face ((,class (:foreground ,quartz9))))
    `(js3-jsdoc-tag-face ((,class (:foreground ,quartz9))))
    `(js3-jsdoc-type-face ((,class (:foreground ,quartz7))))
    `(js3-jsdoc-value-face ((,class (:foreground ,quartz4))))
    `(js3-magic-paren-face ((,class (:inherit show-paren-match-face))))
    `(js3-private-function-call-face ((,class (:foreground ,quartz8))))
    `(js3-private-member-face ((,class (:foreground ,quartz4))))
    `(js3-warning-face ((,class (:foreground ,quartz13))))

    ;; > Markdown
    `(markdown-blockquote-face ((,class (:foreground ,quartz-comment))))
    `(markdown-bold-face ((,class (:inherit bold))))
    `(markdown-header-face-1 ((,class (:foreground ,quartz8))))
    `(markdown-header-face-2 ((,class (:foreground ,quartz8))))
    `(markdown-header-face-3 ((,class (:foreground ,quartz8))))
    `(markdown-header-face-4 ((,class (:foreground ,quartz8))))
    `(markdown-header-face-5 ((,class (:foreground ,quartz8))))
    `(markdown-header-face-6 ((,class (:foreground ,quartz8))))
    `(markdown-inline-code-face ((,class (:foreground ,quartz7))))
    `(markdown-italic-face ((,class (:inherit italic))))
    `(markdown-link-face ((,class (:foreground ,quartz8))))
    `(markdown-markup-face ((,class (:foreground ,quartz9))))
    `(markdown-reference-face ((,class (:inherit markdown-link-face))))
    `(markdown-url-face ((,class (:foreground ,quartz4 :underline t))))

    ;; > Rainbow Delimeters
    `(rainbow-delimiters-depth-1-face ((,class :foreground ,quartz7)))
    `(rainbow-delimiters-depth-2-face ((,class :foreground ,quartz8)))
    `(rainbow-delimiters-depth-3-face ((,class :foreground ,quartz9)))
    `(rainbow-delimiters-depth-4-face ((,class :foreground ,quartz10)))
    `(rainbow-delimiters-depth-5-face ((,class :foreground ,quartz12)))
    `(rainbow-delimiters-depth-6-face ((,class :foreground ,quartz13)))
    `(rainbow-delimiters-depth-7-face ((,class :foreground ,quartz14)))
    `(rainbow-delimiters-depth-8-face ((,class :foreground ,quartz15)))
    `(rainbow-delimiters-unmatched-face ((,class :foreground ,quartz11)))

    ;; > Web Mode
    `(web-mode-attr-tag-custom-face ((,class (:foreground ,quartz-attribute))))
    `(web-mode-builtin-face ((,class (:foreground ,quartz-keyword))))
    `(web-mode-comment-face ((,class (:foreground ,quartz-comment))))
    `(web-mode-comment-keyword-face ((,class (:foreground ,quartz-comment))))
    `(web-mode-constant-face ((,class (:foreground ,quartz-variable))))
    `(web-mode-css-at-rule-face ((,class (:foreground ,quartz-annotation))))
    `(web-mode-css-function-face ((,class (:foreground ,quartz-method))))
    `(web-mode-css-property-name-face ((,class (:foreground ,quartz-keyword))))
    `(web-mode-css-pseudo-class-face ((,class (:foreground ,quartz-class))))
    `(web-mode-css-selector-face ((,class (:foreground ,quartz-keyword))))
    `(web-mode-css-string-face ((,class (:foreground ,quartz-string))))
    `(web-mode-doctype-face ((,class (:foreground ,quartz-preprocessor))))
    `(web-mode-function-call-face ((,class (:foreground ,quartz-method))))
    `(web-mode-function-name-face ((,class (:foreground ,quartz-method))))
    `(web-mode-html-attr-name-face ((,class (:foreground ,quartz-attribute))))
    `(web-mode-html-attr-equal-face ((,class (:foreground ,quartz-punctuation))))
    `(web-mode-html-attr-value-face ((,class (:foreground ,quartz-string))))
    `(web-mode-html-entity-face ((,class (:foreground ,quartz-keyword))))
    `(web-mode-html-tag-bracket-face ((,class (:foreground ,quartz-punctuation))))
    `(web-mode-html-tag-custom-face ((,class (:foreground ,quartz-tag))))
    `(web-mode-html-tag-face ((,class (:foreground ,quartz-tag))))
    `(web-mode-html-tag-namespaced-face ((,class (:foreground ,quartz-keyword))))
    `(web-mode-json-key-face ((,class (:foreground ,quartz-class))))
    `(web-mode-json-string-face ((,class (:foreground ,quartz-string))))
    `(web-mode-keyword-face ((,class (:foreground ,quartz-keyword))))
    `(web-mode-preprocessor-face ((,class (:foreground ,quartz-preprocessor))))
    `(web-mode-string-face ((,class (:foreground ,quartz-string))))
    `(web-mode-symbol-face ((,class (:foreground ,quartz-variable))))
    `(web-mode-type-face ((,class (:foreground ,quartz-class))))
    `(web-mode-warning-face ((,class (:inherit ,font-lock-warning-face))))
    `(web-mode-variable-name-face ((,class (:foreground ,quartz-variable))))

    ;; +--- UI ---+
    ;; > Anzu
    `(anzu-mode-line ((,class (:foreground, quartz8))))
    `(anzu-mode-line-no-match ((,class (:foreground, quartz11))))

    ;; > Avy
    `(avy-lead-face ((,class (:background ,quartz11 :foreground ,quartz5))))
    `(avy-lead-face-0 ((,class (:background ,quartz10 :foreground ,quartz5))))
    `(avy-lead-face-1 ((,class (:background ,quartz3 :foreground ,quartz5))))
    `(avy-lead-face-2 ((,class (:background ,quartz15 :foreground ,quartz5))))

    ;; > Company
    `(company-echo-common ((,class (:foreground ,quartz0 :background ,quartz4))))
    `(company-preview ((,class (:foreground ,quartz4 :background ,quartz10))))
    `(company-preview-common ((,class (:foreground ,quartz0 :background ,quartz8))))
    `(company-preview-search ((,class (:foreground ,quartz0 :background ,quartz8))))
    `(company-scrollbar-bg ((,class (:foreground ,quartz1 :background ,quartz1))))
    `(company-scrollbar-fg ((,class (:foreground ,quartz2 :background ,quartz2))))
    `(company-template-field ((,class (:foreground ,quartz0 :background ,quartz7))))
    `(company-tooltip ((,class (:foreground ,quartz4 :background ,quartz2))))
    `(company-tooltip-annotation ((,class (:foreground ,quartz12))))
    `(company-tooltip-annotation-selection ((,class (:foreground ,quartz12 :weight bold))))
    `(company-tooltip-common ((,class (:foreground ,quartz8))))
    `(company-tooltip-common-selection ((,class (:foreground ,quartz8 :background ,quartz3))))
    `(company-tooltip-mouse ((,class (:inherit highlight))))
    `(company-tooltip-selection ((,class (:background ,quartz3 :weight bold))))

    ;; > diff-hl
   `(diff-hl-change ((,class (:background ,quartz13))))
   `(diff-hl-insert ((,class (:background ,quartz14))))
   `(diff-hl-delete ((,class (:background ,quartz11))))
   
    ;; > Evil
    `(evil-ex-info ((,class (:foreground ,quartz8))))
    `(evil-ex-substitute-replacement ((,class (:foreground ,quartz9))))
    `(evil-ex-substitute-matches ((,class (:inherit isearch))))

    ;; > Flycheck
    `(flycheck-error ((,class (:underline (:style wave :color ,quartz11)))))
    `(flycheck-fringe-error ((,class (:foreground ,quartz11 :weight bold))))
    `(flycheck-fringe-info ((,class (:foreground ,quartz8 :weight bold))))
    `(flycheck-fringe-warning ((,class (:foreground ,quartz13 :weight bold))))
    `(flycheck-info ((,class (:underline (:style wave :color ,quartz8)))))
    `(flycheck-warning ((,class (:underline (:style wave :color ,quartz13)))))

    ;; > Git Gutter
    `(git-gutter:modified ((,class (:foreground ,quartz13))))
    `(git-gutter:added ((,class (:foreground ,quartz14))))
    `(git-gutter:deleted ((,class (:foreground ,quartz11))))

    ;; > Git Gutter Plus
    `(git-gutter+-modified ((,class (:foreground ,quartz13))))
    `(git-gutter+-added ((,class (:foreground ,quartz14))))
    `(git-gutter+-deleted ((,class (:foreground ,quartz11))))

    ;; > Helm
    `(helm-bookmark-addressbook ((,class (:foreground ,quartz7))))
    `(helm-bookmark-directory ((,class (:foreground ,quartz9))))
    `(helm-bookmark-file ((,class (:foreground ,quartz8))))
    `(helm-bookmark-gnus ((,class (:foreground ,quartz10))))
    `(helm-bookmark-info ((,class (:foreground ,quartz14))))
    `(helm-bookmark-man ((,class (:foreground ,quartz4))))
    `(helm-bookmark-w3m ((,class (:foreground ,quartz9))))
    `(helm-buffer-directory ((,class (:foreground ,quartz9))))
    `(helm-buffer-file ((,class (:foreground ,quartz8))))
    `(helm-buffer-not-saved ((,class (:foreground ,quartz13))))
    `(helm-buffer-process ((,class (:foreground ,quartz10))))
    `(helm-candidate-number ((,class (:foreground ,quartz4 :weight bold))))
    `(helm-candidate-number-suspended ((,class (:foreground ,quartz4))))
    `(helm-ff-directory ((,class (:foreground ,quartz9 :weight bold))))
    `(helm-ff-dirs ((,class (:foreground ,quartz9))))
    `(helm-ff-dotted-director ((,class (:foreground ,quartz9 :underline t))))
    `(helm-ff-dotted-symlink-director ((,class (:foreground ,quartz7 :weight bold))))
    `(helm-ff-executable ((,class (:foreground ,quartz8))))
    `(helm-ff-file ((,class (:foreground ,quartz4))))
    `(helm-ff-invalid-symlink ((,class (:foreground ,quartz11 :weight bold))))
    `(helm-ff-prefix ((,class (:foreground ,quartz0 :background ,quartz9))))
    `(helm-ff-symlink ((,class (:foreground ,quartz7))))
    `(helm-grep-cmd-line ((,class (:foreground ,quartz4 :background ,quartz0))))
    `(helm-grep-file ((,class (:foreground ,quartz8))))
    `(helm-grep-finish ((,class (:foreground ,quartz5))))
    `(helm-grep-lineno ((,class (:foreground ,quartz4))))
    `(helm-grep-match ((,class (:inherit isearch))))
    `(helm-grep-running ((,class (:foreground ,quartz8))))
    `(helm-header ((,class (:foreground ,quartz9 :background ,quartz2))))
    `(helm-header-line-left-margin ((,class (:foreground ,quartz9 :background ,quartz2))))
    `(helm-history-deleted ((,class (:foreground ,quartz11))))
    `(helm-history-remote ((,class (:foreground ,quartz4))))
    `(helm-lisp-completion-info ((,class (:foreground ,quartz4 :weight bold))))
    `(helm-lisp-show-completion ((,class (:inherit isearch))))
    `(helm-locate-finish ((,class (:foreground ,quartz14))))
    `(helm-match ((,class (:foreground ,quartz8))))
    `(helm-match-item ((,class (:inherit isearch))))
    `(helm-moccur-buffer ((,class (:foreground ,quartz8))))
    `(helm-resume-need-update ((,class (:foreground ,quartz0 :background ,quartz13))))
    `(helm-selection ((,class (:inherit highlight))))
    `(helm-selection-line ((,class (:background ,quartz2))))
    `(helm-source-header ((,class (:height 1.44 :foreground ,quartz8 :background ,quartz2))))
    `(helm-swoop-line-number-face ((,class (:foreground ,quartz4 :background ,quartz0))))
    `(helm-swoop-target-word-face ((,class (:foreground ,quartz0 :background ,quartz7))))
    `(helm-swoop-target-line-face ((,class (:background ,quartz13 :foreground ,quartz3))))
    `(helm-swoop-target-line-block-face ((,class (:background ,quartz13 :foreground ,quartz3))))
    `(helm-separator ((,class (:background ,quartz2))))
    `(helm-visible-mark ((,class (:background ,quartz2))))

    ;; > Magit
    `(magit-branch ((,class (:foreground ,quartz7 :weight bold))))
    `(magit-diff-context-highlight ((,class (:background ,quartz2))))
    `(magit-diff-file-header ((,class (:foreground ,quartz8 :box (:color ,quartz8)))))
    `(magit-diffstat-added ((,class (:foreground ,quartz14))))
    `(magit-diffstat-removed ((,class (:foreground ,quartz11))))
    `(magit-hash ((,class (:foreground ,quartz8))))
    `(magit-hunk-heading ((,class (:foreground ,quartz9))))
    `(magit-hunk-heading-highlight ((,class (:foreground ,quartz9 :background ,quartz2))))
    `(magit-item-highlight ((,class (:foreground ,quartz8 :background ,quartz2))))
    `(magit-log-author ((,class (:foreground ,quartz7))))
    `(magit-process-ng ((,class (:foreground ,quartz13 :weight bold))))
    `(magit-process-ok ((,class (:foreground ,quartz14 :weight bold))))
    `(magit-section-heading ((,class (:foreground ,quartz7 :weight bold))))
    `(magit-section-highlight ((,class (:background ,quartz2))))

    ;; > MU4E
    `(mu4e-header-marks-face ((,class (:foreground ,quartz9))))
    `(mu4e-title-face ((,class (:foreground ,quartz8))))
    `(mu4e-header-key-face ((,class (:foreground ,quartz8))))
    `(mu4e-highlight-face ((,class (:highlight))))
    `(mu4e-flagged-face ((,class (:foreground ,quartz13))))
    `(mu4e-unread-face ((,class (:foreground ,quartz13 :weight bold))))
    `(mu4e-link-face ((,class (:underline t))))

    ;; > Powerline
    `(powerline-active1 ((,class (:foreground ,quartz4 :background ,quartz1))))
    `(powerline-active2 ((,class (:foreground ,quartz4 :background ,quartz3))))
    `(powerline-inactive1 ((,class (:background ,quartz2))))
    `(powerline-inactive2 ((,class (:background ,quartz2))))

    ;; > Powerline Evil
    `(powerline-evil-base-face ((,class (:foreground ,quartz4))))
    `(powerline-evil-normal-face ((,class (:background ,quartz8))))
    `(powerline-evil-insert-face ((,class (:foreground ,quartz0 :background ,quartz4))))
    `(powerline-evil-visual-face ((,class (:foreground ,quartz0 :background ,quartz7))))
    `(powerline-evil-replace-face ((,class (:foreground ,quartz0 :background ,quartz9))))

    ;; > NeoTree
    `(neo-banner-face ((,class (:foreground ,quartz10))))
    `(neo-dir-link-face ((,class (:foreground ,quartz9))))
    `(neo-expand-btn-face ((,class (:foreground ,quartz6 :bold t))))
    `(neo-file-link-face ((,class (:foreground ,quartz4))))
    `(neo-root-dir-face ((,class (:foreground ,quartz7 :weight bold))))
    `(neo-vc-added-face ((,class (:foreground ,quartz14))))
    `(neo-vc-conflict-face ((,class (:foreground ,quartz11))))
    `(neo-vc-default-face ((,class (:foreground ,quartz4))))
    `(neo-vc-edited-face ((,class (:foreground ,quartz13))))
    `(neo-vc-ignored-face ((,class (:foreground ,quartz3))))
    `(neo-vc-missing-face ((,class (:foreground ,quartz12))))
    `(neo-vc-needs-merge-face ((,class (:background ,quartz12 :foreground ,quartz4))))
    `(neo-vc-needs-update-face ((,class (:background ,quartz10 :foreground ,quartz4))))
    `(neo-vc-removed-face ((,class (:foreground ,quartz11 :strike-through nil))))
    `(neo-vc-up-to-date-face ((,class (:foreground ,quartz4))))
    `(neo-vc-user-face ((,class (:foreground ,quartz4))))

    ;; > Org
    `(org-level-1 ((,class (:foreground ,quartz8 :weight bold))))
    `(org-level-2 ((,class (:inherit org-level-1))))
    `(org-level-3 ((,class (:inherit org-level-1))))
    `(org-level-4 ((,class (:inherit org-level-1))))
    `(org-level-5 ((,class (:inherit org-level-1))))
    `(org-level-6 ((,class (:inherit org-level-1))))
    `(org-level-7 ((,class (:inherit org-level-1))))
    `(org-level-8 ((,class (:inherit org-level-1))))
    `(org-agenda-structure ((,class (:foreground ,quartz9))))
    `(org-agenda-date ((,class (:foreground ,quartz8 :underline nil))))
    `(org-agenda-done ((,class (:foreground ,quartz14))))
    `(org-agenda-dimmed-todo-face ((,class (:background ,quartz13))))
    `(org-block ((,class (:foreground ,quartz4))))
    `(org-block-background ((,class (:background ,quartz0))))
    `(org-block-begin-line ((,class (:foreground ,quartz7))))
    `(org-block-end-line ((,class (:foreground ,quartz7))))
    `(org-checkbox ((,class (:foreground ,quartz9))))
    `(org-checkbox-statistics-done ((,class (:foreground ,quartz14))))
    `(org-checkbox-statistics-todo ((,class (:foreground ,quartz13))))
    `(org-code ((,class (:foreground ,quartz7))))
    `(org-column ((,class (:background ,quartz2))))
    `(org-column-title ((,class (:inherit org-column :weight bold :underline t))))
    `(org-date ((,class (:foreground ,quartz8))))
    `(org-document-info ((,class (:foreground ,quartz4))))
    `(org-document-info-keyword ((,class (:foreground ,quartz3 :weight bold))))
    `(org-document-title ((,class (:foreground ,quartz8 :weight bold))))
    `(org-done ((,class (:foreground ,quartz14 :weight bold))))
    `(org-ellipsis ((,class (:foreground ,quartz3))))
    `(org-footnote ((,class (:foreground ,quartz8))))
    `(org-formula ((,class (:foreground ,quartz9))))
    `(org-hide ((,class (:foreground ,quartz0 :background ,quartz0))))
    `(org-link ((,class (:underline t))))
    `(org-scheduled ((,class (:foreground ,quartz14))))
    `(org-scheduled-previously ((,class (:foreground ,quartz13))))
    `(org-scheduled-today ((,class (:foreground ,quartz8))))
    `(org-special-keyword ((,class (:foreground ,quartz9))))
    `(org-table ((,class (:foreground ,quartz9))))
    `(org-todo ((,class (:foreground ,quartz13 :weight bold))))
    `(org-upcoming-deadline ((,class (:foreground ,quartz12))))
    `(org-warning ((,class (:foreground ,quartz13 :weight bold))))
    `(font-latex-bold-face ((,class (:inherit bold))))
    `(font-latex-italic-face ((,class (:slant italic))))
    `(font-latex-string-face ((,class (:foreground ,quartz14))))
    `(font-latex-match-reference-keywords ((,class (:foreground ,quartz9))))
    `(font-latex-match-variable-keywords ((,class (:foreground ,quartz4))))
    `(ido-only-match ((,class (:foreground ,quartz8))))
    `(org-sexp-date ((,class (:foreground ,quartz7))))
    `(ido-first-match ((,class (:foreground ,quartz8 :weight bold))))
    `(ido-subdir ((,class (:foreground ,quartz9))))
    `(org-quote ((,class (:inherit org-block :slant italic))))
    `(org-verse ((,class (:inherit org-block :slant italic))))
    `(org-agenda-date-weekend ((,class (:foreground ,quartz9))))
    `(org-agenda-date-today ((,class (:foreground ,quartz8 :weight bold))))
    `(org-agenda-done ((,class (:foreground ,quartz14))))
    `(org-verbatim ((,class (:foreground ,quartz7))))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
    (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'quartz)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:

;;; quartz-theme.el ends here
