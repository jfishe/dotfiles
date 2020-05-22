#!/bin/bash

sshd_status=$(service ssh status)
if [[ ${sshd_status} = *"is not running"* ]]; then
  service ssh --full-restart > /dev/null 2>&1
fi
