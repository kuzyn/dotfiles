;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; kuzyn
(setq display-line-numbers-type 'relative)

(defun org-count-subentries (&optional pos match scope level)
  "Return number of subentries for entry at POS.
MATCH and SCOPE are the same as for `org-map-entries', but
SCOPE defaults to 'tree.
By default, all subentries are counted; restrict with LEVEL."
  (interactive)
  (save-excursion
    (goto-char (or pos (point)))
    ;; If we are in the middle ot an entry, use the current heading.
    (org-back-to-heading t)
    (let ((maxlevel (when (and level (org-current-level))
                      (+ level (org-current-level)))))
      (message "%s subentries"
               (1- (length
                    (delq nil
                          (org-map-entries
                           (lambda ()
                             ;; Return true, unless below maxlevel.
                             (or (not maxlevel)
                                 (<= (org-current-level) maxlevel)))
                           match (or scope 'tree)))))))))

