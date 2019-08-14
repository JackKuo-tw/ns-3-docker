from ubuntu:18.04

WORKDIR /root

RUN apt-get update
RUN apt-get install -y gcc g++ python python-dev python-setuptools git mercurial
RUN apt-get install -y python3-setuptools
#RUN apt-get install -y qt5-default mercurial
# For Ubuntu 18.04, python-pygoocanvas is no longer provided. The ns-3.29 release and later upgrades the support to GTK+ version 3, and requires these packages:
RUN apt-get install -y gir1.2-goocanvas-2.0 python-gi python-gi-cairo python-pygraphviz python3-gi python3-gi-cairo python3-pygraphviz gir1.2-gtk-3.0 ipython ipython3
# Support for MPI-based distributed emulation
RUN apt-get install -y openmpi-bin openmpi-common openmpi-doc libopenmpi-dev
# Support for bake build tool:
RUN apt-get install -y autoconf cvs bzr unrar
# Debugging
RUN apt-get install -y gdb valgrind
# Support for utils/check-style.py code style check program
RUN apt-get install -y uncrustify
# Doxygen and related inline documentation:
#RUN apt-get install -y doxygen graphviz imagemagick
#RUN apt-get install -y texlive texlive-extra-utils texlive-latex-extra texlive-font-utils texlive-lang-portuguese dvipng latexmk
# The ns-3 manual and tutorial are written in reStructuredText for Sphinx (doc/tutorial, doc/manual, doc/models), and figures typically in dia (also needs the texlive packages above):
#RUN apt-get install -y python-sphinx dia
# GNU Scientific Library (GSL) support for more accurate 802.11b WiFi error models (not needed for OFDM):
RUN apt-get install -y gsl-bin libgsl-dev libgsl23 libgslcblas0
# Database support for statistics framework
RUN apt-get install -y sqlite sqlite3 libsqlite3-dev
# Xml-based version of the config store (requires libxml2 >= version 2.7)
RUN apt-get install -y libxml2 libxml2-dev
# Support for generating modified python bindings
RUN apt-get install -y cmake libc6-dev libc6-dev-i386 libclang-6.0-dev llvm-6.0-dev automake python-pip
RUN pip install cxxfilt
# A GTK-based configuration system
RUN apt-get install -y libgtk2.0-0 libgtk2.0-dev
# To experiment with virtual machines and ns-3
RUN apt-get install -y vtun lxc
# Support for openflow module (requires some boost libraries)
RUN apt-get install -y  libboost-signals-dev libboost-filesystem-dev

# Download bake - Bake is a new tool for installing, building and finding out the missing requirements for ns-3 in your own environment.
#RUN git clone https://gitlab.com/nsnam/bake
# It is advisable to add bake to your path.
#RUN export BAKE_HOME=`pwd`/bake
#RUN export PATH=$PATH:$BAKE_HOME
#RUN export PYTHONPATH=$PYTHONPATH:$BAKE_HOME
#WORKDIR /root/bake
#RUN ./bake.py check
#RUN ./bake.py configure -e ns-3.29
#RUN ./bake.py show
#RUN ./bake.py deploy
#RUN cd source/ns-3.29 && ./waf configure && ./waf
#RUN cp source/ns-3.29/build/lib/* /usr/lib/

RUN mkdir repos
WORKDIR repos
RUN hg clone http://code.nsnam.org/ns-3-allinone
WORKDIR ns-3-allinone
RUN ./download.py -n ns-3-dev
RUN ./build.py
RUN cp ns-3-dev/build/lib/* /usr/lib
