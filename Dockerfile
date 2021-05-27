FROM ubuntu:20.04

RUN \
    # run apt-get
    apt-get update -y \
    && apt-get install -y --no-install-recommends \
        # apt-get中にTZ聞かれないように
        tzdata \ 
        curl make \
    && apt-get install -y --no-install-recommends \
        texlive-lang-japanese \
        texlive-latex-extra \
        texlive-luatex \
        texlive-latex-recommended \
        fonts-noto-cjk-extra \
        latexmk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # util script
    && { \
        echo '#!/bin/sh'; \
        echo 'trap "latexmk -c && rm *.dvi" 2'; \
        echo 'latexmk -pvc $1';\
    } > /usr/local/bin/buildtex && chmod 700 /usr/local/bin/buildtex \
    # スライドのテーマ (https://github.com/matze/mtheme)
    && curl -sLO https://github.com/matze/mtheme/archive/master.tar.gz \
    && tar -zxvf master.tar.gz \
    && cd mtheme-master \
    && make sty \
    && mv *.sty /usr/share/texmf/tex/latex/ \
    && cd .. \
    && rm -rf mtheme-master && rm master.tar.gz

ADD ./.latexmkrc /root/.latexmkrc

WORKDIR /tex