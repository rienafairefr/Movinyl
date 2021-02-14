import os
from typing import Any, Dict

import pkgconfig
from setuptools_cpp import ExtensionBuilder, Pybind11Extension


opencv4 = pkgconfig.parse('opencv4')
build_kwargs = dict(include_dirs=opencv4['include_dirs'], libraries=opencv4['libraries'], optional=os.environ.get('CIBUILDWHEEL', '0') != '1')

ext_modules = [
    # A basic pybind11 extension in <project_root>/src/disk:
    Pybind11Extension("movinyl.disk", ["src/disk/disk.cpp"], **build_kwargs),
    Pybind11Extension("movinyl.disk_mono", ["src/disk_mono/disk_mono.cpp"], **build_kwargs),
    Pybind11Extension("movinyl.page", ["src/page/page.cpp"], **build_kwargs),
]


def build(setup_kwargs: Dict[str, Any]) -> None:
    setup_kwargs.update(
        {
            "ext_modules": ext_modules,
            "cmdclass": dict(build_ext=ExtensionBuilder),
            "zip_safe": False,
        }
    )