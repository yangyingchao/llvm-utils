;;; llvm-utils.el --- description -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;; Code:

(autoload 'llvm-mode "llvm-mode" t)
(autoload 'tablegen-mode "tablegen-mode" t)

(defun llvm-util-setup-find-file-hook ()
  "Setup `find-file-hook'."
  (interactive)
  (add-hook 'find-file-hook
    (lambda () (let ((file (buffer-file-name)))
                 (when (string-match "\\.bc$" file)
                   (unless (featurep 'autodisass-llvm-bitcode)
                     (require 'autodisass-llvm-bitcode))

                   (when (and (executable-find ad-llvm-bitcode-disassembler)
                              (y-or-n-p (format "Disassemble %s using %s? " file
                                                ad-llvm-bitcode-disassembler)))
                     (ad-llvm-bitcode-buffer file)))))))

(provide 'llvm-utils)
;;; llvm-utils.el ends here
