(defun tog-php-mode-hook ()
  (setq tab-width 3)
  (setq c-basic-offset tab-width)
  (setq indent-tabs-mode t))
(add-hook 'php-mode-hook 'tog-php-mode-hook)