*** Settings ***
Test Template     Login with Different Data
Resource          ../SeleniumLibrary/BasePage.robot
Resource          ../SeleniumPage/Login.robot
Library           SeleniumLibrary
Library           DataDriver    C://Robot//ERAIL//TestData//LoginData//TestData.csv

*** Variables ***
${browser}        chrome
${URL}            https://opensource-demo.orangehrmlive.com/web/index.php/auth/login

*** Test Cases ***
Login with user ${Name} and password ${password}
    [Tags]    rex
    open

*** Keywords ***
Login with Different Data
    [Arguments]    ${Name}    ${Cred}    ${valid}
    Open Browser    ${URL}
    Maximize Browser Window
    Login to Application    ${Name}    ${Cred}
    Run Keyword If    '${valid}'=='TRUE'    Login is Successful
    ...    ELSE    Login is Failed
    [Teardown]    Close Browser
