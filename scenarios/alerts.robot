*** Settings ***
Library                         QWeb
Library                         QForce
Library                         QImage

*** Test Cases ***
Handle Different Types Of Alerts
    [Documentation]             Demonstrates handling of different types of alerts and pop-ups in CRT
    [Tags]                      alerts                      popups                      javascript

    # Basic setup
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 chrome

    # Handle basic alert
    VerifyText                  Show Alert
    ClickText                   Show Alert
    # CRT automatically handles the alert and closes it
    VerifyText                  Alert was handled

    # Handle confirmation dialog
    VerifyText                  Show Confirmation
    ClickText                   Show Confirmation
    # CRT will automatically click 'OK' on confirmation dialog
    VerifyText                  Confirmation was accepted

    # Handle prompt dialog with input
    VerifyText                  Show Prompt
    ClickText                   Show Prompt
    TypeText                    prompt-input                Hello World                 # Type text into prompt
    ClickText                   OK                          # Confirm prompt input
    VerifyText                  You entered: Hello World

    # Handle modal dialog
    ClickText                   Open Modal
    UseModal                    on                          # Enable modal handling
    VerifyText                  This is modal content
    ClickText                   Close
    UseModal                    off                         # Disable modal handling
