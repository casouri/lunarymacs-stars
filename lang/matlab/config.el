;;; config.el --- Matlab      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Package

(use-package| matlab-emacs
  :defer t
  :init (require 'matlab))

;;; Config

(setq matlab-shell-command "/Applications/MATLAB_R2018b.app/Contents/MacOS/MATLAB")
(setq matlab-shell-command-switches (list "-nodesktop"))


;;; config.el ends here
