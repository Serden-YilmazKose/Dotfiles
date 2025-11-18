#!/bin/bash

cd $HOME || exit 0
dd if=/dev/zero of=first_pass bs=8M status=progress
rm first_pass
sync

dd if=/dev/urandom of=second_pass bs=8M status=progress
rm second_pass
sync

dd if=/dev/zero of=third_pass bs=8M status=progress
rm third_pass
sync
