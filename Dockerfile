# Use an official PyTorch base image with GPU support
FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime

# Set the working directory in the container
WORKDIR /app

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone the YOLOv5 repository
# RUN git clone https://github.com/GuiratWalid/Industrial_Object_Detection_3rd_test/

# Change to the YOLOv5 directory
WORKDIR /app/yolov5

# Install Python dependencies
RUN pip install -U -r requirements.txt

# Copy your customized dataset and configuration files into the container
COPY custom_dataset /app/custom_dataset
COPY custom_config.yaml /app/yolov5/data/custom_config.yaml

# (Optional) Download pretrained weights if needed
RUN wget https://github.com/GuiratWalid/Industrial_Object_Detection_3rd_test/blob/main/runs/train/training/weights/best.pt

# (Optional) You may need to modify the yolov5/data/custom_config.yaml file to match your dataset and model configuration

# Expose any necessary ports
EXPOSE 8080

# Set environment variables (if needed)
# ENV MY_VARIABLE=value

# Command to train your YOLOv5 model or run inference
# CMD ["python", "train.py", "--data", "data/custom_config.yaml", "--cfg", "models/yolov5s.yaml", "--weights", ""]

# Or, if you just want to run inference
CMD ["python", "detect.py", "--weights", "runs\train\training\weights\best.pt", "--img", "640", "--conf", "0.5", "--source", "data/tests"]

# Example: CMD ["python", "train.py", "--data", "data/custom_config.yaml", "--cfg", "models/yolov5s.yaml"]

