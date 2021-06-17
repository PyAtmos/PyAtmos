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
    # Sort out ATMOS files
    cp /code/atmos/PHOTOCHEM/INPUTFILES/TEMPLATES/ModernEarth/in.dist /code/atmos/PHOTOCHEM/in.dist &&\
    cp /code/atmos/PHOTOCHEM/INPUTFILES/TEMPLATES/ModernEarth/input_photchem.dat /code/atmos/PHOTOCHEM/INPUTFILES/ &&\
    cp /code/atmos/PHOTOCHEM/INPUTFILES/TEMPLATES/ModernEarth/reactions.rx /code/atmos/PHOTOCHEM/INPUTFILES/ &&\
    cp /code/atmos/PHOTOCHEM/INPUTFILES/TEMPLATES/ModernEarth/parameters.inc /code/atmos/PHOTOCHEM/INPUTFILES/ &&\
    cp /code/atmos/PHOTOCHEM/INPUTFILES/TEMPLATES/ModernEarth/species.dat /code/atmos/PHOTOCHEM/INPUTFILES/ &&\
    cp /code/atmos/PHOTOCHEM/INPUTFILES/TEMPLATES/ModernEarth/PLANET.dat /code/atmos/PHOTOCHEM/INPUTFILES/ &&\
    cp /code/atmos/CLIMA/IO/TEMPLATES/ModernEarth/input_clima.dat  /code/atmos/CLIMA/IO &&\
    # Check correct species file
    echo species.dat; cat /code/atmos/PHOTOCHEM/INPUTFILES/species.dat  &&\
    # Compile and run photo
    cd /code/atmos && make -f PhotoMake && ./Photo.run &&\
    # Compile and run clima 
    cd /code/atmos && make -f ClimaMake && ./Clima.run &&\
    # Make sure we're in the root directory 
    cd / 
