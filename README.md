## local development environment for openwhisk function 

### Requirements
- nodejs
- openwhisk cli

### Usage
1. create function
    ```
    sh create.sh -n test 
    ```
    > this command create folder with index.js and package.json (skeleton) and 
    create openwhisk function
    
2. write code in `test/index.js`
3. test your code in local
    ```
    node local-test.js test
    ```
4. update your code to openwhisk server
    ```
    sh update.sh -n test
    ```
5. test your function with `wsk` command
    ```
    wsk action invoke test --blocking
    ```
6. delete function
    ```
    sh delete.sh -n test
    ```
    > this command delete 'test' folder and delete openwhisk action 'test'
