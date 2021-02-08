FROM python:3.8.6-slim-buster

RUN apt-get update \
    && apt-get install -y git fontconfig inkscape rclone rsync make texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-xetex latexmk poppler-utils \
    && rm -rf /var/lib/apt/lists/* \
    && pip install virtualenv
