#!/bin/bash

# Need to create the directory
if [ ! -d "work" ]; then
    vlib work
fi

# Compile
vlog ../*.v cmd_testing2_tb.v +incdir+..

# Run modelsim
vsim cmd_testing2_tb
