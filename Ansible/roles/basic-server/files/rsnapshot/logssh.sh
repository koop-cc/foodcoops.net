#!/bin/sh

# https://www.thomas-krenn.com/de/wiki/Ausf%C3%BChrbare_SSH-Kommandos_per_authorized_keys_einschr%C3%A4nken

if [ -n "$SSH_ORIGINAL_COMMAND" ]
then
  echo "`/bin/date`: $SSH_ORIGINAL_COMMAND" >> $HOME/ssh-command-log
  exec $SSH_ORIGINAL_COMMAND
fi