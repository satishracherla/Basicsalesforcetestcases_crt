*** Settings ***
Library                         RequestsLibrary

*** Variables ***
${BASE_URL}                     https://jsonplaceholder.typicode.com
${RESOURCE}                     /posts

*** Test Cases ***
GET Request Test
    Create Session              jsonplaceholder             ${BASE_URL}
    ${response}=                GET On Session              jsonplaceholder        ${RESOURCE}/1
    Should Be Equal As Integers                             ${response.status_code}                 200

POST Request Test
    Create Session              jsonplaceholder             ${BASE_URL}
    ${data}=                    Create Dictionary           title=Test             body=Sample      userId=1
    ${response}=                POST On Session             jsonplaceholder        ${RESOURCE}      json=${data}
    Should Be Equal As Integers                             ${response.status_code}                 201

PUT Request Test
    Create Session              jsonplaceholder             ${BASE_URL}
    ${data}=                    Create Dictionary           id=1                   title=Updated    body=Content    userId=1
    ${response}=                PUT On Session              jsonplaceholder        ${RESOURCE}/1    json=${data}
    Should Be Equal As Integers                             ${response.status_code}                 200

PATCH Request Test
    Create Session              jsonplaceholder             ${BASE_URL}
    ${data}=                    Create Dictionary           title=Patched Title
    ${response}=                PATCH On Session            jsonplaceholder        ${RESOURCE}/1    json=${data}
    Should Be Equal As Integers                             ${response.status_code}                 200

DELETE Request Test
    Create Session              jsonplaceholder             ${BASE_URL}
    ${response}=                DELETE On Session           jsonplaceholder        ${RESOURCE}/1
    Should Be Equal As Integers                             ${response.status_code}                 200
