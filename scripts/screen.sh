#!/bin/bash
while true; do mkdir -p ~/Screenshots/$(date +\%Y-\%m-\%d) && flameshot full -p ~/Screenshots/$(date +\%Y-\%m-\%d)/$(date +\%Y-\%m-\%d-\%H-\%M-\%S).png & sleep 60; done