name             'thin'
maintainer       'Nimesh Subramanian'
license          'All rights reserved'
description      'Installs/Configures thin'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
license           'Apache 2.0'

supports 'redhat', '~> 6.0'

depends 'ruby_build'
depends 'runit'
