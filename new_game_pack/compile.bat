@echo off
SET NGPATH=C:\Program Files\ngPAWS\
%NGPATH%txtpaws -uk -CLEAN -QUIET -I"dat/" code.txp
%NGPATH%\ngpc code.sce
del code.sce
del code.txi
del code.txt
del code.xml
del code.txp.log
del code.blc