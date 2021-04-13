#!/bin/sh
influx << EOF
show databases;
EOF