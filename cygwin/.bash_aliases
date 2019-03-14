phelp() {
  echo 'Heisenberg Proxy:'
  echo '  hprx Manage Heisenberg HTTP proxy'
}

# Proxy 

hprx() {
  if [ "$1" == "--help" ]; then
    echo "Manage Heisenberg proxy"
    echo "Usage: hp <COMMAND>"
    echo COMMAND: start|stop|status
    return
  fi
  if [ "$1" == "start" ]; then
    echo Starting heisenberg proxy...
    ssh -o "ProxyCommand java -Xmx64m -cp 'C:\Users\cvila\Dev\Perso\local\ssl\out\production\ssl' org.antiloop.ssl.SSLTunnel -p 10.43.216.8:8080 - 37.187.116.136:443" -i "C:\Users\cvila\Documents\Nextcloud\Perso\Serveurs\Kimsufi\ns329449_private.key" -p 443 -l kriss -L 127.0.0.1:3128:127.0.0.1:3128 -S /tmp/sock-heisenberg -M -f -N 37.187.116.136
    echo Proxy started on port 3128
  fi
  if [ "$1" == "stop" ]; then
    echo Stopping heisenberg proxy...
    ssh -S /tmp/sock-heisenberg -p 443 -l kriss -O exit 37.187.116.136
    rm -f /tmp/sock-heisenberg
  fi
  if [ "$1" == "status" ]; then
    STATUS=$(netstat -an | grep LISTEN | grep 3128 | wc -l)
    if [ $STATUS -gt 0 ]; then
      echo "Heisenberg proxy is running..."
    else
      echo "Heisenberg proxy is NOT running..."
    fi
  fi
}

# -------------------------------------------------------------------------------------------------------------------------------------------------------------

echo ""
echo -e '\033[0;36m           ___                /|       __   ___  __   __   __  \033[0m'
echo -e '\033[0;36m |\/| \ / |__  |\ | \  /     /_|_     |__) |__  |__) /__` /  \ \033[0m'
echo -e '\033[0;36m |  |  |  |___ | \|  \/        |      |    |___ |  \ .__/ \__/ \033[0m'
echo ""
export PATH=$PATH:~/dev/perso/env/cygwin/bin
alias myenv="source ~/.bashrc"
echo Type 'phelp' to get help for perso functions
