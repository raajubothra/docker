  FROM nginx:latest
    LABEL "owner"="raju" "email"="rajubothra123@gmail.com"
    RUN apt update -y && apt install nginx jq unzip vim git iputils-ping -y
    RUN rm -rf usr/share/nginx/index.html
    RUN git init 
    RUN git clone https://github.com/raajubothra/sample-website.git
    RUN cp -r sample-website/wedding-site-template-1.0/* /usr/share/nginx/html
    CMD [ "nginx","-g","daemon off;" ]
    
