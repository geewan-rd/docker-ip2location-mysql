docker-ip2location-mysql
========================

This is a pre-configured, ready-to-run MySQL server with IP2Location Geolocation database setup scripts. It simplifies the development team to install and set up the IP2Location geolocation database in MySQL server. The setup script supports the [commercial database packages](https://www.ip2location.com) and [free LITE package](https://lite.ip2location.com). Please register for a free or commercial account before running this image, as it requires a download token during the setup process.

This docker image support both the IP2Location (DB1 to DB24) and IP2Proxy (PX1 to PX8) database.

### Usage

1. Run this image as daemon using the download token and product code from [IP2Location LITE](https://lite.ip2location.com) or [IP2Location](https://www.ip2location.com).

       docker run --name ip2location -d \
        -p 3306:3306 \
        -e TOKEN={token} \
        -e CODE=DB4IPV6 \
        -e MYSQL_PASSWORD=password \
        fobwifi/ip2location

    **ENV VARIABLE**

    TOKEN – Download token obtained from IP2Location.  
    CODE – The CSV file download code. You may get the download code from your account panel.

    MYSQL_PASSWORD - Password for MySQL admin.

2. The installation may take seconds to minutes depending on your database sizes, downloading speed and hardware specs. You may check the installation status by viewing the container logs. Run the below command to check the container log:

        docker logs -f ip2location

    You should see the line of `=> Setup completed` if you have successfully complete the installation. Also, you should notice the generated password for the MySQL admin login as below:
	
	    mysql -u admin -pSFzxpJbP ip2location_database
	
	Please write down the password somewhere else, as you will need it later for MySQL connection.

### Connect IP2Location database from a container

    docker run --link ip2location:ip2location-db -t -i application_using_the_ip2location_data

Please note that `--link` flag has become the legacy feature of Docker and may eventually be removed. Please use the network bridge to link containers for query. You can read this article of How to connect [IP2Location MySQL docker in Debian container](https://blog.ip2location.com/knowledge-base/how-to-connect-ip2location-mysql-docker-in-debian-container/) to learn more.

### Query for IP information

Below is an example of how to lookup for information of 8.8.8.8 ip address.

    mysql -u admin -pYOUR_MYSQL_PASSWORD -h ip2location-db ip2location_database -e 'SELECT * FROM `ip2location_database` WHERE INET_ATON("8.8.8.8") &lt;= ip_to LIMIT 1'



### Update IP2Location Database

To update your IP2Location database to latest version, please run the following  command:

```
docker exec -it ip2location ./update.sh
```



### Articles and Tutorials

You can visit the below link for more information about this docker image:
[IP2Location Articles and Tutorials](https://blog.ip2location.com)
