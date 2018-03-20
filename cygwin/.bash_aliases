echo Type 'phelp' to get help for perso functions
export PTY_PREFIX=winpty
echo PTY_PREFIX=${PTY_PREFIX}

# -------------------------------------------------------------------------------------------------------------------------------------------------------------

phelp() {
  echo Proxy: pstart pstop pstatus
}

# Proxy 

pstart() {
  ssh -o "ProxyCommand java -Xmx64m -cp 'C:\Perso\dev\local\ssl\out\production\ssl' org.antiloop.ssl.SSLTunnel -p 10.43.216.8:8080 - 37.187.116.136:443" -i "C:\Users\cvila\Documents\Perso\Cloud\Nextcloud\Kriss\Serveurs\Kimsufi\ns329449_private.key" -p 443 -l kriss -L 127.0.0.1:3128:127.0.0.1:3128 -S /tmp/sock-heisenberg -M -f -N 37.187.116.136
}

pstop() {
  ssh -S /tmp/sock-heisenberg -p 443 -l kriss -O exit 37.187.116.136
}

pstatus() {
  STATUS=$(netstat -an | grep LISTEN | grep 3128 | wc -l)
  if [ $STATUS -gt 0 ]; then
    echo "Proxy is running..."
  else
    echo "Proxy is NOT running..."
  fi
}
