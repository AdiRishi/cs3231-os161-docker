# BASE IMAGE
# =========
FROM ubuntu:14.04

# UPDATE PACKAGE LIST AND INSTALL REQUIRED PACKAGES
# =================================================
# install vim just because its useful
RUN apt-get update && apt-get install -y \
    wget \
    git \
    gcc \
    libpython2.7 \
    vim

# INSTALL AWESOME VIMRC
# =====================
RUN git clone https://github.com/amix/vimrc.git ~/.vim_runtime
RUN bash ~/.vim_runtime/install_awesome_vimrc.sh

# GET REQUIRED OS161 BINARIES (E.G. bmake)
# =======================================
WORKDIR /home
RUN wget http://www.cse.unsw.edu.au/~cs3231/os161-files/os161-utils_2.0.8.deb
RUN dpkg -i os161-utils_2.0.8.deb && rm os161-utils_2.0.8.deb

# SETUP CONFIG FOR BUILD KERNEL
# =============================
WORKDIR /home/root
RUN wget http://cgi.cse.unsw.edu.au/~cs3231/17s1/assignments/asst3/sys161-asst3.conf && mv sys161-asst3.conf sys161.conf
# Add script for changing the random seed
ADD ./change_random_seed.sh /home/root

# SETUP INIT CONFIG FOR OS161-GDB
# ===============================
 ADD ./.gdbinit-os161 /home/root/.gdbinit

# SETUP INIT CONFIG FOR STANDARD GDB
# ==================================
ADD ./.gdbinit-root /root/.gdbinit

# SETUP GDB PEDA
# ==============
RUN git clone https://github.com/longld/peda.git ~/peda
RUN echo "source ~/peda/peda.py" >> ~/.gdbinit

# COPY OS161 SOURCE CODE INTO THE IMAGE
# =====================================
ADD ./src /home/os161-src

# ADD BUILD SCRIPT
# ================
ADD ./build_kernel.sh /home

# OPTIONAL: BUILD THE KERNEL
# ==========================
# Note: This can be done inside the container as well by running the build_kernel script
RUN /home/build_kernel.sh

# Move the test files folder into the kernel root
# ===============================================
ADD ./testFiles /home/root/testFiles

# SET CWD BACK TO HOME
# ===================
WORKDIR /home

# RUN BASH
# ========
# Note: this image should be run with a -ti option.
# E.g. docker run --rm -ti <image_name>
CMD bash
