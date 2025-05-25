*** Settings ***
Resource                        ../resources/common.robot
Library                         QForce
Library                         QImage
Library                         OperatingSystem
Library                         DateTime

Suite Setup                     Open Browser                about:blank                 chrome
Suite Teardown                  Close All Browsers

*** Test Cases ***
Create Account Contact And Export Report
    [Documentation]             Creates Account and Contact, generates Account report and exports to CSV
    # Generate unique account name
    Appstate                    Home
    Generate Unique Account Name
    Generate Unique Contact Name
    # Launch Salesforce and navigate to Accounts
    LaunchApp                   Sales
    ClickText                   Accounts

    # Create new Account
    ClickText                   New
    Sleep                       15
    TypeText                    *Account Name               ${account_unique_name}
    TypeText                    Phone                       +1-415-555-1234
    TypeText                    Website                     www.copadotesting.com
    PickList                    Industry                    Technology
    TypeText                    Employees                   500
    TypeText                    Annual Revenue              1000000
    ClickText                   Save                        partial_match=False

    # Verify Account was created
    Sleep                       10
    ClickText                   Accounts
    VerifyText                  ${account_unique_name}
    Sleep                       5

    # Create associated Contact
    VerifyText                  Contacts
    ClickText                   Contacts
    VerifyText                  New
    ClickText                   New
    Sleep                       10
    TypeText                    First Name                  ${lead_contact_name}
    TypeText                    Last Name                   Smith
    TypeText                    Email                       ${lead_contact_name}.smith@copadotesting.com
    TypeText                    Phone                       +1-415-555-5678
    TypeText                    Title                       QA Engineer

    # Link Contact to Account
    ComboBox                    Search Accounts...          ${account_unique_name}
    ClickText                   Save                        partial_match=False

    # Verify Contact was created and linked
    ClickText                   Contacts
    VerifyText                  ${lead_contact_name} Smith
    VerifyText                  ${account_unique_name}

    # Navigate to Reports
    LaunchApp                   Reports

    # Create new report
    ClickText                   New Report
    TypeText                    Search Report Types...      Accounts
    Sleep                       5
    ClickText                   Accounts
    Sleep                       5
    ClickText                   Start Report
    ClickText                   Save & Run
    ClickText                   Save                        anchor=Cancel
    ClickText                   More Actions - Edit
    ClickText                   Export
    UseModal                    On
    # ClickText                 Formatted ReportExport the report, including the report header, groupings, and filter settings.
    ClickText                   Details Only                partial_match=true
    Sleep                       5
    DropDown                    Format                      Comma Delimited .csv
    ClickText                   Export                      partial_match=False
    UseModal                    Off
    CloseWindow

    # Wait for export to complete
    SwitchWindow              NEW

Lead to Opportunity Conversion Test
    # Create New Lead
    Appstate                    Home
    Generate Unique Lead Name
    LaunchApp                   Sales
    ClickText                   Leads
    ClickText                   New
    UseModal                    On
    TypeText                    First Name                  John
    TypeText                    Last Name                   ${lead_unique_name}
    TypeText                    Company                     Acme Corporation
    TypeText                    Phone                       (555) 123-4567
    TypeText                    Email                       john.${lead_unique_name}@acme.com
    PickList                    Lead Status                 Working - Contacted
    ClickText                   Save                        partial_match=False
    UseModal                    Off

    # Verify Lead was created
    VerifyText                  John ${lead_unique_name}
    VerifyText                  Acme Corporation

    # Convert Lead
    HoverText                   Show more actions
    ClickText                   Show more actions
    ClickText                   Convert
    Sleep                       10
    UseModal                    On
    VerifyText                  Convert Lead
    ClickText                   Convert                     anchor=Cancel
    Sleep                       5
    ClickText                   Convert                     anchor=Cancel

    # Verify Conversion Success
    VerifyText                  Your lead has been converted
    ClickText                   Go to Leads

    # Navigate to Accounts and verify
    ClickText                   Accounts
    ClickText                   Acme Corporation

    # Verify Account Details
    ClickText                   Details
    VerifyField                 Phone                       (555) 123-4567

    # Navigate to related Opportunities
    ClickText                   Related
    ClickText                   Opportunities

    # Verify Opportunity was created
    VerifyText                  Acme Corporation
    VerifyText                  Opportunity
