*** Settings ***
Suite Setup       Get Environment Configuration
Resource          ../SeleniumLibrary/BasePage.robot
Resource          ../SeleniumPage/Login.robot
Library           SeleniumLibrary
Library           C:/Robot/ERAIL/ExternalLibrary/Environment.py

*** Variables ***
${env}            sit
${browser}        chrome

*** Test Cases ***
TC01_LoginSuccessful
    [Tags]    smoke
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Login to Application    Admin    admin123
    Login is Successful
    [Teardown]    Close Browser

TC01_LoginUnsucessful
    [Tags]    regression
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Login to Application    Admin    admin1234
    Login is Failed
    [Teardown]    Close Browser

*** Keywords ***
Get Environment Configuration
    ${config}=    select_environment    ${env}
    Set Global Variable    ${URL}    ${config['url']}
