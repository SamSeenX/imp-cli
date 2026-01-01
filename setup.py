#!/usr/bin/env python3
from setuptools import setup, find_packages

setup(
    name="imp-cli",
    version="1.0.1",
    description="IMP - Image Optimizer CLI Tool",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    author="SamSeen",
    author_email="samseen@example.com",
    url="https://github.com/SamSeenX/imp-cli",
    license="MIT",
    py_modules=[],
    scripts=["imp"],
    install_requires=[
        "Pillow",
        "rich",
    ],
    python_requires=">=3.8",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Environment :: Console",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: POSIX :: Linux",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
        "Topic :: Multimedia :: Graphics :: Graphics Conversion",
    ],
)
