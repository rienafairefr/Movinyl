# -*- coding: utf-8 -*-
from setuptools import setup
from build import *

modules = ['movinyl']
install_requires = [
    'Pillow',
    'PyQt5-stubs',
    'PyQt5',
    'click',
    'ffpb',
    'python-magic']

setup_kwargs = {
    'name': 'movinyl',
    'version': '0.1.0',
    'description': '',
    'long_description': None,
    'author': 'Pataclop',
    'author_email': 'escure.f@gmail.com',
    'maintainer': None,
    'maintainer_email': None,
    'url': None,
    'entry_points': {
        'console_scripts': [
            'movinyl = movinyl.cli:main',
        ],
    },
    'py_modules': modules,
    'install_requires': install_requires,
    'python_requires': '>=3.6,<4.0',
}

build(setup_kwargs)

setup(**setup_kwargs)
