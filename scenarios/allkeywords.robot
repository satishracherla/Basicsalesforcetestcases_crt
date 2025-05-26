Here's a comprehensive list of QWeb keywords for web interactions:

Mouse Operations

ClickText              # Clicks text on page
ClickItem             # Clicks element by its text or attribute
ClickElement          # Clicks element found by locator
DoubleClickText       # Double clicks text on page
DoubleClickElement    # Double clicks element
HoverText             # Moves mouse over text
HoverItem             # Moves mouse over element
ScrollText            # Scrolls to text
ScrollTo              # Scrolls to element
DragAndDrop           # Drags element and drops to target

Form Elements

TypeText              # Types text into input field
TypeSecret           # Types password or sensitive data
ClearText            # Clears text from input field
ClickCheckbox        # Clicks checkbox on/off
ClickRadioButton     # Selects radio button
DropDown             # Selects option from dropdown
MultiSelect          # Selects multiple options from list
UploadFile           # Uploads file to input

Verification & Assertions

VerifyText           # Verifies text exists
VerifyNoText         # Verifies text does not exist
VerifyElement        # Verifies element exists
VerifyNoElement      # Verifies element does not exist
VerifyElementText    # Verifies element contains text
VerifyInputValue     # Verifies input field value
VerifyInputStatus    # Verifies if input is enabled/disabled
VerifyCheckbox       # Verifies checkbox status
IsText               # Returns true/false if text exists

Table Operations

UseTable             # Selects table for operations
VerifyTable          # Verifies table cell content
GetTableCell         # Gets cell content
ClickCell            # Clicks cell in table
TypeIntoCell         # Types into table cell

Frame & Window Operations

UseFrame             # Switches to frame
UseModal             # Switches to modal dialog
SwitchWindow         # Switches between windows
CloseWindow          # Closes current window

Wait Operations

WaitText             # Waits for text to appear
WaitUntilText        # Waits until text appears
WaitForElement       # Waits for element to appear
WaitUntilElement     # Waits until element appears
Sleep                # Pauses execution

Browser Operations

OpenBrowser          # Opens new browser
GoTo                 # Navigates to URL
RefreshPage          # Refreshes current page
MaximizeBrowser      # Maximizes browser window
CloseBrowser         # Closes current browser
CloseAllBrowsers     # Closes all browsers

Alert & Popup Handling

HandleAlert          # Handles JavaScript alerts
AcceptAlert          # Accepts alert dialog
DismissAlert         # Dismisses alert dialog
VerifyAlert          # Verifies alert text

JavaScript Execution

ExecuteJavascript    # Executes JavaScript code
GetJavascriptValue   # Gets value from JavaScript

Example usage in a test case:


*** Settings ***
Library           QForce
Suite Setup       Setup Browser
Suite Teardown    Close All Browsers

*** Test Cases ***
Web Interface Operations Example
    [Documentation]    Demonstrates various web interface operations
    [Tags]            example    web-ops
    
    # Navigation
    GoTo              https://example.com
    
    # Form Operations
    TypeText          Username    testuser
    TypeSecret        Password    mysecretpass
    ClickCheckbox     Remember me    on
    DropDown          Country    United States
    
    # Mouse Operations
    HoverText         Help
    ClickText         Submit
    
    # Verification
    VerifyText        Welcome
    VerifyElement     logout-button
    
    # Table Operations
    UseTable          Users Table
    VerifyTable       r1c1    Username
    
    # Wait Operations
    WaitText          Processing    timeout=5
    
    # Alert Handling
    HandleAlert       Accept

*** Keywords ***
Setup Browser
    Open Browser      about:blank    chrome
    SetConfig         DefaultTimeout    20s
Important notes:

All these keywords are part of QWeb library which is included in QForce

Most keywords accept optional parameters like:

timeout: How long to wait for element
anchor: Text near the element to help locate it
index: Which occurrence of element to use
js: Whether to use JavaScript for interaction
Best practices:

Always use text-based locators when possible
Avoid XPath unless absolutely necessary
Set appropriate timeouts for your application
Use proper verification steps
Handle dynamic content appropriately
Configuration options can be set using:

robot
SetConfig    DefaultTimeout    20s
SetConfig    LineBreak        ${EMPTY}
SetConfig    ClickToFocus     True
These keywords cover most web automation scenarios. Remember that QWeb is smart enough to handle many common challenges like:

Dynamic element loading
Shadow DOM
iframes
AJAX updates
Modern web frameworks
The library will automatically wait for elements to be interactive before performing actions, making tests more reliable than traditional Selenium scripts.