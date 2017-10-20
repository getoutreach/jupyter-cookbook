name 'jupyter'
maintainer 'Henry A'
maintainer_email 'hja22@hja22.co.uk'
license 'MIT'
description 'Installs/Configures Jupyter and runs notebook as a service'
long_description 'Installs/Configures Jupyter and creates, enables and starts a service to run a Jupyter notebook server'
version '0.1.3'
chef_version '>= 12.1' if respond_to?(:chef_version)

supports 'ubuntu', '= 16.04'

issues_url 'https://github.com/hja22/jupyter-cookbook/issues'
source_url 'https://github.com/hja22/jupyter-cookbook'

depends 'poise-python', '~> 1.6'
