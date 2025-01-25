docker run --gpus all \
  -p 8888:8888 \
  --device /dev/snd \
  --name musicautobot \
  -v ~/tf:/workspace/tf \
  musicautobot
