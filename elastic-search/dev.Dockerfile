FROM elasticsearch:5.6.13-alpine
RUN elasticsearch-plugin  install analysis-kuromoji
