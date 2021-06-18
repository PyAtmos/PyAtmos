FROM ubuntu:20.04
LABEL Will Fawcett <willfaw@gmail.com>

COPY atmos /code/atmos

# Install needed OS pkgs
RUN apt-get update && apt-get install -y --no-install-recommends \
        gfortran \
        build-essential \
        ca-certificates &&\
    rm -rf /var/lib/apt/lists/* &&\
    export ATMOSDIR=/code/atmos &&\
    export TEMPLATENAME=ModernEarth &&\
    export PHOTOCHEMINPUT=${ATMOSDIR}/PHOTOCHEM/INPUTFILES/TEMPLATES/${TEMPLATENAME} &&\
    # Sort out ATMOS files
    cp ${PHOTOCHEMINPUT}/in.dist ${ATMOSDIR}/PHOTOCHEM/ &&\
    cp ${PHOTOCHEMINPUT}/{input_photchem, reactions.rx, parameters.inc, species.dat, PLANET.dat} ${ATMOSDIR}/PHOTOCHEM/INPUTFILES/ &&\
    cp /code/atmos/CLIMA/IO/TEMPLATES/ModernEarth/input_clima.dat  /code/atmos/CLIMA/IO &&\
    # Check correct species file
    echo species.dat; cat ${ATMOSDIR}/PHOTOCHEM/INPUTFILES/species.dat  &&\
    # Compile and run photo
    cd ${ATMOSDIR} && make -f PhotoMake && ./Photo.run &&\
    # Compile and run clima 
    cd ${ATMOSDIR} && make -f ClimaMake && ./Clima.run &&\
    # Make sure we're in the root directory 
    cd / 