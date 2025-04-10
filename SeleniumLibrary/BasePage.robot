*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Click Element
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Click Element    ${locator}

Double Click Element
    [Arguments] ${locator}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Double Click Element ${locator}

Right Click Element
    [Arguments] ${locator}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Open Context Menu ${locator}

Input Text
    [Arguments]    ${locator}    ${value}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Clear Element Text    ${locator}
    SeleniumLibrary.Input Text    ${locator}    ${value}

Get Attribute
    [Arguments] ${locator} ${attribute}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    RETURN    SeleniumLibrary.Get Element Attribute    ${locator} ${attribute}

Get Value
    [Arguments] ${locator}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    RETURN    SeleniumLibrary.Get Value    ${locator}

Select from List By Value
    [Arguments] ${locator} ${value}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Select From List By Value ${locator} ${value}

Select from List By Label
    [Arguments] ${locator} ${label}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Select From List By Label ${locator} ${label}

Select from List By Index
    [Arguments] ${locator} ${index}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Select From List By Index    ${locator} ${index}

Select from List By Value using Collections
    [Arguments] ${locator} ${value}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    ${optionsList}=    SeleniumLibrary.Get WebElements    ${locator}
    FOR    ${options}    IN    @{optionsList}
        ${optiontext}=    SeleniumLibrary.Get Text ${options}
        Run Keyword If    '${optiontext}'=='${value}'    Run Keywords    SeleniumLibrary.Click Element    ${options}
            ... And    Exit
    END

Accept Alert
    Wait Until Keyword Succeeds    1min    5sec    Alert Should Be Present
    Handle Alert    Accept

Dismiss Alert
    Wait Until Keyword Succeeds    1min    5sec    Alert Should Be Present
    Handle Alert    Dismiss

Get Alert Text
    Wait Until Keyword Succeeds    1min    5sec    Alert Should Be Present
    RETURN    Get Alert Message

Switch Frame
    [Arguments]    ${frame_locator}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${frame_locator}
    Select Frame    ${frame_locator}

Unselect from Frame
    Unselect Frame

Scroll to View
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    SeleniumLibrary.Scroll Element Into View    $locator}

Hover Element
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    1min    5sec    Wait Until Element Is Visible    ${locator}
    Mouse Over    ${locator}

Take Screenshot
    Capture Page Screenshot
