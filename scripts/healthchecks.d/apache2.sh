#!/bin/bash
ps aux | grep -v runsv | grep [a]pache || exit 1