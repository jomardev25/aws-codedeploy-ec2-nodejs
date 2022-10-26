#!/bin/bash

# Verify to see app working fine or not
curl -v --silent localhost:3000/health 2>&1 | grep ok