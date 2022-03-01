#! /bin/bash

set -e
set -o nounset
set -o pipefail

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
      -t|--transport)
      export UROS_TRANSPORT="$2"
      shift # past argument
      shift # past value
      ;;
      -d|--dev)
      export UROS_AGENT_DEVICE="$2"
      shift # past argument
      shift # past value
      ;;
      -i|--ip)
      export UROS_AGENT_IP="$2"
      shift # past argument
      shift # past value
      ;;
      -p|--port)
      export UROS_AGENT_PORT="$2"
      shift # past argument
      shift # past value
      ;;
      *)    # unknown option
      echo "Unknown argument  $1"
      exit 1
      ;;
  esac
done

function help {
      echo "Configure script need an argument."
      echo "   --transport -t       udp, serial or serial-usb"
      echo "   --ip -i              agent IP in a network-like transport"
      echo "   --port -p            agent port in a network-like transport"
}

function update_meta {
      python3 -c "import sys; import json; c = '-D' +'$2'; s = json.loads(''.join([l for l in sys.stdin])); k = s['names']['$1']['cmake-args']; i = [c.startswith(v.split('=')[0]) for v in k]; k.pop(i.index(True)) if any(i) else None; k.append(c) if len(c.split('=')[1]) else None; print(json.dumps(s,indent=4))" < ../mcu_ws/colcon.meta > ../mcu_ws/colcon_new.meta
      mv ../mcu_ws/colcon_new.meta ../mcu_ws/colcon.meta
}

function remove_meta {
      python3 -c "import sys; import json; c = '-D' +'$2'; s = json.loads(''.join([l for l in sys.stdin])); k = s['names']['$1']['cmake-args']; i = [c.startswith(v.split('=')[0]) for v in k]; k.pop(i.index(True)) if any(i) else None; print(json.dumps(s,indent=4))" < ../mcu_ws/colcon.meta > ../mcu_ws/colcon_new.meta
      mv ../mcu_ws/colcon_new.meta ../mcu_ws/colcon.meta
}


if [ "$UROS_TRANSPORT" == "udp" ]; then

      update_meta "rmw_microxrcedds" "RMW_UXRCE_TRANSPORT="$UROS_TRANSPORT
      update_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_IP="$UROS_AGENT_IP
      update_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_PORT="$UROS_AGENT_PORT

      update_meta "microxrcedds_client" "UCLIENT_PROFILE_CUSTOM_TRANSPORT=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_SERIAL=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_UDP=ON"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_TCP=OFF"

      echo "Configured $UROS_TRANSPORT mode with agent at $UROS_AGENT_IP:$UROS_AGENT_PORT"

elif [ "$UROS_TRANSPORT" == "serial" ]; then
      echo "Using serial device USART."

      echo "Please check firmware/freertos_apps/microros_nucleo_f767zi_extensions/Src/main.c"
      echo "for configuring serial device before build."

      update_meta "microxrcedds_client" "UCLIENT_PROFILE_CUSTOM_TRANSPORT=ON"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_STREAM_FRAMING=ON"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_SERIAL=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_UDP=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_TCP=OFF"

      update_meta "rmw_microxrcedds" "RMW_UXRCE_TRANSPORT=custom"

      remove_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_IP"
      remove_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_PORT"

      echo "Configured $UROS_TRANSPORT mode with agent at USART"
else
      help
fi
