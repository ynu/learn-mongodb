FROM nagucc/gitbook-server

ADD src /gitbook/src
ADD README.md /gitbook/
ADD SUMMARY.md /gitbook/

WORKDIR /gitbook
RUN gitbook build

EXPOSE 4000

WORKDIR /gitbook/_book
CMD web-server -p 4000