#!/bin/bash
cd /container/scripts/healthchecks.d

for i in *; do
  ./$i || exit 1
done