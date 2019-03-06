#!/bin/sh

helm delete concord > /dev/null 2>&1
helm del --purge concord > /dev/null 2>&1
