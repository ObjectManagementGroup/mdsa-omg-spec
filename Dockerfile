FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
  make \
  git \
  pandoc \
  biber \
  latexmk \
  texlive-latex-base \
  texlive-latex-recommended \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-bibtex-extra \
  texlive-pictures \
  texlive-xetex \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files (you can adjust this according to your needs)
COPY . .

# Default command
CMD ["make"]