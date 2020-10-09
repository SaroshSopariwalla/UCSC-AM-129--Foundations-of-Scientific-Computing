#!/bin/bash
du ../.. | sort -rk3 | head -3 > dirSizes.txt
