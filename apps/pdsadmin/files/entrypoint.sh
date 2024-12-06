#!/bin/bash

trap 'echo "Received SIGTERM, exiting gracefully..." ; exit 0' SIGTERM

sleep infinity