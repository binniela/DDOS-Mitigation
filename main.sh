limit_req_zone $binary_remote_addr zone=one:10m rate=30r/m;
limit_conn_zone $binary_remote_addr zone=addr:10m;

server {
    client_body_timeout 5s;
    client_header_timeout 5s;

    location /login.html {
        limit_req zone=one;
    }

    location /store/ {
        limit_conn addr 10;
    }

    listen 80;
    server_name localhost;

    #access_log /var/log/nginx/host.access.log main;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
    }

    #error_page 404 /404.html;

    # redirect server error pages to the static page /50x.html
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /usr/share/nginx/html;
    }
}
