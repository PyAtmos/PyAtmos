import pyatmos 

import os
dir_path = os.path.dirname(os.path.realpath(__file__))

atmos = pyatmos.Simulation(
    docker_image="registry.gitlab.com/frontierdevelopmentlab/astrobiology/pyatmos:modified-atmos",
    #docker_image="quickstart-image",
    #code_path="/code/atmos",
    DEBUG=True)

atmos.start()
status = atmos.run(species_concentrations = {},
        max_photochem_iterations=10000, 
        max_clima_steps=500, 
        output_directory=dir_path+'/results'
        )

metadata = atmos.get_metadata()
