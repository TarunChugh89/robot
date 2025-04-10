*** Settings ***
Resource          ../SeleniumLibrary/BasePage.robot
Library           SeleniumLibrary

*** Variables ***
${userName}       xpath=//input[@name=\"username\"]
${userName}       xpath=//input[@name="username"]
${password}       xpath=//input[@name="password"]
${submit}         xpath=//button[@type="submit"]
${invalidCredsError}    xpath=//p[text()="Invalid credentials"]
${dashBoardDispalyed}    xpath=//h6[text()="Dashboard"]

*** Keywords ***
Login to Application
    [Arguments]    ${user}    ${pwd}
    Input Text    ${userName}    ${user}
    Input Text    ${password}    ${pwd}
    Click Element    ${submit}

Login is Successful
    Wait Until Keyword Succeeds    30sec    5sec    Element Should Be Visible    ${dashBoardDispalyed}

Login is Failed
    Wait Until Keyword Succeeds    30sec    5sec    Element Should Be Visible    ${invalidCredsError}
