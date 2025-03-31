#!/bin/bash
nvidia="__NV_PRIME_RENDER_OFFLOAD=1 \
__GLX_VENDOR_LIBRARY_NAME=nvidia \
__VK_LAYER_NV_optimus=NVIDIA_only"

env $nvidia rofi -show combi -combi-modes "drun,run" -modes combi
