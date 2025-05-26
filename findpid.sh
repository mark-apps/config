#!/bin/bash
port=$1
lsof -i:$port
#lsof -i tcp:port
