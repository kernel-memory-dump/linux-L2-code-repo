#!/bin/bash

set -e  


source config.sh
source logger.sh
source healthcheck-lib.sh

info "test info"
warn "test warn"
error "test error"

### Da li je server ziv?
# Sta god da se desi, ispisemo na terminal i u log
# ako je error, ide u error log naravno i crvena boja na terminalu
check_health
health_status=$?
if [ $health_status -eq 0 ]; then
    info "Initial health check succeeded."
else
    error "Initial health check failed."

fi