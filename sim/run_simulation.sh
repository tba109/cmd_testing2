#!/bin/bash

# Need to create the directory
if [ ! -d "work" ]; then
    vlib work
fi

# Compile
vlog ../*.v phf_testing_tb.v +incdir+..

# Run modelsim
vsim phf_testing_tb
