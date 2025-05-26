*** Settings ***
Documentation                   API Testing examples using Robot Framework
Library                         RequestsLibrary
Library                         Collections

*** Variables ***
${BASE_URL}                     https://api.example.com
${API_KEY}                      your_api_key_here
${USERNAME}                     your_username
${PASSWORD}                     your_password

*** Test Cases ***
Basic API Request Tests
    [Documentation]             Performs basic API requests and validates responses
    Create API Session
    Perform GET Request
    Perform POST Request
    Perform PUT Request
    Perform DELETE Request
    Validate Response Headers
    Test With Query Parameters
    Test With Authentication

*** Keywords ***
Create API Session
    [Documentation]             Creates a session with basic headers
    ${headers}=                 Create Dictionary
    ...                         Content-Type=application/json
    ...                         Authorization=Bearer ${API_KEY}
    Create Session
    ...                         api_session
    ...                         ${BASE_URL}
    ...                         headers=${headers}
    ...                         verify=True

Perform GET Request
    [Documentation]             Performs a GET request and validates response
    ${response}=                GET
    ...                         api_session
    ...                         /api/users
    ...                         expected_status=200

    # Validate response
    Should Be Equal As Numbers                              ${response.status_code}     200
    ${json}=                    Set Variable                ${response.json()}
    Should Not Be Empty         ${json}

Perform POST Request
    [Documentation]             Performs a POST request with data
    ${data}=                    Create Dictionary
    ...                         name=Test User
    ...                         job=Tester

    ${response}=                POST
    ...                         api_session
    ...                         /api/users
    ...                         json=${data}
    ...                         expected_status=201

    # Validate response
    Should Be Equal As Numbers                              ${response.status_code}     201
    ${json}=                    Set Variable                ${response.json()}
    Should Be Equal             ${json['name']}             Test User

Perform PUT Request
    [Documentation]             Performs a PUT request to update data
    ${data}=                    Create Dictionary
    ...                         name=Updated User
    ...                         job=Senior Tester

    ${response}=                PUT
    ...                         api_session
    ...                         /api/users/1
    ...                         json=${data}
    ...                         expected_status=200

    # Validate response
    Should Be Equal As Numbers                              ${response.status_code}     200
    ${json}=                    Set Variable                ${response.json()}
    Should Be Equal             ${json['name']}             Updated User

Perform DELETE Request
    [Documentation]             Performs a DELETE request
    ${response}=                DELETE
    ...                         api_session
    ...                         /api/users/1
    ...                         expected_status=204

    # Validate response
    Should Be Equal As Numbers                              ${response.status_code}     204

Validate Response Headers
    [Documentation]             Validates response headers from a request
    ${response}=                GET
    ...                         api_session
    ...                         /api/users
    ...                         expected_status=200

    ${headers}=                 Set Variable                ${response.headers}
    Should Be Equal             ${headers['Content-Type']}                              application/json; charset=utf-8

Test With Query Parameters
    [Documentation]             Demonstrates using query parameters
    ${params}=                  Create Dictionary
    ...                         page=1
    ...                         per_page=10

    ${response}=                GET
    ...                         api_session
    ...                         /api/users
    ...                         params=${params}
    ...                         expected_status=200

    Should Be Equal As Numbers                              ${response.status_code}     200

Test With Authentication
    [Documentation]             Demonstrates basic authentication
    ${auth}=                    Create List                 ${USERNAME}                 ${PASSWORD}
    Create Session
    ...                         auth_session
    ...                         ${BASE_URL}
    ...                         auth=${auth}
    ...                         verify=True

    ${response}=                GET
    ...                         auth_session
    ...                         /api/secure
    ...                         expected_status=200

    Should Be Equal As Numbers                              ${response.status_code}     200
