# Use PyTorch 1.0 with CUDA 10.0 as a base image
FROM pytorch/pytorch:1.2-cuda10.0-cudnn7-runtime

# Set environment variables for Jupyter
ENV JUPYTER_ENABLE_LAB=yes
ENV RESTARTABLE=yes

# Install Linux packages for ALSA sound support
RUN apt-get update && \
  apt-get install -y alsa-utils musescore fluidsynth && \
  rm -rf /var/lib/apt/lists/*

RUN pip --version
# Update pip
RUN pip install --upgrade pip

# Print Python version
RUN python --version
RUN pip --version

# Install the necessary packages
RUN pip install fastai==1.0.61 pebble==4.5.2 notebook==5.7.9 music21==6.1.0 fluidsynth midi2audio

# Set working directory
WORKDIR /workspace

# Copy current directory contents into the container at /workspace
# COPY . /workspace
RUN cp /usr/share/sounds/sf2/FluidR3_GM.sf2 /workspace/data/font.sf2

# Set an environment variable for ALSA (Optional)
ENV ALSA_CARD=Device

# Expose the port Jupyter will run on
EXPOSE 8888

# Start Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

