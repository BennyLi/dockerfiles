#!/usr/bin/env fish

for host in (grep remotehost /home/userless/.offlineimaprc)
  set host (echo "$host" | sed -rn "s/^remotehost\s*=\s*([a-zA-Z\.]+)/\1/p")
  openssl s_client -connect $host:993 < /dev/null 2>/dev/null | openssl x509 -fingerprint -noout -in /dev/stdin
end

offlineimap
