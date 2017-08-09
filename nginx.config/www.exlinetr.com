upstream exlinelive{
    server 127.0.0.1:1000;
}

upstream exlinesandbox{
    server 127.0.0.1:1010;
}

server {

    listen 80;
    listen [::]:80;
    server_name exlinetr.com www.exlinetr.com;
    location / {
        proxy_pass http://exlinelive;
    }
    location /contents/ {
        expires 30d;
        proxy_pass http://exlinelive;
    }
    location /sandbox/ {
        rewrite /sandbox/(.*) /$1 break;
        proxy_pass http://exlinesandbox; 
    }


}