FROM python:3.7.6

RUN apt-get update \
    && apt-get install -y git fontconfig rclone rsync make lftp openssh-client texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-xetex latexmk poppler-utils \
    && rm -rf /var/lib/apt/lists/* \
    && pip install virtualenv
