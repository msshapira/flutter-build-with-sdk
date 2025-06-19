FROM ghcr.io/cirruslabs/flutter:3.32.0

# install atp packages
RUN apt update && apt install -y protobuf-compiler jq 
# RUN curl -Lo /usr/local/bin/firebase https://firebase.tools/bin/linux/latest
# RUN chmod +x /usr/local/bin/firebase
# Set environment variables
ENV ANDROID_HOME=/opt/android-sdk
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator"

# Install SDK Manager tools
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    cd ${ANDROID_HOME}/cmdline-tools && \
    curl -sSL https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip -o cmdline-tools.zip && \
    unzip cmdline-tools.zip && \
    rm cmdline-tools.zip && \
    mv cmdline-tools latest

# Install common SDK components
RUN yes | sdkmanager --licenses && \
    sdkmanager \
    "platform-tools" \
    "platforms;android-33" \
    "platforms;android-34" \
    "build-tools;34.0.0" \
    "ndk;26.3.11579264" \
    "ndk;27.0.12077973" \
    "cmake;3.22.1"

