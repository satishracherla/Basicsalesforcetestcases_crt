*** Settings ***
Library                   QForce
Documentation            Test case that demonstrates browser navigation and variable handling
Suite Setup              Setup Browser
Suite Teardown           Close All Browsers

*** Test Cases ***
Navigate To Tutorialspoint
    [Documentation]     Opens Tutorialspoint website and verifies its content
    [Tags]             smoke    tutorial
    GoTo               https://www.tutorialspoint.com/
    VerifyText         Simply Easy Learning
    VerifyText         Tutorials Library

Variable Handling Example
    [Documentation]     Demonstrates the handling of variables and conditional statements
    [Tags]             example    variables
    ${greeting}=       Set Variable    Hello World
    VerifyText         Library        # Verifying something on the page while testing variables
    ${result}=         Set Variable If    100 > 0    Positive    Negative
    
    # Using the variables (in real test cases, you'd use these for actual verification)
    Log               ${greeting}     # Will log: Hello World
    Log               ${result}      # Will log: Positive

*** Keywords ***
Setup Browser
    [Documentation]    Sets up the browser with proper configuration
    Open Browser       about:blank    chrome
    SetConfig         LineBreak      ${EMPTY}        # Prevents automatic TAB after typing
    SetConfig         DefaultTimeout    20s          # Increases default timeout for better reliability
