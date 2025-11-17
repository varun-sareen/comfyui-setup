#!/bin/bash

# ComfyUI + HunyuanVideo Setup Script for Vast.ai
# This script will run automatically when the instance starts

set -e  # Exit on error

echo "=== Starting ComfyUI + HunyuanVideo Setup ==="

# Update system
apt-get update
apt-get install -y git wget curl python3.10 python3-pip

# Clone ComfyUI to /root/ComfyUI
cd /root
git clone https://github.com/comfyanonymous/ComfyUI
cd /root/ComfyUI

# Install requirements
pip install -r requirements.txt

# Install HunyuanVideo wrapper
git clone https://github.com/kijai/ComfyUI-HunyuanVideoWrapper custom_nodes/ComfyUI-HunyuanVideoWrapper
cd custom_nodes/ComfyUI-HunyuanVideoWrapper
pip install -r requirements.txt
cd /root/ComfyUI

# Download HunyuanVideo models
mkdir -p /root/ComfyUI/models/text_encoders
mkdir -p /root/ComfyUI/models/diffusion_models
mkdir -p /root/ComfyUI/models/vae

echo "=== Downloading CLIP encoder ==="
wget -O /root/ComfyUI/models/text_encoders/clip_l.safetensors \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/clip_l.safetensors?download=true"

echo "=== Downloading LLaVA encoder ==="
wget -O /root/ComfyUI/models/text_encoders/llava_llama3_fp8_scaled.safetensors \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/text_encoders/llava_llama3_fp8_scaled.safetensors?download=true"

echo "=== Downloading HunyuanVideo T2V model ==="
wget -O /root/ComfyUI/models/diffusion_models/hunyuan_video_t2v_720p_bf16.safetensors \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/diffusion_models/hunyuan_video_t2v_720p_bf16.safetensors?download=true"

echo "=== Downloading VAE ==="
wget -O /root/ComfyUI/models/vae/hunyuan_video_vae_bf16.safetensors \
  "https://huggingface.co/Comfy-Org/HunyuanVideo_repackaged/resolve/main/split_files/vae/hunyuan_video_vae_bf16.safetensors?download=true"

echo "=== Setup Complete ==="
