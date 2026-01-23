function proxy
  if set -q http_proxy
    set -e http_proxy
    set -e https_proxy
    set -e all_proxy
    set -e HTTP_PROXY
    set -e HTTPS_PROXY
    set -e ALL_PROXY
    echo "Proxy disabled"
  else
    set -gx http_proxy  http://127.0.0.1:7890
    set -gx https_proxy http://127.0.0.1:7890
    set -gx all_proxy   socks5://127.0.0.1:7890
    set -gx HTTP_PROXY  http://127.0.0.1:7890
    set -gx HTTPS_PROXY http://127.0.0.1:7890
    set -gx ALL_PROXY   socks5://127.0.0.1:7890
    echo "Proxy enabled"
  end
end

