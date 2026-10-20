# KJ YouTube 渲染机镜像：在 RunPod 官方镜像（自带 SSH 启动脚本）上预装渲染要用的一切，开机即可渲染。
# 不含任何稿件、素材、密钥。Remotion 依赖装在 /opt/remotion/node_modules，渲染工程上传后软链过去。
FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -y -qq ffmpeg curl fonts-noto-cjk \
      libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 \
      libxrandr2 libgbm1 libasound2 libpango-1.0-0 libcairo2 \
 && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y -qq nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -q imageio-ffmpeg

COPY package.json package-lock.json /opt/remotion/
RUN cd /opt/remotion && npm ci --no-audit --no-fund && npx remotion browser ensure \
 && sha256sum package-lock.json > /opt/remotion/LOCK.sha256

LABEL org.opencontainers.image.source=https://github.com/kamui58245824/kj-yt-render
LABEL org.opencontainers.image.description="Remotion render worker for RunPod (Node 20, Chrome headless shell, Noto CJK, ffmpeg)"
