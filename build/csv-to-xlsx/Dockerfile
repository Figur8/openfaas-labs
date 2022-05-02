FROM ghcr.io/openfaas/classic-watchdog:0.2.0 as watchdog

FROM linuxserver/libreoffice:7.2.2

RUN mkdir -p /home/app

# usar a build do go aqui na linha 8
COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog 
RUN chmod +x /usr/bin/fwatchdog

# Add non root user
# RUN addgroup -S app && adduser app -S -G app
# RUN chown app /home/app

WORKDIR /home/app

# USER app
#RUN apk add uuidgen
#RUN echo "#!/bin/bash" > /home/app/start.sh
#RUN echo "RANDOM_NAME=`uuidgen | tr -d '-'`" > /home/app/start.sh
## o input teria que ser feita no go(garantir paralelismo, tem que ser dinâmico, o nascimento desse arquivo precisa ter nome dinâmico(o linux faz isso hoje))
#RUN echo "cat - > \$RANDOM_NAME.csv" >> /home/app/start.sh
#RUN echo 'libreoffice --headless --convert-to xlsx --infilter="CSV:59/44,34,76,1" \$RANDOM_NAME.csv > /dev/null' >> /home/app/start.sh
#RUN echo "cat \$RANDOM_NAME.xlsx" >> /home/app/start.sh
#RUN chmod +x start.sh

RUN echo '#!/bin/bash' > /home/app/start.sh
RUN echo 'RANDOM_NAME=`cat /dev/urandom | tr -cd "a-f0-9" | head -c 32`' >> /home/app/start.sh
RUN echo 'cat - > $RANDOM_NAME.csv' >> /home/app/start.sh
RUN echo 'until libreoffice --headless --convert-to xlsx --infilter="CSV:59/44,34,76,1" $RANDOM_NAME.csv > /dev/null; do sleep 0.5; done;' >> /home/app/start.sh
RUN echo 'cat $RANDOM_NAME.xlsx' >> /home/app/start.sh
RUN echo 'rm $RANDOM_NAME.xlsx' >> /home/app/start.sh
RUN chmod +x start.sh

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
ENV fprocess="/home/app/start.sh"
#
#function
#    return func(run fProcess)
#
# Set to true to see request in function logs
ENV write_debug="true"



EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

ENTRYPOINT ["fwatchdog"]
