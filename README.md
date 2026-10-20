# kj-yt-render

RunPod 上的 Remotion 渲染机镜像：Node 20、Chrome headless shell、Noto CJK 字体、ffmpeg，以及预装好的 Remotion 依赖（`/opt/remotion/node_modules`）。

`package.json` / `package-lock.json` 要和渲染工程保持一致；工程那边依赖有变化时，把这两个文件同步过来推一次，Actions 会重建 `ghcr.io/kamui58245824/kj-yt-render:latest`。

不包含任何稿件、素材或密钥。
