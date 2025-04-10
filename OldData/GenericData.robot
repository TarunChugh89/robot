*** Settings ***
Library           Collections
Library           SeleniumLibrary
Library           ../Libraries/ReadXL.py
Variables         ../Libraries/Variables.py
Library           ../Libraries/GenericLib.py
Library           ../Libraries/Generic.py

*** Variables ***
${URL}            https://opensource-demo.orangehrmlive.com/
@{CREDENTIALS}    Admin    admin123
@{Kolea}          DUMMYPROV    Savitha@12
${URL1}           https://sit01cvswe01.dhsie.hawaii.gov/epublicsector_enu
${WSDL}           http://dev02cvsoa01.statehub.hawaii.gov:8001/soa-infra/services/FederalHub/AccountTransferInboundCMS/AccountTransferService?WSDL
${WSDL1}          http://dev02cvsoa01.statehub.hawaii.gov:8001/soa-infra/services/FederalHub/AccountTransferInboundCMS/AccountTransferService?WSDL
@{ffmData}

*** Keywords ***
Login to Application
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    5
    Input Text    id=txtUsername    @{CREDENTIALS}[0]
    Input Text    id=txtPassword    @{CREDENTIALS}[1]
    Click Button    id=btnLogin
    Sleep    10
    Log    Login to application is successfull

Logout From Application
    Click Element    id=welcome
    Click Element    link=Logout
    Sleep    5
    Close Browser

Navigate To
    [Arguments]    ${MainMenu}    ${SubMenu}
    Click Element    ${MainMenu}
    Sleep    3
    Click Element    ${SubMenu}
    Sleep    3

Login to Kolea Application
    Open Browser    ${URL1}    chrome
    Maximize Browser Window
    Click Button    xpath=//button[@id='details-button']
    Click Link    xpath=//a[@id='proceed-link']
    Click Button    xpath=//button[@id='details-button']
    Click Link    xpath=//a[@id='proceed-link']
    Wait Until Element Is Visible    id=userid    1 min
    Input Text    id=userid    @{Kolea}[0]
    Click Element    xpath=//input[@value='Continue']
    # Sleep    10
    Wait Until Element Is Visible    id=Bharosa_Password_PadDataField    1 min
    Input Text    id=Bharosa_Password_PadDataField    @{Kolea}[1]
    Click Element    xpath=//area[@alt='enter']
    Wait Until Element Is Visible    ${Path_Siebel_Salutation_MyHome}    2 min
    Log    Login to application is successfull

Send Soap Request
    [Arguments]    ${arg}
    @{args}    create list    ${arg}    ${WSDL}
    sendXmlRequest    @{args}

Get FFM Data1
    [Arguments]    ${path}    ${sheet}    ${seacrh}
    ${dict}    Create Dictionary
    ${dict}    Get FFM Data    ${path}    0    ${seacrh}
    [Return]    ${dict}

Run AutoIt Script
    [Arguments]    ${path}
    Run Exe    ${path}

Get XML Data
    [Arguments]    ${path}    ${sheet}    ${search}
    ${xmlData}    Create Dictionary
    ${xmldata}    Get FFM Data    ${path}    ${sheet}    ${search}
    [Return]    ${xmlData}

Transform XML Data
    [Arguments]    ${xmlpath}    ${xmlData}
    Transform XML    ${xmlpath}    ${xmlData}

Transform XML Data2
    [Arguments]    ${xmlpath}    ${xmlData}
    Transform XML New    ${xmlpath}    ${xmlData}

Xpath Replacer
    [Arguments]    @{args}
    ${xpath}    changeXpath    @{args}
    [Return]    ${xpath}

Change to String
    [Arguments]    ${string}
    ${string}    ToString    ${string}
    [Return]    ${string}

Get Excel Row No
    [Arguments]    ${path}    ${sheeet}    ${txtSeaxrh}
    ${rowNo}    Get Row    ${path}    ${sheeet}    ${txtSeaxrh}
    [Return]    ${rowNo}

Get Excel Col No
    [Arguments]    ${path}    ${sheeet}    ${txtSeaxrh}
    ${colNo}    Get Col No    ${path}    ${sheeet}    ${txtSeaxrh}
    [Return]    ${colNo}

Update Query
    [Arguments]    ${query}    &{values}
    ${result}    Get Query    ${query}    &{values}
    [Return]    ${result}

Dic Variables
    [Arguments]    &{keypair}
    ${len}    Get Length    ${keypair}
    ${items}    Get Dictionary Items    ${keypair}    false
    FOR    ${key}    ${value}    IN    @{items}
    Log Many    ${key}    ${value}
    # &{keypair['${key}']}
    # Log    &{keypair}[name]
    # log    &{keypair}[add]
    # log    &{keypair}[edu]

Create Dir
    [Arguments]    ${parent}    ${child}
    ${dir}    Create Directory    ${parent}    ${child}
    [Return]    ${dir}

Get Current Time
    ${timestamp}    Get Timestamp
    [Return]    ${timestamp}

Cancatenate
    [Arguments]    ${str1}    ${str2}
    ${str}    Append Xpath    ${str1}    ${str2}
    [Return]    ${str}

Get XL Row Data
    [Arguments]    ${path}    ${sheet}    ${search}
    ${xlData}    Create List
    ${xldata}    Excel Row Data    ${path}    ${sheet}    ${search}
    [Return]    ${xlData}

Write value To Excel Cell
    [Arguments]    ${path}    ${sheet}    ${row}    ${col}    ${txtvalue}
    Write To Xl Cell    ${path}    ${sheet}    ${row}    ${col}    ${txtvalue}

Get FFM ID
    ${ffmId}    Getffm No
    [Return]    ${ffmId}

Get Date of Birth
    ${dob}    Get Date
    [Return]    ${dob}

Get Person Name
    ${name}    Get Name
    [Return]    ${name}

Get SSN No
    ${ssn}    Get Person No
    [Return]    ${ssn}

Transfer Multiple Household XML
    [Arguments]    ${xmlpath}    ${xmlData}
    Transfrom Multiple House Hold    ${xmlpath}    ${xmlData}

Write Dictionary to Excel
    [Arguments]    ${path}    ${sheet}    ${testcase}    ${data}
    Write Dict Values To XL    ${path}    ${sheet}    ${testcase}    ${data}

Replace Xpath
    [Arguments]    @{vars}
    ${xpath}    Change Xpath    @{vars}
    # Get Table Column Position2
    # [Arguments]    ${xpath}    ${columnName}
    # ${colNo}    Gettbl Col No    ${xpath}    ${columnName}
    # [Return]    ${colNo}
    [Return]    ${xpath}

Get Table Col No
    [Arguments]    ${xpath}    ${txtsearch}
    ${count}    Get Element Count    ${xpath}
    Log    ${count}
    Log To Console    ${count}
    FOR    ${i}    IN RANGE    2    ${count}
    ${col}    Convert To String    ${i}
    ${finalxpath}    Append Xpath    ${xpath}    [${col}]
    Log To Console    ${xpath}
    ${a}    Get Text    ${finalxpath}
    Log To Console    ${a}
    Log    ${a}
    ${position}=    Set Variable    if    '${a}'    ==    '${txtsearch}'    ${i}    Exit For Loop
    ELSE    Continue For Loop
    [Return]    ${position}

Get Table Column Position
    [Arguments]    ${xpath}    ${txtsearch}
    ${count}    Get Element Count    ${xpath}
    Log    ${count}
    Log To Console    ${count}
    # ${position}=    Set Variable    ${0}
    FOR    ${i}    IN RANGE    2    ${count}
		${col}    Convert To String    ${i}
		${finalxpath}    Append Xpath    ${xpath}    [${col}]
		Log To Console    ${xpath}
		sleep	4
		${a}    Get Text    ${finalxpath}
		Log To Console    ${a}
		Log    ${a}
		${c}=    Catenate    ${a.strip()}
		${position}=    Set Variable if    '${c}' == '${txtsearch}'    ${i}    ${-1}
		Exit For Loop If    '${c}' == '${txtsearch}'
	END	
    [Return]    ${position}

Get Web Details
    [Arguments]    ${path}    ${account}
    &{credentials}    Get Web Account Details    ${path}    ${account}
    [Return]    ${credentials}
	
Set Screenshot Folder
    [Arguments]    ${testName}
    ${screenshotDir}    Set Variable    C:/AuomationScreenshots    
    ${screenshotDir}    Join Path    ${screenshotDir}    ${testname}
    OperatingSystem.Create Directory    ${screenshotDir}  
    SeleniumLibrary.Set Screenshot Directory    ${screenshotDir}
	
