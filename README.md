# Restaurant Service for Tumpang

## Features
Order Service allows users to browse restaurant, and their respective menu items. It features functionality like allowing Restaurant users to create their restaurant and add their own menu items. 

Browsing restaurant also features the functionality to calculate absolute distance and travel distance between the user and the restaurant. This is translated to pollution that could be emitted due to the delivery for a more informed decision by the user. 

This microservice also communicates with two other services - User Service and Order Service to do implicit updates needed.

## Environment Variables
```local_env.yml``` 
- ```RDS_USER```
    - Your postgres username
- ```RDS_PASSWORD```
    - Your postgres password
- ```RDS_ENDPOINT```
    - Connection endpoint to connect to your postgres database
- ```AWS_ACCESS_KEY```
    - nil
- ```AWS_SECRET_KEY```
    - nil
- ```AWS_REGION```
    - The configured AWS region in your instance
- ```USER_SERVICE_ID```
    - nil
- ```OPEN_ROUTES_API_KEY```
    - The key to access Open Routes Service API
- ```BING_MAPS_KEY```
    - The key to access Bing Maps Service API
 
File format:
```sh
RDS_USER: 
RDS_PASSWORD: 
RDS_ENDPOINT: 

AWS_ACCESS_KEY:
AWS_SECRET_KEY: 
AWS_REGION:
USER_SERVICE_ID: 

OPEN_ROUTES_API_KEY: 
BING_MAPS_KEY:

```

## Dependencies
1. Ensure you have PostgresQL running
2. Configure ```config/local_env.yml``` with above environment variables in order for your service to work.
3. Ensure that you have setup the database migrations 
  ```sh
  rails db:create db:migrate
  ```
## Running on your local machine
1. Ensure you have docker installed on your machine
2. Run these two commands
  ```sh
  docker build -t restaurant-service .
  docker run -p 3000:3000 restaurant-service
  ```
  Notice that you are listening on port 3000 and need to configure it yourself if you want to run the 3 microservices at the same time
  
