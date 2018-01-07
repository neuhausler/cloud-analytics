#! /bin/sh

if [[ $UID != "0" ]]
then
    echo build_it script needs to be run as root user
    exit 1
fi

export ROOT=/root
export ANALYTICS_DIR=$ROOT/cloud-analytics
export DOCKER_DIR=$ANALYTICS_DIR/docker
export INFLUXDB_DIR=$ROOT/cloud-data/influxdb
export KAPACITOR_DIR=$ROOT/cloud-data/kapacitor
export GRAFANA_DIR=$ROOT/cloud-data/grafana

echo -- Directories used by build_it --
echo $ANALYTICS_DIR
echo $DOCKER_DIR

echo -- Directories created for persistent data storage --
echo $INFLUXDB_DIR
echo $KAPACITOR_DIR
echo $GRAFANA_DIR

echo -- Building ... --

# Create folder for InfluxDB data
mkdir -p $INFLUXDB_DIR

# Create folder for Kapacitor data
mkdir -p $KAPACITOR_DIR

# Create folder for Grafana data
mkdir -p $GRAFANA_DIR

# Build Docker Containers
cd $DOCKER_DIR/grafana
docker build -t grafana:cloud .

cd $DOCKER_DIR/influxdb
docker build -t influxdb:cloud .

cd $DOCKER_DIR/kapacitor
docker build -t kapacitor:cloud .

cd $DOCKER_DIR/telegraf
docker build -t telegraf:cloud .
