# OurPlaces

OurPlaces is the a cross-cultural crowdsourcing platform where people from different cultures can share their spatial experiences.

## Note
This repository is originated from [luongvuongnguyen/OurPlaces](https://github.com/luongvuongnguyen/OurPlaces).

## Introduction
The OurPlaces crowdsourcing platform is built based on Java and contains two services: web service and background service. On the web service side, we use Apache Tomcat and Java Server Pages. We decided to use the MySQL database on the background service side to store all datasets collected because it has high reliability and security and on-demand scalability. To handle multiple accesses and tasks with large numbers of data, we decided to use the model-view-controller model for our system.

## Publication realted to OurPlaces dataset
* Luong Vuong Nguyen, Jason J. Jung, and Myunggwon Hwang. OurPlaces: Cross-Cultural Crowdsourcing Platform for Location Recommendation Services. ISPRS International Journal of Geo-Information. https://doi.org/10.3390/ijgi9120711

* Luong Vuong Nguyen, Tri-Hai Nguyen, and Jason J. Jung. Tourism Recommender System based on Cognitive Similarity between Cross-Cultural Users. In Proceeding of 2nd International Workshop on Open and Crowdsourced Location Data (ISOCLoD'21) co-located with IE 2021, Dubai, United Arab Emirates. IOS Press.

## How to run OurPlaces
The codebase is implemented in Java (develop kit 8.0) | Apache Tomcat (64-bit). Package versions used for development are just below.

### Requirements
```
IDE Netbean 12
MySQL 8.0 
Java 8.0
Apache Tomcat 8
```
### Setup and Run
1. Install IDE (Netbean 12)
2. Install MySQL 8.0
* Config MySQL
```
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_DATABASE=ourplaces \
-e MYSQL_USER=root \
-e MYSQL_PASSWORD=ke@cau \ 
```
* Import all .sql file in dataset folder.
3. Create project in Netbean (set port 8084)
4. Run platform in browser
* http://localhost:8084/ourplaces
* Try online version: http://recsys.cau.ac.kr:8084/ourplaces

## Contact
Email: nguyenluongvuong@gmail.com
