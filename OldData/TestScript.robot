*** Settings ***
Library           Screenshot
Resource          KOLEA_Key_Words.robot    #Library    SeleniumLibrary    # Library    Selenium2Library
Library           ../Libraries/ExcelRW.py
Variables         ../Libraries/Variables.py
Resource          Generic.robot
Resource          Selenium_With_Wait.robot
Library           ../Libraries/Generic.py
Library           OperatingSystem    #Library    Process library
Resource          ProjectSpecific.robot

*** Variables ***
${Env_WP}         ${EMPTY}
${Env_CP}         ${EMPTY}
${uname}          \    #TESTUSER22    #autoscript
${pwd}            \    #Selcome@111    #Reset#123
${Env_SSD}        ${EMPTY}
${Sec_Ans}        ${EMPTY}
${Nav_uname}      ${EMPTY}
${Nav_pwd}        ${EMPTY}
${WebCredentials}    C:\\RideWorkspace\\KOLEA_AUTOMATION\\WebCredentials.yaml
#${WebCredentials}    ${CURDIR}\\WebCredentials.yaml
#${SiebelEnv}      SiebelSIT01C
${SiebelEnv}      SiebelSIT02C
#${SSDEnv}         SSDSIT01C
${SSDEnv}         SSDSIT02C
${PortalEnv}      PortalSIT02C
${PortalEnv_Navigator}    PortalSIT01C_NAV
${appletButons}    //div[contains(text(),'xxx')]//following-sibling::div//button[contains(@title,'yyy')]
${appletInputRows}    //table[contains(@summary,'applet')]//tbody//tr

*** Keywords ***
Read and Write to Excel
    # ${data}=    Excel_handling
    # log    ${data}
    # ${sht_name}=    Create_Excel
    # log    ${sht_name}
    Print_AllCellData

Get Rows From Excel
    [Arguments]    ${Sheetname}
    ${row_count}=    Get_Row_Count    ${Sheetname}
    log    ${row_count}
    [Return]    ${row_count}

Get Cols From Excel
    [Arguments]    ${Sheetname}
    ${col_count}=    Get_Col_Count    ${Sheetname}
    log    ${col_count}
    ###Reading data from a cell#######
    [Return]    ${col_count}

Read All Data from Excel
    # [Arguments]    ${Sheetname}
    Print_AllCellData1
    # [Return]    ${data}

Excel Read Data
    [Arguments]    ${sheetname}    ${row}    ${col}
    ${data}=    Read_cell_Data    ${sheetname}    ${row}    ${col}
    [Return]    ${data}

Loop over Columns
    ${cols}=    Get Cols From Excel    Test Results
    log    ${cols}
    FOR    ${col}    IN RANGE    1    ${cols}+1
    # \    [return]    ${col}
    ## Learning#####
    ####using sheetname , row, col and msg

Write To Excel
    [Arguments]    ${Excel_Path}    ${SheetName}    ${row}    ${col}    ${msg}
    ${res}=    Write_Data_To_Excel    ${Excel_Path}    ${SheetName}    ${row}    ${col}    ${msg}
    # Print_AllCellData
    ###using only sheetname and message
    [Return]    ${res}

Writing_excel
    [Arguments]    ${Sheet1}    ${msg}
    ${res}=    Write_Excel    ${Sheet1}    ${msg}
    ###create a sheet inside a workbook
    [Return]    ${res}

Create a Sheet
    [Arguments]    ${Sheetname}
    create_new_sheet    ${Sheetname}
    ####Delete a sheet from a workbook

Delete a Sheet
    [Arguments]    ${Sheetname}
    Delete_sheet    ${Sheetname}

Copy data to sheet
    [Arguments]    ${Sheetname1}    ${Sheetname2}
    Copy_Data_To_Other_Sheet    ${Sheetname1}    ${Sheetname2}

sheet using xlrd
    sheet

Handle Security Page
    Wait Until Element Is Visible    xpath=//button[@id='details-button']    1 min
    Click Button    xpath=//button[@id='details-button']    #Handling securty policy
    Wait Until Element Is Visible    xpath=//a[@id='proceed-link']    1 min
    Click Link    xpath=//a[@id='proceed-link']
    Run Keyword And Ignore Error    Click Button    xpath=//button[@id='details-button']
    Run Keyword And Ignore Error    Click Link    xpath=//a[@id='proceed-link']

Create User Account
    # Access LFRY_Portal_SIT01
    ####User create account#######
    Click On Button    ${Path_PP_CA_Apply_Now}
    Wait Until Element Is Visible    ${Path_PP_CA_Create_Account_First_Name}    1 min
    Input Text From Profile    ${Path_PP_CA_Create_Account_First_Name}    \\Create Account\\First_Name
    Input Text From Profile    ${Path_PP_CA_Create_Account_Last_Name}    \\Create Account\\Last_Name
    Input Text From Profile    ${Path_PP_CA_Create_Account_Email}    \\Create Account\\Email
    Input Text From Profile    ${Path_PP_CA_Create_Account_Re_Enter_Email}    \\Create Account\\ReEnter_Email
    ${Keypresent}    ${uname}=    Get value    \\Create Account\\User_Name
    ${time}=    Get time    Seconds
    ${User_name}=    Catenate    ${uname}${time}
    Input Text    ${Path_PP_CA_Create_Account_User_Name}    ${User_name}
    ${uname}=    Get Element Attribute    ${Path_PP_CA_Create_Account_User_Name}    attribute=value
    log    ${uname}
    # Write To Excel    portal users    2    1    ${User_name}
    Input Text From Profile    ${Path_PP_CA_Create_Password}    \\Create Account\\Password
    ${pwd}=    Get Element Attribute    ${Path_PP_CA_Create_Password}    attribute=value
    log    ${pwd}
    # Write To Excel    portal users    2    2    ${pwd}
    Input Text From Profile    ${Path_PP_CA_Create_Re_Enter_Password}    \\Create Account\\ReEnter_Pswd
    sleep    5
    Select From List By index    ${Path_PP_CA_Create_Security_Question_1}    1
    sleep    3
    Input Text From Profile    ${Path_PP_CA_Create_Answer_1}    \\Create Account\\Answer1
    Select From List By index    ${Path_PP_CA_Create_Security_Question_2}    1
    Input Text From Profile    ${Path_PP_CA_Create_Answer_2}    \\Create Account\\Answer2
    Select From List By index    ${Path_PP_CA_Create_Security_Question_3}    1
    Input Text From Profile    ${Path_PP_CA_Create_Answer_3}    \\Create Account\\Answer3
    Select Radio Button From Profile    ${Path_PP_CA_If_Approved_By_State_Of_Hawaii}    \\Create Account\\Counselor
    Click On Button    ${Path_PP_CA_Create_Account}
    Wait Until Element Is Visible    ${Path_PP_Login}    1 min
    Capture Page Screenshot    User_Creation.png
    # log    ${Temp_uname}    ${Temp_Pwd}
    ########LOgin#########
    Click Button    ${Path_PP_Login}
    Input Text    ${Path_PP_Login_Userid}    ${uname}
    Click Button    ${Path_PP_Login_Continue_Btn}
    Input Text    ${Path_PP_Login_Pwd}    ${pwd}
    # Click Element    ${Path_PP_Login_Pwd_Enterkey}
    Press Keys    ${Path_PP_Login_Pwd}    ENTER
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Path_Siebel_Login_Error_Msg}    10 sec
    Run Keyword If    '${status}' == 'False'    Wait Until Keyword Succeeds    2 min    5 sec    Click Element    ${Path_PP_Create_New_Appl}
    ...    ELSE    Run Keywords    Capture Page Screenshot    Login_Page.png
    ...    AND    Close Browser
    ...    AND    FAIL    Client Portal Login Failure
    # [Return]    ${uname}    ${pwd}

Error Login Re-entry
    Input Text    ${Path_Siebel_Signin_Username}    PCHANDU
    Click Button    ${Path_Siebel_Signin_Continue_Btn}
    Input Text    ${Path_Siebel_Signin_Pwd}    MCP0nline*11
    # Click Element    ${Path_Siebel_Signin_Pwd_Enterkey}
    Press Keys    ${Path_PP_Login_Pwd}    ENTER

Portal User Login
    [Arguments]    ${Temp_uname}    ${Temp_Pwd}
    # ${Temp_uname}    ${Temp_Pwd}=    Create User Account
    # Access LFRY_Portal_SIT01
    &{account}    Get Web Details    ${WebCredentials}    ${PortalEnv_Navigator}
    Open Browser    &{account}[URL]    ${BROWSER_chrome}    options=add_argument("--ignore-certificate-errors")    alias=Portal_Nav_SIT01C
    Maximize Browser Window
    Click Button    ${Path_PP_SignIn}
    #Wait Until Element Is Visible    ${Path_PP_Login_Userid}    1 min
    Input Text    ${Path_PP_Login_Userid}    &{account}[UserName]
    Click Button    ${Path_PP_Login_Continue_Btn}
    #Wait Until Element Is Visible    ${Path_PP_Login_Pwd}    1 min
    Input Text    ${Path_PP_Login_Pwd}    &{account}[Password]
    Click Element    ${Path_PP_Login_Pwd_Enterkey}
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Path_Siebel_Login_Error_Msg}    10 sec
    Run Keyword If    '${status}' == 'False'    Wait Until Element Is Visible    ${Path_PP_Create_New_Appl}    2 min
    ...    ELSE    Run Keywords    Capture Page Screenshot    Login_Page.png
    ...    AND    Close Browser
    ...    AND    FAIL    Client Portal Login Failure
    #Wait Until Element Is Visible    ${Path_PP_Create_New_Appl}    1 min
    #Click Button    ${Path_PP_Create_New_Appl}

Verify Security Question
    [Arguments]    ${Sec_Ans}
    ${msg}=    Run Keyword And Ignore Error    Get Text    //div[@class='bharosaPageMessage'][contains(text(), 'security question')]    #//input[@id='Bharosa_Challenge_PadDataField']
    ${error}    Set Variable    Element with locator '//div[@class='bharosaPageMessage'][contains(text(), 'security question')]' not found.
    Run Keyword If    '''@{msg}[1]''' == '''${error}'''    Wait Until Element Is Visible    ${Path_Siebel_Salutation_MyHome}    1 min
    ...    ELSE    Run Keywords    Input Text    xpath=//input[@id='Bharosa_Challenge_PadDataField']    ${Sec_Ans}
    ...    AND    Click Element    ${Path_Siebel_Signin_Pwd_Enterkey}
    ...    AND    Wait Until Element Is Visible    ${Path_Siebel_Salutation_MyHome}    1 min

login same page
    [Arguments]    ${Temp_uname}    ${Temp_Pwd}
    # ${Temp_uname}    ${Temp_Pwd}=    Create User Account
    Click Button    ${Path_PP_Login}
    Wait Until Element Is Visible    ${Path_PP_Login_Userid}    20
    Input Text    ${Path_PP_Login_Userid}    ${Temp_uname}
    Click Button    ${Path_PP_Login_Continue_Btn}
    # Run Keyword If    Page Should Not Contain Element    //div[@id='errorMessage']    Input Text    ${Path_PP_Login_Pwd}    ${Temp_Pwd}
    # ELSE
    # Close Browser
    Wait Until Element Is Visible    ${Path_PP_Login_Pwd}    20
    Input Text    ${Path_PP_Login_Pwd}    ${Temp_Pwd}
    Click Element    ${Path_PP_Login_Pwd_Enterkey}
    # Wait Until Element Is Visible    ${Path_PP_Create_New_Appl}    50

Access LFRY_Portal_SIT01
    [Arguments]    ${Env}
    &{account}    Get Web Details    ${WebCredentials}    ${PortalEnv}
    Open Browser    &{account}[URL]    ${BROWSER_chrome}    options=add_argument("--ignore-certificate-errors")    alias=CP_SIT01C
    #Open Browser    ${Env_Portal}    ${BROWSER_chrome}    options=add_argument("--ignore-certificate-errors")    alias=CP_SIT01C
    Maximize Browser Window
    Wait Until Element Is Visible    ${Path_PP_Signin}    1 min

Login to Worker Portal
    [Arguments]    ${Env}    ${uname}    ${pwd}    ${Sec_Ans}
    &{account}    Get Web Details    ${WebCredentials}    ${SiebelEnv}
    Open Browser    &{account}[URL]    ${BROWSER_chrome}    options=add_argument("--ignore-certificate-errors")    alias=WP_SIT01C
    #Open Browser    ${Env}    ${BROWSER_chrome}    options=add_argument("--ignore-certificate-errors")    alias=WP_SIT01C
    Maximize Browser Window
    #Input Text    ${Path_Siebel_Signin_Username}    ${uname}
    Input Text    ${Path_Siebel_Signin_Username}    &{account}[UserName]
    Click Button    ${Path_Siebel_Signin_Continue_Btn}
    #Input Text    ${Path_Siebel_Signin_Pwd}    ${pwd}
    Input Text    ${Path_Siebel_Signin_Pwd}    &{account}[Password]
    # Click Element    ${Path_Siebel_Signin_Pwd_Enterkey}
    Press Keys    ${Path_Siebel_Signin_Pwd}    ENTER
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Path_Siebel_Login_Error_Msg}    10 sec
    Run Keyword If    '${status}' == 'False'    Wait Until Element Is Visible    ${Path_Siebel_Salutation_MyHome}    2 min
    ...    ELSE    Run Keywords    Capture Page Screenshot    Login_Page.png
    ...    AND    Close Browser
    ...    AND    FAIL    Worker Portal Login Failure
    #Wait Until Element Is Visible    ${Path_Siebel_Salutation_MyHome}    2 min

Login to SSD Portal
    [Arguments]    ${Env}    ${SSD_uname}    ${SSD_pwd}
    &{account}    Get Web Details    ${WebCredentials}    ${SSDEnv}
    Open Browser    &{account}[URL]    ${BROWSER_FireFox}    options=add_argument("--ignore-certificate-errors")    alias=SSD_SIT01C
    #Open Browser    ${SSD_Env}    ${BROWSER_FireFox}    alias=SSD_SIT01C    #${BROWSER_chrome}
    Maximize Browser Window
    #Input Text    ${Path_Siebel_Signin_Username}    ${uname}
    Input Text    ${Path_Siebel_Signin_Username}    &{account}[UserName]
    Click Button    ${Path_Siebel_Signin_Continue_Btn}
    #Input Text    ${Path_Siebel_Signin_Pwd}    ${pwd}
    Input Text    ${Path_Siebel_Signin_Pwd}    &{account}[Password]
    # Click Element    ${Path_Siebel_Signin_Pwd_Enterkey}
    Press Keys    ${Path_Siebel_Signin_Pwd}    ENTER
    Wait Until Element Is Visible    ${Path_SSD_Search}    1 min

Create New Appl On Worker Portal
    Click Link    ${Path_Siebel_Application_Tab}
    Click Link    ${Path_Siebel_Appl_Entry}
    Click Element    ${Path_Siebel_Create_New_Appl}
    Select Frame    ${Path_Siebel_Select_Frame}

Search a Case on worker Portal
    [Arguments]    ${Appl_Cnf_Nbr}
    Click Link    ${Path_Siebel_Cases}
    sleep    10
    Wait Until Element Is Visible    ${Path_Siebel_Confirmation_Nbr}    1 min
    Input Text    ${Path_Siebel_Confirmation_Nbr}    ${Appl_Cnf_Nbr}
    Click Element    ${Path_Siebel_Go_Btn}
    #sleep    4
    Wait Until Element Is Visible    ${Path_Siebel_Case_Name}    1 min
    Click Link    ${Path_Siebel_Case_Name}
    Wait Until Element Is Visible    ${Path_Siebel_Process_Change_Btn}    20 sec

Search an SSD on worker Portal
    [Arguments]    ${Appl_Cnf_Nbr}
    Click Link    ${Path_Siebel_Application_Tab}
    Click Link    xpath=//span/a[text()='SSD Interaction']
    Click Button    xpath=//button[@title='SSD Interaction Documents:Query']
    Input Text    xpath=//input[@id='1_KIES_SSD_Parent_Confirmation_Number']    ${Appl_Cnf_Nbr}
    Click Button    xpath=//button[@title='SSD Interaction Documents:Go']
    ${rows}=    Get Element Count    xpath=//table[@summary='SSD Interaction Documents']//tr[@id]
    BuiltIn.Run Keyword If    ${rows} == 1    log    PASS - SSD record found on Worker portal.
    ...    ELSE    log    FAIL - SSD record not found on Worker portal.
    Capture Page Screenshot    SSD_Record.png

Search a Case on worker Portal Using Case Nbr
    [Arguments]    ${Case_Nbr}
    Click Link    ${Path_Siebel_Cases}
    sleep    7
    Input Text    ${Path_Siebel_Case_Nbr}    ${Case_Nbr}
    Click Element    ${Path_Siebel_Go_Btn}
    Click Link    ${Path_Siebel_Case_Name}

COC
    Click Link    ${Path_Siebel_COC_Tab}
    sleep    5
    Set Focus To Element    ${Path_Siebel_COC_Tab}
    sleep    3
    Click Element    ${Path_Siebel_COC_Resources}
    sleep    5
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    sleep    3
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    \\Resource_Type
    # sleep    3
    # Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    ENTER
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    sleep    2
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    \\Amount
    # Apply for COC Resource Benefit types
    # Click Link    ${Path_Siebel_COC_Tab}
    # sleep    5
    # # Set Focus To Element    ${Path_Siebel_COC_Tab}
    # # sleep    3
    # Mouse Over    ${Path_Siebel_COC_Tab}
    # sleep    2
    # Scroll Element Into View    ${Path_Siebel_COC_Resources}
    # sleep    3
    # Mouse Over    ${Path_Siebel_COC_Resources}
    # sleep    2
    # # Mouse Down On Link    ${Path_Siebel_COC_Tab}
    # Click Link    ${Path_Siebel_COC_Resources}
    # sleep    5
    # Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    # sleep    3
    # Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type}
    # # Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Drpdwn}
    # # sleep    2
    # Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    \\Resource_Type
    # sleep    3
    # # Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    ENTER
    # Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    # # Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount}
    # # Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount}    DELETE
    # # sleep    2
    # # Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount}
    # sleep    2
    # Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    # sleep    2
    # # Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    ${EMPTY}
    # Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    \\Amount
    # # sleep    2
    # Click Button    ${Path_Siebel_Process_Change_Btn}
    # sleep    10
    # Capture Page Screenshot    click_on_PChange.png
    # # Handle Alert    LEAVE    1 min
    # # # Capture Page Screenshot    Post_Procesing_Request.png
    # # sleep    7
    # ${message}=    Handle Alert    ACCEPT    3 min
    # log    ${message}
    # ${status}=    Get Element Attribute    ${Path_Siebel_Case_Status}    attribute=value
    # log    ${status}

Apply for COC Resource Benefit types Using Applet Keywords
    #${appletButons}    //div[contains(text(),'xxx')]//following-sibling::div//button[contains(@title,'yyy')]
    #${appletInputRows}    //table[contains(@summary,'applet')]//tbody//tr
    ${tblHeaders}    Set Variable    //div[div[div[table[contains(@summary,'Resources')]]]]//div//th
    ${keypresent}    ${res_type}=    Get Value    \\Resource_Type
    ${keypresent}    ${amt}=    Get Value    \\Amount
    &{Resource}    Create Dictionary    Resource Type=${res_type}    Resource Value Amount=${amt}
    Access COC Tab Options    ${Path_Siebel_COC_Resources}
    Perform Action On All Applets New    ${appletButons}    ${appletInputRows}    ${tblHeaders}    Resources    New    ${Resource}

Apply for COC Resource Benefit types
    Click Link    ${Path_Siebel_COC_Tab}
    Wait Until Element Is Visible    ${Path_Siebel_COC_ChangeAddr_Btn}    2 min
    Wait Until Keyword Succeeds    1 min    5 sec    Scroll Element Into View    ${Path_Siebel_COC_Contacts_Table}
    Mouse Over    ${Path_Siebel_COC_Tab}
    Click Element    ${Path_Siebel_COC_Resources}
    Wait Until Element Is Visible    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}    2 min
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount}
    Wait Until Keyword Succeeds    50 sec    5 sec    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    \\Amount
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    \\Resource_Type
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    ENTER
    Click Button    ${Path_Siebel_Process_Change_Btn}
    ${popup_msg}=    Wait Until Keyword Succeeds    1 min    5 sec    Handle Alert    ACCEPT    2 min
    ${status}=    Get Element Attribute    ${Path_Siebel_Case_Status}    attribute=value
    log    ${status}
    Wait Until Keyword Succeeds    1 min    5 sec    Scroll Element Into View    xpath=//div[@title='Resources List Applet']//span[@title='Previous record set']
    Capture Page Screenshot    Add_resource.png

MISC
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type}
    Wait Until Keyword Succeeds    50 sec    5 sec    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    \\Resource_Type
    sleep    3
    Click Element    xpath=//td[@id='1_s_3_l_Transferred_Flag']
    #Wait Until Keyword Succeeds    30 sec    5 sec    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Wait Until Keyword Succeeds    50 sec    5 sec    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount}
    Wait Until Keyword Succeeds    50 sec    5 sec    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    \\Amount
    Click Button    ${Path_Siebel_Process_Change_Btn}
    ${popup_msg}=    Wait Until Keyword Succeeds    1 min    5 sec    Handle Alert    ACCEPT    1 min
    ${status}=    Get Element Attribute    ${Path_Siebel_Case_Status}    attribute=value
    log    ${status}
    Wait Until Keyword Succeeds    1 min    5 sec    Scroll Element Into View    xpath=//div[@title='Resources List Applet']//span[@title='Previous record set']
    Capture Page Screenshot    Add_resource.png

Case_Creation_Test
    ${PageTitle}=    Get Title
    ${PageTitle}=    Strip String    ${PageTitle}
    Run Keyword If    '${PageTitle}'=='All Contacts'    Press Keys    ${Path_LFRY_PAD_ApplDate}    TAB
    Run Keyword If    '${PageTitle}'=='All Contacts'    Select From List By Label    ${Path_LFRY_PAD_Source}    Paper Application
    # Run Keyword If    '${PageTitle}'=='All Contacts'    Clear Element Text    ${Path_LFRY_PAD_ApplDate}
    # Run Keyword If    '${PageTitle}'=='All Contacts'    Input Text    ${Path_LFRY_PAD_ApplDate}    01/01/2019
    #Run Keyword If    Page Should Contain Element    ${Path_LFRY_PAD_Source}
    Input Text From Profile    ${Path_LFRY_PCI_First_Name}    \\Persons\\P1\\First_Name
    Input Text From Profile    ${Path_LFRY_PCI_Middle_Name}    \\Persons\\P1\\Middle_Name
    Input Text From Profile    ${Path_LFRY_PCI_Last_Name}    \\Persons\\P1\\Last_Name
    Select List Item From Profile    ${Path_LFRY_PCI_Suffix}    \\Persons\\P1\\Suffix
    Input Text From Profile    ${Path_LFRY_PCI_Home_Address_Address_Line1}    \\Persons\\P1\\Home_Address\\Address_Line1
    Input Text From Profile    ${Path_LFRY_PCI_Home_Address_Apartment_Or_Suite_Number}    \\Persons\\P1\\Home_Address\\Apartment#
    Input Text From Profile    ${Path_LFRY_PCI_Home_Address_City}    \\Persons\\P1\\Home_Address\\City
    Select List Item From Profile    ${Path_LFRY_PCI_Home_Address_State}    \\Persons\\P1\\Home_Address\\State
    #Input Text From Profile    ${Path_LFRY_PCI_Home_Address_Zip_Code}    \\Persons\\P1\\Home_Address\\Zip_Code
    ${keypresent}    ${Zip}=    Get Value    \\Persons\\P1\\Home_Address\\Zip_Code
    Press Keys    ${Path_LFRY_PCI_Home_Address_Zip_Code}    ${Zip}
    Select List Item From Profile    ${Path_LFRY_PCI_Home_Address_County}    \\Persons\\P1\\Home_Address\\County
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Address_Line1}    \\Persons\\P1\\Mailing_Address\\Address_Line1
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Apartment_Or_Suite_Number}    \\Persons\\P1\\Mailing_Address\\Apt_Num
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_City}    \\Persons\\P1\\Mailing_Address\\City
    Select List Item From Profile    ${Path_LFRY_PCI_Mailing_Address_State}    \\Persons\\P1\\Mailing_Address\\State
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Zip_Code}    \\Persons\\P1\\Mailing_Address\\Zip
    Select List Item From Profile    ${Path_LFRY_PCI_Mailing_Address_County}    \\Persons\\P1\\Mailing_Address\\County
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Phone_Number}    \\Persons\\P1\\Phone_Number
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Other_Phone_Number}    \\Persons\\P1\\other_phone_number
    Select Radio Button From Profile    ${Path_LFRY_PCI_Do_You_Want_To_Get_Informtn_Abt_This_Appl_By_Email}    \\Persons\\P1\\Appl_By_Email
    Input Text From Profile    ${Path_LFRY_PCI_Do_You_Wnt_To_Get_Info_Abt_Ths_Appl_By_Email_Yes_Email_Addr}    \\Persons\\P1\\Email
    Select List Item From Profile    ${Path_LFRY_PCI_Preferred_Spoken_Language}    \\Persons\\P1\\Spoken_Lang
    Select List Item From Profile    ${Path_LFRY_PCI_Preferred_Written_Language}    \\Persons\\P1\\Written_Lang
    Input Text From Profile    ${Path_LFRY_PCI_How_Many_Family_Members_Live_With_You}    \\Persons\\P1\\Family_Mbrs
    Select List Item From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarcertd_Or_Residng_Hawaii_Ste_Hosptl}    \\Persons\\P1\\Incarcerated
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Fname}    \\Persons\\P1\\Incarceratd_Details\\Inc_Fname
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Mname}    \\Persons\\P1\\Incarceratd_Details\\Inc_Mname
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Lname}    \\Persons\\P1\\Incarceratd_Details\\Inc_Lname
    Valid Date Entry    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Sdate}    \\Persons\\P1\\Incarceratd_Details\\Inc_StartDate
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_RLdate}    \\Persons\\P1\\Incarceratd_Details\\Release_Date
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Fname}    \\Persons\\P1\\Any_incarcerated\\AFM_First_Name
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Mname}    \\Persons\\P1\\Any_incarcerated\\AFM_Middle_Name
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Lname}    \\Persons\\P1\\Any_incarcerated\\AFM_Last_Name
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Sdate}    \\Persons\\P1\\Any_incarcerated\\AFM_Start_Date
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Rdate}    \\Persons\\P1\\Any_incarcerated\\AFM_Start_Date
    Click On Button    ${Path_LFRY_PCI_Next_button}
    Click On Button    ${Path_LFRY_SA_Next_button}
    Wait Until Element Is Visible    ${Path_LFRY_PAD_Suffix_P1}    2 min
    Select List Item From Profile    ${Path_LFRY_PAD_Suffix_P1}    \\Persons\\P1\\Suffix
    sleep    8
    #######Have issue with invalid date format entry in the appl, hence handling with FOR loop till enters valid date format
    Valid Date Entry    ${Path_LFRY_PAD_DOB_P1}    \\Persons\\P1\\DOB
    Select List Item From Profile    ${Path_LFRY_PAD_Gender_P1}    \\Persons\\P1\\Gender
    Select List Item From Profile    ${Path_LFRY_PAD_Gender_P1_Female_Pregnant}    \\Persons\\P1\\Pregnancy\\Pregnant
    Select List Item From Profile    ${Path_LFRY_PAD_Gender_P1_Female_Pregnant_Babies_Exptd}    \\Persons\\P1\\Pregnancy\\Babies_Expected
    sleep    3
    Valid Date Entry    ${Path_LFRY_PAD_Gender_P1_Female_Pregnant_Babies_Exptd_Dt}    \\Persons\\P1\\Pregnancy\\Expected_Due_Dt
    Input Text From Profile    ${Path_LFRY_PAD_SpouseName_If_Married_P1}    \\Persons\\P1\\Name_of_Spouse
    ${keypresent}    ${SSN}=    Get Value    \\Persons\\P1\\SSN
    Press Keys    ${Path_LFRY_PAD_SSN_P1}    ${SSN}
    #Input Text From Profile    ${Path_LFRY_PAD_SSN_P1}    \\Persons\\P1\\SSN
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Plan_To_File_Federal_Inctx_Rtn_NEXT_Year}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe
    Input Text From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse_Yes_Fname}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse_Yes_Mname}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse_Yes_Lname}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Lname
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtrn}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Yes_Fname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Yes_Mname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Yes_Lname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Add_Dependnt_Fname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Add_Dependnt_Mname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Add_Dependnt_Lname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Lname
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn_Yes_Fname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn_Yes_Mname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn_Yes_Lname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    Select Checkbox From Profile    ${Path_LFRY_PAD_P1_Chk_If_Tx_Filer_Claimng_You_As_Dependt_Is_Nt_Prt_Of_Hsehold}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Nt_Prt_Of_Hsehold
    Select List Item From Profile    ${Path_LFRY_PAD_P1_How_Are_You_Related_To_Tx_Filer}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Tax_Filer
    # Wait Until Element Is Visible    ${Path_LFRY_PAD_P1_Do_You_Need_Health_Coverage}    1 min
    Select Radio Button From Profile    ${Path_LFRY_PAD_P1_Do_You_Need_Health_Coverage}    \\Persons\\P1\\Need_Hlth_Cvrge
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Have_Disability_Tht_Will_last_More_Than_Twelve_Mnths}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Do_You_Currently_Receive_Long_Trm_Care_Nursing_servces}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\Nursing_servces
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Have_You_Recvd__Lng_Trm_Cre_Nursng_srvcs_In_Lst_Three_Mnths}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\Lst_Three_Mnths
    Input Text From Profile    ${Path_LFRY_PAD_P1_Recvd__Lng_Trm_Cre_Nursng_srvcs_In_Lst_Three_Mnths_Yes_From}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\From_Dt
    Input Text From Profile    ${Path_LFRY_PAD_P1_Recvd__Lng_Trm_Cre_Nursng_srvcs_In_Lst_Three_Mnths_Yes_To}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\To_Dt
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Do_You_Think_You_Need_Lng_Trm_Cre_Nursng_srvcs_Now }    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\Nursng_srvcs_Now
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Do_You_Recve_Supplemental_Security_Income_SSI}    \\Persons\\P1\\Health_Coverage\\Recve_SSI_Inc
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_imdt_Prior_date_Of_Appl}    \\Persons\\P1\\Health_Coverage\\Recve_Med_Servc
    sleep    3    #without sleep, entering invalid date
    Valid Date Entry    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_Prior_date_Of_App_Y_Frm}    \\Persons\\P1\\Health_Coverage\\From_Dt
    sleep    3
    Valid Date Entry    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_Prior_date_Of_App_Y_To}    \\Persons\\P1\\Health_Coverage\\To_Dt
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Are_You_US_Citizen_Or_US_National}    \\Persons\\P1\\Health_Coverage\\US_Citizen
    Select List Item From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Citizen_Or_US_National_Hav_Eligble_Immgratn_Status}    \\Persons\\P1\\Health_Coverage\\Elig_Immgration_Sts
    Select List Item From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Citizen_Or_US_National_Hav_Eligble_Immgratn_Status}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\Immig_Status    # this immig xpath line is for COFA related
    Select List Item From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Hav_Eligb_Imig_Sts_Y_Immgtn_Doc_Type}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\Immig_Doc_Type
    Input Text From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Hav_Eligb_Imig_Sts_Y_Status_Type }    \\Persons\\P1\\Health_Coverage\\Status_Type
    Input Text From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Eligb_Imig_Sts_Y_Name_As_On_Imig_Doc}    \\Persons\\P1\\Health_Coverage\\Name_Imig_Doc
    Input Text From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Eligb_Imig_Sts_Y_Imig_DType_Visa_AN}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\Alien_Nbr
    Input Text From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Eligb_Imig_Sts_Y_Imig_DType_Visa_94}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\1_94_Nbr
    Input Text From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Eligb_Imig_Sts_Y_Imig_DType_Visa_PN}    \\Persons\\P1\\Health_Coverage\\Visa_PassprtNbr
    Input Text From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Eligb_Imig_Sts_Y_Imig_DType_Visa_DOE}    \\Persons\\P1\\Health_Coverage\\Visa_DOE
    Input Text From Profile    ${Path_LFRY_PAD_P1_If_Nt_US_Ctzn_Or_Natnl_Eligb_Imig_Sts_Y_Imig_DType_Visa_OD}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\Other_Docs
    Valid Date Entry    ${Path_LFRY_PAD_P1_Date_Of_Entry_US_Fnd_Imig_Doc_In_Q13_Dte_Prmnt_Lawfl_Resdnt}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\Immig_StDate
    Select Radio Button From Profile    ${Path_LFRY_PAD_P1_Ctzn_Federtd_Ste_Micronesia_Repblc_Marshall_Islands_Palau}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\Ctzn_Of_COFA
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Ctzn_Fedrtd_Ste_Micronesia_Rpblc_Mrshl_Islds_Palau_Y_Ctzshp}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\Country_Of_ctznshp
    Select List Item From Profile    ${Path_LFRY_PAD_P1_You_Spouse_Parent_A_Veteran_Or_Actve_Duty_Membr_US_Military}    \\Persons\\P1\\Health_Coverage\\US_Ctzn_Info\\US_Military
    Select List Item From Profile    ${Path_LFRY_PAD_P1_You_In_Foster_Care_At_Age18_Or_Older_In_Hawaii}    \\Persons\\P1\\Health_Coverage\\In_foster_18
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Are_You_A_Full_Time_Student}    \\Persons\\P1\\Health_Coverage\\full_time_student
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Chicano}    \\Persons\\P1\\Health_Coverage\\Ethnicity\\Chicano
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_American}    \\Persons\\P1\\Health_Coverage\\Ethnicity\\American
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Other}    \\Persons\\P1\\Health_Coverage\\Ethnicity\\Other
    Input Text From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Other_Country}    \\Persons\\P1\\Health_Coverage\\Ethnicity\\Other_County
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Cuban}    \\Persons\\P1\\Health_Coverage\\Ethnicity\\Cuban
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Puerto_Rican}    \\Persons\\P1\\Health_Coverage\\Ethnicity\\Puerto_Rican
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Mexican}    \\Persons\\P1\\Health_Coverage\\Ethnicity\\Mexican
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_American_Indian_Or_Alaskan}    \\Persons\\P1\\Health_Coverage\\Race\\American_Indian_Or_Alaskan
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Chinese}    \\Persons\\P1\\Health_Coverage\\Race\\Chinese
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Japanese}    \\Persons\\P1\\Health_Coverage\\Race\\Japanese
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Other_Asian}    \\Persons\\P1\\Health_Coverage\\Race\\Other_Asian
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Vietnamese}    \\Persons\\P1\\Health_Coverage\\Race\\Vietnamese
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Other}    \\Persons\\P1\\Health_Coverage\\Race\\Other
    Input Text From Profile    ${Path_LFRY_HHD_P2_Race_Other_Country}    \\Persons\\P1\\Health_Coverage\\Race\\Other_County
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Asian_Indian}    \\Persons\\P1\\Health_Coverage\\Race\\Asian_Indian
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Filipino}    \\Persons\\P1\\Health_Coverage\\Race\\Filipino
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Korean}    \\Persons\\P1\\Health_Coverage\\Race\\Korean
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Other_Pacific_Islander}    \\Persons\\P1\\Health_Coverage\\Race\\Other_Pacific_Islander
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_White}    \\Persons\\P1\\Health_Coverage\\Race\\White
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Black_Or_African_American}    \\Persons\\P1\\Health_Coverage\\Race\\African_American
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Guamanian_Or_Chamorro}    \\Persons\\P1\\Health_Coverage\\Race\\Guamanian_Or_Chamorro
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Native_Hawaiian}    \\Persons\\P1\\Health_Coverage\\Race\\Hawaiian
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Samoan}    \\Persons\\P1\\Health_Coverage\\Race\\Samoan
    Select Radio Button From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Information_Typ_Employment}    \\Persons\\P1\\Type_Of_Employment
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Information_Employer_Name}    \\Persons\\P1\\Employment\\Employer_Name
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Information_PH_Nbr}    \\Persons\\P1\\Employment\\PH_Nbr
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Information_Address_Line1}    \\Persons\\P1\\Employment\\Address_Line1
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Information_Apartment_Or_Suite_Nbr}    \\Persons\\P1\\Employment\\Apt#
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Information_City}    \\Persons\\P1\\Employment\\City
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Information_State}    \\Persons\\P1\\Employment\\State
    #Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Zip_Code}    \\Persons\\P1\\Employment\\Zip_Code
    ${keypresent}    ${Zip_Code}=    Get Value    \\Persons\\P1\\Employment\\Zip_Code
    Run Keyword If    '${keypresent}' == 'True'    Press Keys    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Zip_Code}    ${Zip_Code}
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Wages_Tips_Before_Taxes}    \\Persons\\P1\\Employment\\Wages
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_How_Often}    \\Persons\\P1\\Employment\\How_Often
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_How_Often_Daily_Days_Wrkd_Each_Week}    \\Persons\\P1\\Employment\\No_Of_Days_Worked_Week
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Incme_How_Oftn_Hourly_Avg_Hrs_Wrkd_Ech_Week}    \\Persons\\P1\\Employment\\Avg_Hours_Worked_Week
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Incme_How_Oftn_Hourly_Avg_Hrs_Wrkd_Ech_Week}    \\Persons\\P1\\Employment\\Avg_Hours_Worked_Week
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Incme_How_Oftn_Hourly_Avg_Hrs_Wrkd_Ech_Week}    \\Persons\\P1\\Employment\\Avg_Hours_Worked_Week
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Incme_How_Oftn_Hourly_Avg_Hrs_Wrkd_Ech_Week}    \\Persons\\P1\\Employment\\Avg_Hours_Worked_Week
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Income_Start_Date}    \\Persons\\P1\\Employment\\Income_Start_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Income_End_Date}    \\Persons\\P1\\Employment\\Income_End_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_Emplr_Name}    \\Persons\\P1\\Employment\\Add_New_Job\\Emplr_Name
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_PH_Nbr}    \\Persons\\P1\\Employment\\Add_New_Job\\PH_Nbr
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_Address_Line1}    \\Persons\\P1\\Employment\\Add_New_Job\\Address_Line1
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_Apartment_Or_Suite_Nbr}    \\Persons\\P1\\Employment\\Add_New_Job\\Apt_Num
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_City}    \\Persons\\P1\\Employment\\Add_New_Job\\City
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_State}    \\Persons\\P1\\Employment\\Add_New_Job\\State
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_Zip_Code}    \\Persons\\P1\\Employment\\Add_New_Job\\ZIP
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_Wages_Tips_Before_Taxes}    \\Persons\\P1\\Employment\\Add_New_Job\\Wages
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_How_Often}    \\Persons\\P1\\Employment\\Add_New_Job\\How_Often
    Input Text From Profile    ${Path_LFRY_PAD_P1_Cnt_Jb_And_Incm_Add_New_Jobs_Hw_Oftn_Daily_Nbr_Hrs_Wrkd}    \\Persons\\P1\\Employment\\Add_New_Job\\Nbr_Hrs_Wrkd
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_Income_Start_Date}    \\Persons\\P1\\Employment\\Add_New_Job\\Income_Start_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Add_New_Jobs_Income_End_Date}    \\Persons\\P1\\Employment\\Add_New_Job\\Income_End_Date
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_In_The_Past_Year_Did_You}    \\Persons\\P1\\Employment\\Change_Job_Past_Year
    Select Checkbox From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Self_Employed}    \\Persons\\P1\\Self_Employment
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Self_Emplyd_Type_Of_Work}    \\Persons\\P1\\Self_Emp\\Type_Of_Work
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Slf_Empd_Net_Incme_Gt_Paid_Frm_Slf_Emplnt}    \\Persons\\P1\\Self_Emp\\Net_Inc
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Othr_Icme_Ths_Mnth_Income_Type}    \\Persons\\P1\\Other_Income\\Income_Type
    sleep    2
    Input Text From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Othr_Icme_Ths_Mnth_Amount}    \\Persons\\P1\\Other_Income\\Amount
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Current_Job_And_Income_Othr_Icme_Ths_Mnth_How_Often}    \\Persons\\P1\\Other_Income\\How_Often
    Input Text From Profile    ${Path_LFRY_PAD_P1_Cnt_Jb_Incm_Otr_Icme_Ths_Mnth_Hw_Oftn_Daily_Dys_Wrkd_Ech_Wk}    \\Persons\\P1\\Other_Income\\Dys_Wrkd_Ech_Wk
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Jb_And_Incm_Othr_Icme_Ths_Mnth_Hw_Oftn_Incme_Str_Date}    \\Persons\\P1\\Other_Income\\Income_Start_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Cnt_Job_And_Incme_Othr_Icme_Ths_Mnth_Hw_Oftn_Incme_End_Date}    \\Persons\\P1\\Other_Income\\Income_End_Date
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Add_More_Income_Incme_Type}    \\Persons\\P1\\Other_Income\\Add_More_Income\\Add_More_Income\\Income_Type
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Add_More_Income_Amount}    \\Persons\\P1\\Other_Income\\Add_More_Income\\Amount
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Add_More_Income_How_Oftn}    \\Persons\\P1\\Other_Income\\Add_More_Income\\How_Often
    Input Text From Profile    ${Path_LFRY_PAD_P1_Cnt_Jb_Incme_Add_Mre_Incm_Hw_Ofn_Daily_Nbr_Days_wrkd_Ech_Wk}    \\Persons\\P1\\Other_Income\\Add_More_Income\\Dys_Wrkd_Ech_Wk
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Add_More_Income_Incme_Str_Date}    \\Persons\\P1\\Other_Income\\Add_More_Income\\Income_Start_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Add_More_Income_Incme_End_Date}    \\Persons\\P1\\Other_Income\\Add_More_Income\\Income_End_Date
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Type_Of_Deductn}    \\Persons\\P1\\Deductions\\Type_Of_Deduction
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Amount}    \\Persons\\P1\\Deductions\\Amount
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_How_Often}    \\Persons\\P1\\Deductions\\How_Often
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Deductn_Start_Date}    \\Persons\\P1\\Deductions\\Deductn_Start_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Deductn_End_Date}    \\Persons\\P1\\Deductions\\Deductn_End_Date
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Add_More_Deductn_Type_Of_Deductn}    \\Persons\\P1\\Deductions\\Add_More_Deductn\\Type_Of_Deduction
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Add_More_Deductn_Amount}    \\Persons\\P1\\Deductions\\Add_More_Deductn\\Amount
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Add_More_Deductn_How_Often}    \\Persons\\P1\\Deductions\\Add_More_Deductn\\How_Often
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Add_More_Deductn_Deductn_Start_Date}    \\Persons\\P1\\Deductions\\Add_More_Deductn\\Deductn_Start_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Deductn_Add_More_Deductn_Deductn_End_Date}    \\Persons\\P1\\Deductions\\Add_More_Deductn\\Deductn_End_Date
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Yearly_Income_Total_Incmr_Ths_Yr}    \\Persons\\P1\\Yearly_Income\\Total income This year
    Input Text From Profile    ${Path_LFRY_PAD_P1_Curnt_Job_Incme_Yearly_Income_Total_Inmce_Tx_Nxt_Yr}    \\Persons\\P1\\Yearly_Income\\Total income next year
    Click On Button    ${Path_LFRY_PAD_P1_Next}
    ########Add household as Person 2 details here########
    Wait Until Element Is Visible    ${Path_LFRY_HHD_Add_Person}    2 min
    ${KeyPresent}    ${value}=    Get value    \\Persons\\P2
    Run Keyword If    ${KeyPresent}    Add Person2 Household
    ...    ELSE    Click Element    ${Path_LFRY_HHD_P2_Save_And_Next}
    # Add Household P3    ${Path_LFRY_HHD_Add_Person}    \\Persons\\P3
    Select List Item From Profile    ${Path_LFRY_PHR_Psdzerofour_Automtion_Relationship_To_Psdzerothree_Automation}    \\Persons\\P1\\HH_relationship_Psd3_Atmn
    Select List Item From Profile    ${Path_LFRY_PHR_Psdzerofour_Automtion_Relationship_To_Psdzerofive_Automation}    \\Persons\\P1\\HH_relationship_Psd5_Atmn
    Select List Item From Profile    ${Path_LFRY_PHR_Psdzerofive_Automtion_Relationship_To_Psdzerothree_Automtion}    \\Persons\\P1\\HH_relationship_Psd3_Atmn
    Select List Item From Profile    ${Path_LFRY_PHR_Psdzerofive_Automtion_Relationship_To_Psdzerofive_Automation}    \\Persons\\P1\\HH_relationship_Psd5_Atmn
    Click On Button    ${Path_LFRY_PHR_Next}
    Wait Until Page Contains    Tax Dependents    2 min
    Select Radio Button From Profile    ${Path_LFRY_TD_Does_P3_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr}    \\Tax_Dep
    Select List Item From Profile    ${Path_LFRY_TD_Does_P3_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr_Jntly_File_WSpse}    \\Tax_Dep\\Jntly_File_WSpse
    Select Checkbox From Profile    ${Path_LFRY_TD_Does_P3_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr_Jntly_File_WSps_Ys_Chkbox}    \\Tax_Dep\\P3_Jntly_File_WSps_Chkbx
    Select List Item From Profile    ${Path_LFRY_TD_Does_P3_Claim_Any_Dpndts_On_Their_Tx_Rtrn}    \\Tax_Dep\\P3_Dependent_On_Tax_Return
    Select Checkbox From Profile    ${Path_LFRY_TD_Does_P3_Claim_Any_Dpndts_On_Their_Tx_Rtrn_Yes_Chkbox}    \\Tax_Dep\\P3_Dependent_On_Tax_Rtn_Chkbx
    Select List Item From Profile    ${Path_LFRY_TD_Will_P3_Be_Clmd_As_Dpndt_On_Some_Ones_Tx_Rtrn}    \\Tax_Dep\\P3_Dpndt_On_Some_Ones_Tx_Rtrn
    Select Checkbox From Profile    ${Path_LFRY_TD_Will_P3_Be_Clmd_As_Dpndt_On_Some_Ones_Tx_Rtrn_Yes_Chkbox}    \\Tax_Dep\\P3_Dpndt_On_Some_Ones_Tx_Rtrn_Chkbx
    Select Checkbox From Profile    ${Path_LFRY_TD_If_Tx_Filer_Clmng_P3_As_A_Dpndt_Not_Part_Of_The_HH_Chk}    \\Tax_Dep\\P3_Dpndt_Not_Part_Of_The_HH_Chk
    Select List Item From Profile    ${Path_LFRY_TD_Is_P3_Related_To_The_Tax_Filer}    \\Tax_Dep\\P3_Related_To_Tax_Filer
    Select Radio Button From Profile    ${Path_LFRY_TD_Does_P4_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr}    \\Tax_Dep\\P4_Fdrl_Incm_Tx_Rtrn_Nxt_Yr
    Select List Item From Profile    ${Path_LFRY_TD_Does_P4_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr_Jntly_File_WSpse}    \\Tax_Dep\\P4_Fdrl_Incm_Tx_Jntly_File_WSpse
    Select Checkbox From Profile    ${Path_LFRY_TD_Does_P4_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr_Jntly_File_WSps_Ys_Chkbox}    \\Tax_Dep\\P4_Fdrl_Incm_Tx_Jntly_File_WSpse_Chkbx
    Select List Item From Profile    ${Path_LFRY_TD_Does_P4_Claim_Any_Dpndts_On_Their_Tx_Rtrn}    \\Tax_Dep\\P4_Dependent_On_Tax_Return
    Select Checkbox From Profile    ${Path_LFRY_TD_Does_P4_Claim_Any_Dpndts_On_Their_Tx_Rtrn_Yes_Chkbox}    \\Tax_Dep\\P4_Dependent_On_Tax_Rtn_Chkbx
    Select List Item From Profile    ${Path_LFRY_TD_Will_P4_Be_Clmd_As_Dpndt_On_Some_Ones_Tx_Rtrn}    \\Tax_Dep\\P4_Dpndt_On_Some_Ones_Tx_Rtrn
    Select Checkbox From Profile    ${Path_LFRY_TD_Will_P4_Be_Clmd_As_Dpndt_On_Some_Ones_Tx_Rtrn_Yes_Chkbox}    \\Tax_Dep\\P4_Dpndt_On_Some_Ones_Tx_Rtrn_Chkbx
    Select Checkbox From Profile    ${Path_LFRY_TD_If_Tx_Filer_Clmng_P4_As_A_Dpndt_Not_Part_Of_The_HH_Chk}    \\Tax_Dep\\P4_Dpndt_Not_Part_Of_The_HH_Chk
    Select List Item From Profile    ${Path_LFRY_TD_How_Is_P4_Related_To_The_Tax_Filer}    \\Tax_Dep\\P4_Related_To_Tax_Filer
    Select Radio Button From Profile    ${Path_LFRY_TD_Does_P5_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr}    \\Tax_Dep\\P5_Fdrl_Incm_Tx_Rtrn_Nxt_Yr
    Select List Item From Profile    ${Path_LFRY_TD_Does_P5_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr_Jntly_File_WSpse}    \\Tax_Dep\\P5_Fdrl_Incm_Tx_Jntly_File_WSpse
    Select Checkbox From Profile    ${Path_LFRY_TD_Does_P5_Pln_To_Fle_Fdrl_Incm_Tx_Rtrn_Nxt_Yr_Jntly_File_WSps_Ys_Chkbox}    \\Tax_Dep\\P5_Fdrl_Incm_Tx_Jntly_File_WSpse_Chkbx
    Select List Item From Profile    ${Path_LFRY_TD_Does_P5_Claim_Any_Dpndts_On_Their_Tx_Rtrn}    \\Tax_Dep\\P5_Dependent_On_Tax_Return
    Select Checkbox From Profile    ${Path_LFRY_TD_Does_P5_Claim_Any_Dpndts_On_Their_Tx_Rtrn_Yes_Chkbox}    \\Tax_Dep\\P5_Dependent_On_Tax_Rtn_Chkbx
    Select List Item From Profile    ${Path_LFRY_TD_Will_P5_Be_Clmd_As_Dpndt_On_Some_Ones_Tx_Rtrn}    \\Tax_Dep\\P5_Dpndt_On_Some_Ones_Tx_Rtrn
    Select Checkbox From Profile    ${Path_LFRY_TD_Will_P5_Be_Clmd_As_Dpndt_On_Some_Ones_Tx_Rtrn_Yes_Chkbox}    \\Tax_Dep\\P5_Dpndt_On_Some_Ones_Tx_Rtrn_Chkbx
    Select Checkbox From Profile    ${Path_LFRY_TD_If_Tx_Filer_Clmng_P5_As_A_Dpndt_Not_Part_Of_The_HH_Chk}    \\Tax_Dep\\P5_Dpndt_Not_Part_Of_The_HH_Chk
    Select List Item From Profile    ${Path_LFRY_TD_How_Is_P5_Related_To_The_Tax_Filer}    \\Tax_Dep\\P5_Related_To_Tax_Filer
    Click On Button    ${Path_LFRY_TD_Next_Button}
    Select Radio Button From Profile    ${Path_LFRY_IFM_Is_Any_Fmly_mmbr_Incrcrtd_Or_Resdng_In_Hawaii_Hsptl}    \\Incarceratd
    Select Checkbox From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_1_Psd3_Chkbox}    \\Incarceratd\\Psd3_Chkbox
    Input Text From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_1_Start_Date}    \\Incarceratd\\Start_Date
    Input Text From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_1_Release_Date}    \\Incarceratd\\Release_Date
    Select Checkbox From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_2_Psd4_Chkbox}    \\Incarceratd\\Psd4_Chkbox
    Input Text From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_2_Start_Date}    \\Incarceratd\\Start_Date
    Input Text From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_2_Release_Date}    \\Incarceratd\\Release_Date
    Select Checkbox From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_3_Psd5_Chkbox}    \\Incarceratd\\Psd5_Chkbox
    Input Text From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_3_Start_Date}    \\Incarceratd\\Start_Date
    Input Text From Profile    ${Path_LFRY_IFM_If_Yes_Name_of_Family_Member_3_Release_Date}    \\Incarceratd\\Release_Date
    Click On Button    ${Path_LFRY_IFM_Next}
    Select Checkbox From Profile    ${Path_LFRY_FHC_App_Enrld_In_Hlth_Cvrg_Now}    \\Famly_Hlth_Covr
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_App_Enrld_In_Hlth_Cvrg_Now}    \\Famly_Hlth_Covr_Yes\\Enroll_HCovr
    Select List Item From Profile    ${Path_LFRY_FHC_P3_Type_Of_Coverage}    \\Famly_Hlth_Covr_Yes\\Type_Covrg
    Input Text From Profile    ${Path_LFRY_FHC_P3_Policy_Name}    \\Famly_Hlth_Covr_Yes\\Policy_Name
    Input Text From Profile    ${Path_LFRY_FHC_P3_Policy_Number}    \\Famly_Hlth_Covr_Yes\\Policy_Number
    Valid Date Entry    ${Path_LFRY_FHC_P3_Policy_Start_Date}    \\Famly_Hlth_Covr_Yes\\Plicy_Start_Dt
    # Input Text From Profile    ${Path_LFRY_FHC_P3_Policy_Start_Date}    \\Famly_Hlth_Covr_Yes\\Plicy_Start_Dt
    Input Text From Profile    ${Path_LFRY_FHC_P3_Policy_End_Date}    \\Famly_Hlth_Covr_Yes\\Plicy_End_Dt
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Includes_Medical_Care}    \\Famly_Hlth_Covr_Yes\\Includes_Medical
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Includes_Dental_Care}    \\Famly_Hlth_Covr_Yes\\Dental_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Includes_Vision_Care}    \\Famly_Hlth_Covr_Yes\\Vision_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Is_This_A_Limited_Benefit_Plan}    \\Famly_Hlth_Covr_Yes\\Benefit_Plan
    Select List Item From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Type_Of_Coverage}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Type_Of_Coverage
    Input Text From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Policy_Name}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Policy_Name
    Input Text From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Policy_Number}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Policy_Number
    Input Text From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Policy_Start_Date}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Start_Date
    Input Text From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Policy_End_Date}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\End_Date
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Includes_Medical_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Medical_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Includes_Dental_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Dental_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Includes_Vision_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Vision_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P3_Add_Coverage_Is_This_A_Limited_Benefit_Plan}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\Benefit_Plan
    Select Radio Button From Profile    ${Path_LFRY_FHC_Is_P4_Enrld_In_Hlth_Cvrg_Now}    \\Famly_Hlth_Covr_Yes\\P4_Enrld_In_Hlth_Cvrg_Now
    Select List Item From Profile    ${Path_LFRY_FHC_P4_Type_Of_Coverage}    \\Famly_Hlth_Covr_Yes\\P4_Type_Of_Coverage
    Input Text From Profile    ${Path_LFRY_FHC_P4_Policy_Name}    \\Famly_Hlth_Covr_Yes\\P4_Policy_Name
    Input Text From Profile    ${Path_LFRY_FHC_P4_Policy_Number}    \\Famly_Hlth_Covr_Yes\\P4_Policy_Number
    Input Text From Profile    ${Path_LFRY_FHC_P4_Policy_Start_Date}    \\Famly_Hlth_Covr_Yes\\P4_Policy_Start_Date
    Input Text From Profile    ${Path_LFRY_FHC_P4_Policy_End_Date}    \\Famly_Hlth_Covr_Yes\\P4_Policy_End_Date
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Includes_Medical_Care_If_Yes}    \\Famly_Hlth_Covr_Yes\\P4_Medical_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Includes_Dental_Care_If_Yes}    \\Famly_Hlth_Covr_Yes\\P4_Dental_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Includes_Vision_Care_If_Yes}    \\Famly_Hlth_Covr_Yes\\P4_Vision_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Is_This_A_Limited_Benefit_Plan_If_Yes}    \\Famly_Hlth_Covr_Yes\\P4_Benefit_Plan
    Select List Item From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Type_Of_Coverage}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Type_Of_Coverage
    Input Text From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Policy_Name}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Policy_Name
    Input Text From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Policy_Number }    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Policy_Number
    Input Text From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Policy_Start_Date }    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Policy_Start_Date
    Input Text From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Policy_End_Date}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Policy_End_Date
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Includes_Medical_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Medical_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Includes_Dental_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Dental_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Includes_Vision_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Vision_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P4_Add_Coverage_Is_This_A_Limited_Benefit_Plan}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P4_Benefit_Plan
    Select Radio Button From Profile    ${Path_LFRY_FHC_Is_P5_Enrld_In_Hlth_Cvrg_Now}    \\Famly_Hlth_Covr_Yes\\P5_Enrld_In_Hlth_Cvrg_Now
    Select List Item From Profile    ${Path_LFRY_FHC_P5_Type_Of_Coverage}    \\Famly_Hlth_Covr_Yes\\P5_Type_Of_Coverage
    Input Text From Profile    ${Path_LFRY_FHC_P5_Policy_Name}    \\Famly_Hlth_Covr_Yes\\P5_Policy_Name
    Input Text From Profile    ${Path_LFRY_FHC_P5_Policy_Number}    \\Famly_Hlth_Covr_Yes\\P5_Policy_Number
    Input Text From Profile    ${Path_LFRY_FHC_P5_Policy_Start_Date}    \\Famly_Hlth_Covr_Yes\\P5_Policy_Start_Date
    Input Text From Profile    ${Path_LFRY_FHC_P5_Policy_End_Date}    \\Famly_Hlth_Covr_Yes\\P5_Policy_End_Date
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Includes_Medical_Care}    \\Famly_Hlth_Covr_Yes\\P5_Medical_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Includes_Dental_Care}    \\Famly_Hlth_Covr_Yes\\P5_Dental_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Includes_Vision_Care}    \\Famly_Hlth_Covr_Yes\\P5_Vision_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Is_This_A_Limited_Benefit_Plan}    \\Famly_Hlth_Covr_Yes\\P5_Benefit_Plan
    Select List Item From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Type_Of_Coverage}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Type_Of_Coverage
    Input Text From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Policy_Name}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Policy_Name
    Input Text From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Policy_Number}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\PP5_Policy_Number5_
    Input Text From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Policy_Start_Date}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Policy_Start_Date
    Input Text From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Policy_End_Date}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Policy_End_Date
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Includes_Medical_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Medical_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Includes_Dental_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Dental_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Includes_Vision_Care}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Vision_Care
    Select Radio Button From Profile    ${Path_LFRY_FHC_P5_Add_Coverage_Is_This_A_Limited_Benefit_Plan}    \\Famly_Hlth_Covr_Yes\\Add_Cvge\\P5_Benefit_Plan
    Click On Button    ${Path_LFRY_FHC_Next}
    Select Checkbox From Profile    ${Path_LFR_HCFJ}    \\Hlth_Covr_Jobs
    Select Radio Button From Profile    ${Path_LFR_HCFJ_Stat_Emp_Bnft_Pln}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Benifit_Plan
    Select Radio Button From Profile    ${Path_LFR_HCFJ_Selct_Emp_P3}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Emp_P3
    Select Radio Button From Profile    ${Path_LFR_HCFJ_Selct_Emp_P4}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Emp_P4
    Select Radio Button From Profile    ${Path_LFR_HCFJ_Selct_Emp_P5}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Emp_P5
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Name}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Emplyr_Name
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_EIN}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\EIN
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Phn_Num}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Phn_Num
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Addrs_Line1}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Addrs_Line1
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Addrs_Line2}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Addrs_Line2
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_City}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\City
    Select List Item From Profile    ${Path_LFR_HCFJ_Emplyr_State}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Empr_State
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Zip_Code}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\ZIP
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Cntct}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Contact
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Cntct_Phn_Num}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Ph_Nbr
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Cntct_Email}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Email
    Select Radio Button From Profile    ${Path_LFR_HCFJ_Emplyr_Cvr_Elig_Or_Elig_Nxt_Thre_Mnths}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\eligible_Nxt_3Months
    Input Text From Profile    ${Path_LFR_HCFJ_Emplyr_Cvr_Elig_Or_Elig_Nxt_Thre_Mnths_Yes_Enrl}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Random_policy
    Select Checkbox From Profile    ${Path_LFR_HCFJ_ECvr_Elig_Nxt_Thre_Mnths_Who_Does_Job_Ofr_Cvr_To_P3}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Job_offer_P3
    Select Checkbox From Profile    ${Path_LFR_HCFJ_ECvr_Elig_Nxt_Thre_Mnths_Who_Does_Job_Ofr_Cvr_To_P4}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Job_offer_P4
    Select Checkbox From Profile    ${Path_LFR_HCFJ_ECvr_Elig_Nxt_Thre_Mnths_Who_Does_Job_Ofr_Cvr_To_P5}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Job_offer_P5
    Input Text From Profile    ${Path_LFR_HCFJ_ECvr_Elig_Nxt_Thre_Mnths_Goto_Step5}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Job_offer_P3
    Select Radio Button From Profile    ${Path_LFR_HCFJ_ECvr_Elig_Nxt_Thre_Mnths_Yes_EOfr_HPln_Mets_Min_Std}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Min_Value_standard
    Input Text From Profile    ${Path_LFR_HCFJ_ECvr_Elig_Nxt_Thre_Mnths_Yes_EOfr_HPln_Mets_Min_Std_Yes_Pay}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Health_Covg_Amount
    Select List Item From Profile    ${Path_LFR_HCFJ_ECvrg_ENxt_TMnths_Ys_EOfr_HPmts_MStd_Ys_Pay_Ofen}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\How_Often
    Select Checkbox From Profile    ${Path_LFR_HCFJ_ECvrg_ENxt_TMnths_Ys_EOfr_HPmts_MStd_Ys_NPln_Yr_Wnt_ofr_HCvr}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Employer_Wont_Offer_Hlth_Cvrg
    Select Checkbox From Profile    ${Path_LFR_HCFJ_ECvrg_ENxt_TMnths_Ys_EOfr_HPmts_MStd_Ys_NPln_Yr_Ofr_HCvrg}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Employer_Offer_Hlth_Cvrg
    Input Text From Profile    ${Path_LFR_HCFJ_ECvrg_ENxt_TMnths_Ys_EOfr_HPmts_MStd_Ys_NPln_Yr_Ofr_HCvrg_Pay}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Employer_Offer_Hlth_Cvrg\\Health_Covg_Amount
    Select List Item From Profile    ${Path_LFR_HCFJ_ECvrg_ENxt_TMnths_Ys_EOfr_HPmts_MStd_Ys_NPln_Yr_Ofr_HCvrg_POf}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Employer_Offer_Hlth_Cvrg\\How_Often
    Input Text From Profile    ${Path_LFR_HCFJ_ECvrg_ENxt_TMnths_Ys_EOfr_HPmts_MStd_Ys_NPln_Yr_Ofr_HCvrg_CDt}    \\Hlth_Covr_Jobs\\Coverage_From_Jobs\\Employer_Offer_Hlth_Cvrg\\Start_Date
    Click On Button    ${Path_LFR_HCFJ_Next_Btn}
    Select Checkbox From Profile    ${Path_LFRY_AAI_Are_You_Or_Anyone_Your_Famly_American_Alaskan_Indian_Natve}    \\AI_AN_Info
    Select Radio Button From Profile    ${Path_LFRY_AAI_Is_Psdzerothree_Automtn_An_American_Indian_Alaskan_Native}    \\AI_AN_Info\\P3_American_Indian_Alaskan_Native
    Select Radio Button From Profile    ${Path_LFRY_AAI_Is_Psdzerothree_Member_Of_Federally_Recognized_Tribe}    \\AI_AN_Info\\P3_Federally_Recognized_Tribe
    Input Text From Profile    ${Path_LFRY_AAI_Is_Psdzerothree_Mbr_Of_Fedrally_Recognzed_Tribe_Yes_TribeName}    \\AI_AN_Info\\P3_Federally_Recognized_Tribe\\Tribe_Name
    Select Radio Button From Profile    ${Path_LFRY_AAI_Pz3_Svc_Frm_Ind_Tbl_Hlth_Prg_Urb_Hlth_Prg_Rfrl_Prg}    \\AI_AN_Info\\P3_Got_Servces
    Select Radio Button From Profile    ${Path_LFRY_AAI_Pz3_Elble_Srv_Frm_Ind_Tbl_Urn_Idn_Hlth_Prg_Rfrl_Prg}    \\AI_AN_Info\\P3_Eligble_Servces
    Input Text From Profile    ${Path_LFRY_AAI_Psdzerothree_Amount}    \\AI_AN_Info\\P3_Eligble_Servces\\Amount
    Select List Item From Profile    ${Path_LFRY_AAI_Psdzerothree_How_Often}    \\AI_AN_Info\\P3_Eligble_Servces\\How_Often
    Select Radio Button From Profile    ${Path_LFRY_AAI_Is_Psdzerofour_Automtn_An_American_Indian_Alaskan_Native}    \\AI_AN_Info\\P4_American_Indian_Alaskan_Native
    Select Radio Button From Profile    ${Path_LFRY_AAI_Is_Psdzerofour_Member_Of_Federally_Recognized_Tribe}    \\AI_AN_Info\\P4_Federally_Recognized_Tribe
    Input Text From Profile    ${Path_LFRY_AAI_Is_Psdzerofour_Member_Of_Federally_Recognized_Tribe_Yes_TName}    \\AI_AN_Info\\P4_Federally_Recognized_Tribe\\Tribe_Name
    Select Radio Button From Profile    ${Path_LFRY_AAI_Pz4_Svc_Frm_Ind_Tbl_Hlth_Prg_Urb_Hlth_Prg_Rfrl_Prg}    \\AI_AN_Info\\P4_Got_Servces
    Select Radio Button From Profile    ${Path_LFRY_AAI_Pz4_Elble_Srv_Frm_Ind_Tbl_Urn_Idn_Hlth_Prg_Rfrl_Prg}    \\AI_AN_Info\\P4_Eligble_Servces
    Input Text From Profile    ${Path_LFRY_AAI_Psdzerofour_Amount}    \\AI_AN_Info\\P4_Eligble_Servces\\Amount
    Select List Item From Profile    ${Path_LFRY_AAI_Psdzerofour_How_Often}    \\AI_AN_Info\\P4_Eligble_Servces\\How_Often
    Select Radio Button From Profile    ${Path_LFRY_AAI_Is_Psdzerofive_Automtn_An_American_Indian_Alaskan_Native}    \\AI_AN_Info\\P5_American_Indian_Alaskan_Native
    Select Radio Button From Profile    ${Path_LFRY_AAI_Is_Psdzerofive_Member_Of_Federally_Recognized_Tribe}    \\AI_AN_Info\\P5_Federally_Recognized_Tribe
    Input Text From Profile    ${Path_LFRY_AAI_Is_Psdzerofive_Member_Of_Federally_Recognized_Tribe_Yes_TName}    \\AI_AN_Info\\P5_Federally_Recognized_Tribe\\Tribe_Name
    Select Radio Button From Profile    ${Path_LFRY_AAI_Pz5_Svc_Frm_Ind_Tbl_Hlth_Prg_Urb_Hlth_Prg_Rfrl_Prg}    \\AI_AN_Info\\P5_Got_Servces
    Select Radio Button From Profile    ${Path_LFRY_AAI_Pz5_Elble_Srv_Frm_Ind_Tbl_Urn_Idn_Hlth_Prg_Rfrl_Prg}    \\AI_AN_Info\\P5_Eligble_Servces
    Input Text From Profile    ${Path_LFRY_AAI_Psdzerofive_Amount}    \\AI_AN_Info\\P5_Eligble_Servces\\Amount
    Select List Item From Profile    ${Path_LFRY_AAI_Psdzerofive_How_Often}    \\AI_AN_Info\\P5_Eligble_Servces\\How_Often
    Click On Button    ${Path_LFRY_AAI_Next}
    Select Checkbox From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv}    \\Authorized_Rep
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Frst_Name}    \\Authorized_Rep_Details\\First_Name
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Mdle_Name}    \\Authorized_Rep_Details\\Middle_Name
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Lst_Name}    \\Authorized_Rep_Details\\Last_Name
    Select List Item From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Suffix}    \\Authorized_Rep_Details\\Suffix
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Addrs_L1}    \\Authorized_Rep_Details\\Address\\Address_Line1
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Aprtmnt}    \\Authorized_Rep_Details\\Address\\Apartment#
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_City}    \\Authorized_Rep_Details\\Address\\City
    Select List Item From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_State}    \\Authorized_Rep_Details\\Address\\State
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_ZCode}    \\Authorized_Rep_Details\\Address\\Zip_Code
    Select List Item From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_County}    \\Authorized_Rep_Details\\Address\\County
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Phone}    \\Authorized_Rep_Details\\Phone_Number
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_Orgnztn_Name}    \\Authorized_Rep_Details\\Org_Name
    Input Text From Profile    ${Path_LFRY_AR_Would_You_Like_To_Include_Authrzd_Reprsntatv_Y_ID_Nmbr}    \\Authorized_Rep_Details\\ID_Nmbr
    Click On Button    ${Path_LFRY_AR_Next_Button}
    #######Add condition for Authrep==YES######
    ${keyPresent}    ${value}=    Get value    \\Authorized_Rep
    Run Keyword If    '${value}'== 'Yes'    Click On Button    ${Path_LFRY_SA_Next_button}
    Select From List By Index    ${Path_LFR_RS_Yes_Rnew_Elig_Nxt}    5    #\\Review_Declare_File\\Reniew_Eligibility
    sleep    2
    Select Radio Button From Profile    ${Path_LFR_RS_Does_Parnt_livng_Out_Hme}    \\Review_Declare_File\\Does_Parent_Of_Child_Live_outside_Home
    Select Checkbox From Profile    ${Path_LFR_RS_Agree_T_C}    \\Review_Declare_File\\Terms_checkbox
    Input Text From Profile    ${Path_LFR_RS_Sign_Prim_App_FName}    \\Review_Declare_File\\Prim_App_FName
    Input Text From Profile    ${Path_LFR_RS_Sign_Prim_App_LName}    \\Review_Declare_File\\Prim_App_LName
    Click On Button    ${Path_LFR_RS_Review_Btn}
    Click On Button    ${Path_LFRY_Appl_Confm_Finish}
    Wait Until Element Is Visible    ${Path_LFRY_Appl_Confm_Nbr}    5 min
    Capture Page Screenshot    Appl_cnf.png
    ${Cnf_nbr}=    Get Text    ${Path_LFRY_Appl_Confm_Nbr}
    # Write To Excel    ${excel}    Sheet1    ${row}    9    Created
    @{Cnf_nbr}=    Split string    ${Cnf_nbr}    :
    [Return]    ${Cnf_nbr}[1]

Add Household P2
    [Arguments]    ${Locator}    ${Key}
    ${KeyIsPresent}    ${Value}=    Get Value    ${Key}
    Run Keyword If    ${KeyIsPresent}    Click Element    ${Locator}
    Run Keyword If    ${KeyIsPresent}    Add Person2 Household
    ...    ELSE    Click Button    ${Path_LFRY_HHD_P2_Save_And_Next}

Add Household P3
    [Arguments]    ${Locator}    ${Key}
    ${KeyIsPresent}    ${Value}=    Get Value    ${Key}
    Run Keyword If    ${KeyIsPresent}    Click Element    ${Locator}
    Run Keyword If    ${KeyIsPresent}    Add Person3 Household
    ...    ELSE    Click Button    ${Path_LFRY_HHD_P2_Save_And_Next}

Add Person2 Household
    Click Element    ${Path_LFRY_HHD_Add_Person}
    Wait Until Element Is Visible    ${Path_LFRY_HHD_First_Name_P2}    2 min
    Input Text From Profile    ${Path_LFRY_HHD_First_Name_P2}    \\Persons\\P2\\First_Name
    Input Text From Profile    ${Path_LFRY_HHD_Middle_Name_P2}    \\Persons\\P2\\Middle_Name
    Input Text From Profile    ${Path_LFRY_HHD_Last_Name_P2}    \\Persons\\P2\\Last_Name
    Select List Item From Profile    ${Path_LFRY_Suffix_P2}    \\Persons\\P2\\Suffix
    Select List Item From Profile    ${Path_LFRY_HHD_Relation_Of_P2}    \\Persons\\P2\\Relationship_P1
    sleep    5
    Valid Date Entry    ${Path_LFRY_HH_Date_Of_Birth_P2}    \\Persons\\P2\\DOB
    Select List Item From Profile    ${Path_LFRY_Gender_P2}    \\Persons\\P2\\Gender
    Input Text From Profile    ${Path_LFRY_Name_Of_Spouse_P2}    \\Persons\\P2\\Name_of_Spouse
	Sleep	5
    Input Text From Profile    ${Path_LFRY_SSN_P2}    \\Persons\\P2\\SSN
    Select List Item From Profile    ${Path_LFRY_HHD_Does_P2_Live_At_Same_Address}    \\Persons\\P2\\P2_Live_Same_Addrs
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Address_Home_Line_1}    \\Persons\\P2\\Address_Line1
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Address_Home_Apartment}    \\Persons\\P2\\Apt_Num
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Address_Home_City_Name}    \\Persons\\P2\\City
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Address_State }    \\Persons\\P2\\State
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Address_ZipCode }    \\Persons\\P2\\Zip
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Address_County }    \\Persons\\P2\\County
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Mlng_Address_Line_1}    \\Persons\\P2\\Mlng_Address_Line_1
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Mlng_Address_Apartment}    \\Persons\\P2\\Mlng_Address_Apartment
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Mlng_Address_City_Name}    \\Persons\\P2\\Mlng_Address_City_Name
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Mlng_Address_State}    \\Persons\\P2\\Mlng_Address_State
    Input Text From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Mlng_Address_ZipCode}    \\Persons\\P2\\Mlng_Address_ZipCode
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Lives_Different_Mlng_Address_County}    \\Persons\\P2\\Mlng_Address_County
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Plan_Income_Tax_Next_Yr}    \\Persons\\P2\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr
    Select List Item From Profile    ${Path_LFRY_HHD_P2_File_Jointly_With_Spouse}    \\Persons\\P2\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe
    Input Text From Profile    ${Path_LFRY_HHD_P2_File_Jointly_With_Spouse_Yes_First_Name}    \\Persons\\P2\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Fname
    Input Text From Profile    ${Path_LFRY_HHD_P2_File_Jointly_With_Spouse_Yes_Middle_Name}    \\Persons\\P2\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Mname
    Input Text From Profile    ${Path_LFRY_HHD_P2_File_Jointly_With_Spouse_Yes_Last_Name}    \\Persons\\P2\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Lname
    Select List Item From Profile    ${Path_LFRY_HHD_P2_File_Jointly_With_Spouse_Yes_Claim_dpndnts_On_Tax_Rtrn}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return
    Input Text From Profile    ${Path_LFRY_HHD_P2_File_Jntly_With_Spse_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_Frst_Nam}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    Input Text From Profile    ${Path_LFRY_HHD_P2_Fle_Jntly_Wth_Spse_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_Mddle_Nam}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    Input Text From Profile    ${Path_LFRY_HHD_P2_Fle_Jntly_Wth_Spse_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_Lst_Name}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    Input Text From Profile    ${Path_LFRY_HHD_P2_Fle_Jntly_WSps_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_ADpndnt_Fst_Nam}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Fname
    Input Text From Profile    ${Path_LFRY_HHD_P2_Fle_Jntly_WSps_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_ADpndnt_Mdl_Nam}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Mname
    Input Text From Profile    ${Path_LFRY_HHD_P2_Fle_Jntly_WSps_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_ADpndnt_Lst_Nam}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Lname
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Be_Claimed_As_Dependent_On_Someone_Tax_Return }    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return
    Input Text From Profile    ${Path_LFRY_HHD_P2_Be_Clmd_As_Dpndnt_On_Someone_Tax_Rtrn_Tax_Filer_First_Name}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    Input Text From Profile    ${Path_LFRY_HHD_P2_Be_Clmd_As_Dpndnt_On_Someone_Tax_Rtrn_Tax_Filer_Mddle_Name}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    Input Text From Profile    ${Path_LFRY_HHD_P2_Be_Clmd_As_Dpndnt_On_Someone_Tax_Rtrn_Tax_Filer_Last_Name}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Be_Claimed_As_Dependent_Not_Part_Of_Household_Chkbx}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Nt_Prt_Of_Hsehold
    Select List Item From Profile    ${Path_LFRY_HHD_P2_B_Clmd_As_Dpndnt_Nt_Part_Of_Hhold_And_Hw_Rltd_To_Tax_Filr}    \\Persons\\P2\\Tax_Info\\Dependent_On_Tax_Return\\Tax_Filer
    Select List Item From Profile    ${Path_LFRY_HHD_Is_P2_Pregnant}    \\Persons\\P2\\Pregnant
    Select List Item From Profile    ${Path_LFRY_HHD_Is_P2_Pregnant_Yes_Hw_Mny_Babies_Are_Expctd_Durng_Prgnancy}    \\Persons\\P2\\Expected_Babies
    Input Text From Profile    ${Path_LFRY_HHD_Is_P2_Pregnant_Yes_Expected_Due_Date}    \\Persons\\P2\\Expected_Due_Date
    Select Radio Button From Profile    ${Path_LFRY_HHD_P2_Needs_Health_Coverage}    \\Persons\\P2\\Need_Hlth_Cvrge
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Have_Disability_Last_More_Than_Twelve_Months}    \\Persons\\P2\\Health_Coverage\\Disability_Lasts_12_Months
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Hv_Dsblty_Lst_Mre_Thn_Twlv_Mnths_Ys_Crntly_Rcv_LTrm_CSrvcs}    \\Persons\\P2\\Health_Coverage\\Disability_Lasts_12_Months\\Nursing_Srv
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Received_LTerm_Care_Nursing_Services_In_Three_Months}    \\Persons\\P2\\Health_Coverage\\Disability_Lasts_12_Months\\Lst_Three_Mnths
    Input Text From Profile    ${Path_LFRY_HHD_P2_Received_LTerm_Care_Nursing_Services_In_Three_Months_Ys_Frm}    \\Persons\\P2\\Health_Coverage\\Disability_Lasts_12_Months\\From_Dt
    Input Text From Profile    ${Path_LFRY_HHD_P2_Received_LTerm_Care_Nursing_Services_In_Three_Months_Yes_To}    \\Persons\\P2\\Health_Coverage\\Disability_Lasts_12_Months\\To_Dt
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Think_Need_LTerm_Care_Nursing_Services_Now}    \\Persons\\P2\\Health_Coverage\\Disability_Lasts_12_Months\\Nursng_srvcs_Now
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Receive_SSI}    \\Persons\\P2\\Health_Coverage\\Disability_Lasts_12_Months\\SSI
    Select List Item From Profile    ${Path_LFRY_PAD_P2_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_imdt_Prior_date_Of_Appl}    \\Persons\\P2\\Health_Coverage\\Recve_Med_Servc
    Valid Date Entry    ${Path_LFRY_PAD_P2_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_Prior_date_Of_App_Y_Frm}    \\Persons\\P2\\Health_Coverage\\From_Dt
    Valid Date Entry    ${Path_LFRY_PAD_P2_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_Prior_date_Of_App_Y_To}    \\Persons\\P2\\Health_Coverage\\To_Dt
    Select List Item From Profile    ${Path_LFRY_HHD_P2_US_Citizen_Or_National}    \\Persons\\P2\\Health_Coverage\\US_Citizen
    Select List Item From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Has_Elgbl_Imgrtn}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts
    Select List Item From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Has_Elgbl_Imgrtn_Ys _Doc}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Immgtn_Doc_Type
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Has_Elgbl_Imgrtn_Ys_SType}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Status_Type
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Ntnl_Has_Elgbl_Imgrtn_Ys_NAs_On_Imgrtn_Dc}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Name_Imig_Doc
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_Vsan}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Visa_AN
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_Vsain}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Visa_94
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_Vsapn}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Visa_PN
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_PEdt}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Visa_DOE
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_ODoc}    \\Persons\\P2\\Health_Coverage\\Elig_Immgration_Sts\\Visa_OD
    Input Text From Profile    ${Path_LFRY_HHD_If_P2_Date_Of_Entry_To_US_On_Immigration_Doc_Listed}    \\Persons\\P2\\Health_Coverage\\Date_Prmnt_Lawfl_Resdnt
    Select Radio Button From Profile    ${Path_LFRY_HHD_Is_P2_Ctzn_Of_Fdrtd_Stats_Of_Micrnsia_Rpblc_Of_Mrshl_Islnds}    \\Persons\\P2\\Health_Coverage\\Date_Prmnt_Lawfl_Resdnt\\Marshall_Islands_Palau
    Select List Item From Profile    ${Path_LFRY_HHD_Is_P2_Or_Their_Spse_Prnt_A_Vtrn_Or_Actv_Duty_Mmbr_Of_US_Mltry}    \\Persons\\P2\\Health_Coverage\\Date_Prmnt_Lawfl_Resdnt\\US_Military
    Select List Item From Profile    ${Path_LFRY_HHD_P2_In_Foster_Care_At_Age_Eighteen_Or_Older_In_Hawaii}    \\Persons\\P2\\Health_Coverage\\In_foster_18
    Select List Item From Profile    ${Path_LFRY_HHD_Is_P2_Full_Time_Student}    \\Persons\\P2\\Health_Coverage\\full_time_student
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Chicano}    \\Persons\\P2\\Health_Coverage\\Ethnicity\\Chicano
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_American}    \\Persons\\P2\\Health_Coverage\\Ethnicity\\American
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Other}    \\Persons\\P2\\Health_Coverage\\Ethnicity\\Other
    Input Text From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Other_Country}    \\Persons\\P2\\Health_Coverage\\Ethnicity\\Other_County
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Cuban}    \\Persons\\P2\\Health_Coverage\\Ethnicity\\Cuban
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Puerto_Rican}    \\Persons\\P2\\Health_Coverage\\Ethnicity\\Puerto_Rican
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_If_Hispanic_Latino_Ethnicity_Mexican}    \\Persons\\P2\\Health_Coverage\\Ethnicity\\Mexican
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_American_Indian_Or_Alaskan}    \\Persons\\P2\\Health_Coverage\\Race\\American_Indian_Or_Alaskan
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Chinese}    \\Persons\\P2\\Health_Coverage\\Race\\Chinese
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Japanese}    \\Persons\\P2\\Health_Coverage\\Race\\Japanese
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Other_Asian}    \\Persons\\P2\\Health_Coverage\\Race\\Other_Asian
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Vietnamese}    \\Persons\\P2\\Health_Coverage\\Race\\Vietnamese
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Other}    \\Persons\\P2\\Health_Coverage\\Race\\Other
    Input Text From Profile    ${Path_LFRY_HHD_P2_Race_Other_Country}    \\Persons\\P2\\Health_Coverage\\Race\\Other_County
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Asian_Indian}    \\Persons\\P2\\Health_Coverage\\Race\\Asian_Indian
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Filipino}    \\Persons\\P2\\Health_Coverage\\Race\\Filipino
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Korean}    \\Persons\\P2\\Health_Coverage\\Race\\Korean
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Other_Pacific_Islander}    \\Persons\\P2\\Health_Coverage\\Race\\Other_Pacific_Islander
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_White}    \\Persons\\P2\\Health_Coverage\\Race\\White
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Black_Or_African_American}    \\Persons\\P2\\Health_Coverage\\Race\\African_American
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Guamanian_Or_Chamorro}    \\Persons\\P2\\Health_Coverage\\Race\\Guamanian_Or_Chamorro
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Native_Hawaiian}    \\Persons\\P2\\Health_Coverage\\Race\\Hawaiian
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Race_Samoan}    \\Persons\\P2\\Health_Coverage\\Race\\Samoan
    Select Radio Button From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed}    \\Persons\\P2\\Type_Of_Employment
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Name}    \\Persons\\P2\\Employment\\Employer_Name
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Phone}    \\Persons\\P2\\Employment\\PH_Nbr
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Address_L1}    \\Persons\\P2\\Employment\\Address_Line1
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Apartment_Number}    \\Persons\\P2\\Employment\\Apt_Num
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_City}    \\Persons\\P2\\Employment\\City
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_State}    \\Persons\\P2\\Employment\\State
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Zip_Code}    \\Persons\\P2\\Employment\\Zip_Code
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Wages_Tips}    \\Persons\\P2\\Employment\\Wages
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Wages_How_Often}    \\Persons\\P2\\Employment\\How_Often
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Wages_Income_Start_Date}    \\Persons\\P2\\Employment\\Income_Start_Date
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Emp_Wages_Income_End_Date}    \\Persons\\P2\\Employment\\Income_End_Date
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Name}    \\Persons\\P2\\Employment\\Add_New_Job\\Employer_Name
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Phone}    \\Persons\\P2\\Employment\\Add_New_Job\\PH_Nbr
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Address_Line_1}    \\Persons\\P2\\Employment\\Add_New_Job\\Address_Line1
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_suite_number}    \\Persons\\P2\\Employment\\Add_New_Job\\Apt_Num
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_City}    \\Persons\\P2\\Employment\\Add_New_Job\\City
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_State}    \\Persons\\P2\\Employment\\Add_New_Job\\State
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Zip_Code}    \\Persons\\P2\\Employment\\Add_New_Job\\ZIP
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wages}    \\Persons\\P2\\Employment\\Add_New_Job\\Wages
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wges_Hw_Oftn}    \\Persons\\P2\\Employment\\Add_New_Job\\How_Often
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wges_Strt_Date}    \\Persons\\P2\\Employment\\Add_New_Job\\Income_Start_Date
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wges_End_Date}    \\Persons\\P2\\Employment\\Add_New_Job\\Income_End_Date
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Employed_In_The_Past_Year_Did_P2}    \\Persons\\P2\\Employment\\Change_Job_Past_Year
    Select Checkbox From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Self_Employed}    \\Persons\\P2\\Self_Employed
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Self_Employed_Type_Of_Work}    \\Persons\\P2\\Self_Employed\\Type_Of_Work
    Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplmnt_Slf_Emply_Tpe_Of_Wrk_Hw_Mch_Nt_Incm_Yu_Gt_Pd}    \\Persons\\P2\\Self_Employed\\Paid_Net_Income
    Select Radio Button From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Not_Employed}    \\Persons\\P2\\Not_Employed
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Other_Income_This_Month_Income_Type}    \\Persons\\P2\\Other_Income\\Income_Type
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Other_Income_This_Month_Income_Amount}    \\Persons\\P2\\Other_Income\\Amount
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Other_Income_This_Mnth_Incm_Amnt_Hw_Oftn}    \\Persons\\P2\\Other_Income\\How_Often
    Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_This_Mnth_Incm_Avg_Hrs_Wkd_EWeek}    \\Persons\\P2\\Other_Income\\Dys_Wrkd_Ech_Wk
    Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_This_Mnth_Incme_Strt_Date}    \\Persons\\P2\\Other_Income\\Income_Start_Date
    Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_This_Mnth_Incme_End_Date}    \\Persons\\P2\\Other_Income\\Income_End_Date
    # Click Element    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_Add_More_Income_Types}
    # Select List Item From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_Add_More_Income_Types_Othr_Incme}    \\Persons\\P2\\Other_Income\\Add_More_Income\\Income_Type
    # Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplmnt_Othr_Incm_Add_Mre_Incm_Typ_Typ_Amnt}    \\Persons\\P2\\Other_Income\\Add_More_Income\\Amount
    # Select List Item From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_How_Often}    \\Persons\\P2\\Other_Income\\Add_More_Income\\How_Often
    # Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_NDys_Wkd_EWeek}    \\Persons\\P2\\Other_Income\\Add_More_Income\\Dys_Wrkd_Ech_Wk
    # Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_Incme_Strt_Dte}    \\Persons\\P2\\Other_Income\\Add_More_Income\\Income_Start_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P2_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_Incme_End_Dte}    \\Persons\\P2\\Other_Income\\Add_More_Income\\Income_End_Date
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Type_Of_Dductn}    \\Persons\\P2\\Deductions\\Type_Of_Deduction
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Amount}    \\Persons\\P2\\Deductions\\Amount
    Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Amount_How_Often}    \\Persons\\P2\\Deductions\\How_Often
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Deduction_Start_Date}    \\Persons\\P2\\Deductions\\Deductn_Start_Date
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Deduction_End_Date}    \\Persons\\P2\\Deductions\\Deductn_End_Date
    # Click Element    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Add_MDductions}
    # Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Add_MDductions_TDduction}    \\Persons\\P2\\Deductions\\Add_More_Deductn\\Type_Of_Deduction
    # Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Add_MDductions_Amount}    \\Persons\\P2\\Deductions\\Add_More_Deductn\\Amount
    # Select List Item From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Add_MDductions_Hw_Oftn}    \\Persons\\P2\\Deductions\\Add_More_Deductn\\How_Often
    # Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Add_MDductions_Dductn_Strt_Date}    \\Persons\\P2\\Deductions\\Add_More_Deductn\\Deductn_Start_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Deductions_Add_MDductions_Dductn_End_Date}    \\Persons\\P2\\Deductions\\Add_More_Deductn\\Deductn_End_Date
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Yearly_Income_Total_Income_This_Year}    \\Persons\\P2\\Yearly_Income\\Total income This year
    Input Text From Profile    ${Path_LFRY_HHD_P2_Type_Of_Employment_Yearly_Income_Total_Income_Next_Year}    \\Persons\\P2\\Yearly_Income\\Total income next year
    # Click On Button    ${Path_LFRY_HHD_P2_Save_And_Next}
    Click Element    ${Path_LFRY_HHD_Add_Person}
    sleep    5
    ${KeyPresent_P3}    ${value}=    Get value    \\Persons\\P3
    Run Keyword If    ${KeyPresent_P3}    Add Person3 Household
    ...    ELSE    Click Element    ${Path_LFRY_HHD_P2_Save_And_Next}

Add Person3 Household
    ######    Add P3 details here
    Click Element    ${Path_LFRY_HHD_Add_Person}
    Wait Until Element Is Visible    ${Path_LFRY_HHD_First_Name_P3}    2 min
    Input Text From Profile    ${Path_LFRY_HHD_First_Name_P3}    \\Persons\\P3\\First_Name
    Input Text From Profile    ${Path_LFRY_HHD_Middle_Name_P3}    \\Persons\\P3\\Middle_Name
    Input Text From Profile    ${Path_LFRY_HHD_Last_Name_P3}    \\Persons\\P3\\Last_Name
    Select List Item From Profile    ${Path_LFRY_Suffix_P3}    \\Persons\\P3\\Suffix
    Select List Item From Profile    ${Path_LFRY_HHD_Relation_Of_P3}    \\Persons\\P3\\Relationship_P1
    sleep    5
    # Input Text From Profile    ${Path_LFRY_HH_Date_Of_Birth_P3}    \\Persons\\P3\\DOB
    Valid Date Entry    ${Path_LFRY_HH_Date_Of_Birth_P3}    \\Persons\\P3\\DOB
    # Enter Valid Date Format    ${Path_LFRY_HH_Date_Of_Birth_P3}    \\Persons\\P3\\DOB
    Select List Item From Profile    ${Path_LFRY_Gender_P3}    \\Persons\\P3\\Gender
    Input Text From Profile    ${Path_LFRY_Name_Of_Spouse_P3}    \\Persons\\P3\\Name_of_Spouse
    Input Text From Profile    ${Path_LFRY_SSN_P3}    \\Persons\\P3\\SSN
    Select List Item From Profile    ${Path_LFRY_HHD_Does_P3_Live_At_Same_Address}    \\Persons\\P3\\P2_Live_Same_Addrs
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Address_Home_Line_1}    \\Persons\\P3\\Address_Line1
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Address_Home_Apartment}    \\Persons\\P3\\Apt_Num
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Address_Home_City_Name}    \\Persons\\P3\\City
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Address_State }    \\Persons\\P3\\State
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Address_ZipCode }    \\Persons\\P3\\Zip
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Address_County }    \\Persons\\P3\\County
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Mlng_Address_Line_1}    \\Persons\\P3\\Mlng_Address_Line_1
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Mlng_Address_Apartment}    \\Persons\\P3\\Mlng_Address_Apartment
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Mlng_Address_City_Name}    \\Persons\\P3\\Mlng_Address_City_Name
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Mlng_Address_State}    \\Persons\\P3\\Mlng_Address_State
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Mlng_Address_ZipCode}    \\Persons\\P3\\Mlng_Address_ZipCode
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Lives_Different_Mlng_Address_County}    \\Persons\\P3\\Mlng_Address_County
    Select List Item From Profile    ${Path_LFRY_HHD_P3_Plan_Income_Tax_Next_Yr}    \\Persons\\P3\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_File_Jointly_With_Spouse}    \\Persons\\P3\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe
    # Input Text From Profile    ${Path_LFRY_HHD_P3_File_Jointly_With_Spouse_Yes_First_Name}    \\Persons\\P3\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Fname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_File_Jointly_With_Spouse_Yes_Middle_Name}    \\Persons\\P3\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Mname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_File_Jointly_With_Spouse_Yes_Last_Name}    \\Persons\\P3\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Lname
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_File_Jointly_With_Spouse_Yes_Claim_dpndnts_On_Tax_Rtrn}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return
    # Input Text From Profile    ${Path_LFRY_HHD_P3_File_Jntly_With_Spse_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_Frst_Nam}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Fle_Jntly_Wth_Spse_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_Mddle_Nam}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Fle_Jntly_Wth_Spse_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_Lst_Name}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Fle_Jntly_WSps_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_ADpndnt_Fst_Nam}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Fname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Fle_Jntly_WSps_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_ADpndnt_Mdl_Nam}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Mname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Fle_Jntly_WSps_Ys_Clm_dpndnts_On_Tx_Rtrn_Ys_ADpndnt_Lst_Nam}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Lname
    Select List Item From Profile    ${Path_LFRY_HHD_P3_Be_Claimed_As_Dependent_On_Someone_Tax_Return }    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Be_Clmd_As_Dpndnt_On_Someone_Tax_Rtrn_Tax_Filer_First_Name}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Be_Clmd_As_Dpndnt_On_Someone_Tax_Rtrn_Tax_Filer_Mddle_Name}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Be_Clmd_As_Dpndnt_On_Someone_Tax_Rtrn_Tax_Filer_Last_Name}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Be_Claimed_As_Dependent_Not_Part_Of_Household_Chkbx}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Nt_Prt_Of_Hsehold
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_B_Clmd_As_Dpndnt_Nt_Part_Of_Hhold_And_Hw_Rltd_To_Tax_Filr}    \\Persons\\P3\\Tax_Info\\Dependent_On_Tax_Return\\Tax_Filer
    # Select List Item From Profile    ${Path_LFRY_HHD_Is_P3_Pregnant}    \\Persons\\P3\\Pregnant
    # Select List Item From Profile    ${Path_LFRY_HHD_Is_P3_Pregnant_Yes_Hw_Mny_Babies_Are_Expctd_Durng_Prgnancy}    \\Persons\\P3\\Expected_Babies
    # Input Text From Profile    ${Path_LFRY_HHD_Is_P3_Pregnant_Yes_Expected_Due_Date}    \\Persons\\P3\\Expected_Due_Date
    Select Radio Button From Profile    ${Path_LFRY_HHD_P3_Needs_Health_Coverage}    \\Persons\\P3\\Need_Hlth_Cvrge
    Select List Item From Profile    ${Path_LFRY_HHD_P3_Have_Disability_Last_More_Than_Twelve_Months}    \\Persons\\P3\\Health_Coverage\\Disability_Lasts_12_Months
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Hv_Dsblty_Lst_Mre_Thn_Twlv_Mnths_Ys_Crntly_Rcv_LTrm_CSrvcs}    \\Persons\\P3\\Health_Coverage\\Disability_Lasts_12_Months\\Nursing_servces
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Received_LTerm_Care_Nursing_Services_In_Three_Months}    \\Persons\\P3\\Health_Coverage\\Disability_Lasts_12_Months\\Lst_Three_Mnths
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Received_LTerm_Care_Nursing_Services_In_Three_Months_Ys_Frm}    \\Persons\\P3\\Health_Coverage\\Disability_Lasts_12_Months\\From_Dt
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Received_LTerm_Care_Nursing_Services_In_Three_Months_Yes_To}    \\Persons\\P3\\Health_Coverage\\Disability_Lasts_12_Months\\To_Dt
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Think_Need_LTerm_Care_Nursing_Services_Now}    \\Persons\\P3\\Health_Coverage\\Disability_Lasts_12_Months\\Nursng_srvcs_Now
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Receive_SSI}    \\Persons\\P3\\Health_Coverage\\Disability_Lasts_12_Months\\SSI
    Select List Item From Profile    ${Path_LFRY_HHD_P3_Receive_Any_Medical_Srvcs_In_Ten_Clndr_Dys_Imdtly_Prir_To}    \\Persons\\P3\\Health_Coverage\\Recve_Med_Servc
    Input Text From Profile    ${Path_LFRY_HHD_P3_Rcv_Any_Mdcl_Srvcs_In_Ten_Clndr_Dys_Imdtly_Prir_To_Ys_Frm}    \\Persons\\P3\\Health_Coverage\\From_Dt
    Input Text From Profile    ${Path_LFRY_HHD_P3_Rcv_Any_Mdcl_Srvcs_In_Ten_Clndr_Dys_Imdtly_Prir_To_Ys_To}    \\Persons\\P3\\Health_Coverage\\To_Dt
    Select List Item From Profile    ${Path_LFRY_HHD_P3_US_Citizen_Or_National}    \\Persons\\P3\\Health_Coverage\\US_Citizen
    # Select List Item From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Has_Elgbl_Imgrtn}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts
    # Select List Item From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Has_Elgbl_Imgrtn_Ys _Doc}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Immgtn_Doc_Type
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Has_Elgbl_Imgrtn_Ys_SType}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Status_Type
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Ntnl_Has_Elgbl_Imgrtn_Ys_NAs_On_Imgrtn_Dc}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Name_Imig_Doc
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_Vsan}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Visa_AN
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_Vsain}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Visa_94
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_Vsapn}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Visa_PN
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_PEdt}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Visa_DOE
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Is_Nt_US_Ctzn_Or_Nt_US_Ntnl_Hs_Elgbl_Imgrtn_Ys_Doc_ODoc}    \\Persons\\P3\\Health_Coverage\\Elig_Immgration_Sts\\Visa_OD
    # Input Text From Profile    ${Path_LFRY_HHD_If_P3_Date_Of_Entry_To_US_On_Immigration_Doc_Listed}    \\Persons\\P3\\Health_Coverage\\Date_Prmnt_Lawfl_Resdnt
    # Select Radio Button From Profile    ${Path_LFRY_HHD_Is_P3_Ctzn_Of_Fdrtd_Stats_Of_Micrnsia_Rpblc_Of_Mrshl_Islnds}    \\Persons\\P3\\Health_Coverage\\Date_Prmnt_Lawfl_Resdnt\\Marshall_Islands_Palau
    # Select List Item From Profile    ${Path_LFRY_HHD_Is_P3_Or_Their_Spse_Prnt_A_Vtrn_Or_Actv_Duty_Mmbr_Of_US_Mltry}    \\Persons\\P3\\Health_Coverage\\Date_Prmnt_Lawfl_Resdnt\\US_Military
    Select List Item From Profile    ${Path_LFRY_HHD_P3_In_Foster_Care_At_Age_Eighteen_Or_Older_In_Hawaii}    \\Persons\\P3\\Health_Coverage\\In_foster_18
    Select List Item From Profile    ${Path_LFRY_HHD_Is_P3_Full_Time_Student}    \\Persons\\P3\\Health_Coverage\\full_time_student
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_If_Hispanic_Latino_Ethnicity_Chicano}    \\Persons\\P3\\Health_Coverage\\Ethnicity\\Chicano
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_If_Hispanic_Latino_Ethnicity_American}    \\Persons\\P3\\Health_Coverage\\Ethnicity\\American
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_If_Hispanic_Latino_Ethnicity_Other}    \\Persons\\P3\\Health_Coverage\\Ethnicity\\Other
    # Input Text From Profile    ${Path_LFRY_HHD_P3_If_Hispanic_Latino_Ethnicity_Other_Country}    \\Persons\\P3\\Health_Coverage\\Ethnicity\\Other_County
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_If_Hispanic_Latino_Ethnicity_Cuban}    \\Persons\\P3\\Health_Coverage\\Ethnicity\\Cuban
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_If_Hispanic_Latino_Ethnicity_Puerto_Rican}    \\Persons\\P3\\Health_Coverage\\Ethnicity\\Puerto_Rican
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_If_Hispanic_Latino_Ethnicity_Mexican}    \\Persons\\P3\\Health_Coverage\\Ethnicity\\Mexican
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_American_Indian_Or_Alaskan}    \\Persons\\P3\\Health_Coverage\\Race\\American_Indian_Or_Alaskan
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Chinese}    \\Persons\\P3\\Health_Coverage\\Race\\Chinese
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Japanese}    \\Persons\\P3\\Health_Coverage\\Race\\Japanese
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Other_Asian}    \\Persons\\P3\\Health_Coverage\\Race\\Other_Asian
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Vietnamese}    \\Persons\\P3\\Health_Coverage\\Race\\Vietnamese
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Other}    \\Persons\\P3\\Health_Coverage\\Race\\Other
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Race_Other_Country}    \\Persons\\P3\\Health_Coverage\\Race\\Other_County
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Asian_Indian}    \\Persons\\P3\\Health_Coverage\\Race\\Asian_Indian
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Filipino}    \\Persons\\P3\\Health_Coverage\\Race\\Filipino
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Korean}    \\Persons\\P3\\Health_Coverage\\Race\\Korean
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Other_Pacific_Islander}    \\Persons\\P3\\Health_Coverage\\Race\\Other_Pacific_Islander
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_White}    \\Persons\\P3\\Health_Coverage\\Race\\White
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Black_Or_African_American}    \\Persons\\P3\\Health_Coverage\\Race\\African_American
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Guamanian_Or_Chamorro}    \\Persons\\P3\\Health_Coverage\\Race\\Guamanian_Or_Chamorro
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Native_Hawaiian}    \\Persons\\P3\\Health_Coverage\\Race\\Hawaiian
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Race_Samoan}    \\Persons\\P3\\Health_Coverage\\Race\\Samoan
    # Select Radio Button From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed}    \\Persons\\P3\\Type_Of_Employment
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Name}    \\Persons\\P3\\Employment\\Employer_Name
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Phone}    \\Persons\\P3\\Employment\\PH_Nbr
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Address_L1}    \\Persons\\P3\\Employment\\Address_Line1
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Apartment_Number}    \\Persons\\P3\\Employment\\Apt_Num
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_City}    \\Persons\\P3\\Employment\\City
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_State}    \\Persons\\P3\\Employment\\State
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Zip_Code}    \\Persons\\P3\\Employment\\Zip_Code
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Wages_Tips}    \\Persons\\P3\\Employment\\Wages
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Wages_How_Often}    \\Persons\\P3\\Employment\\How_Often
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Wages_Income_Start_Date}    \\Persons\\P3\\Employment\\Income_Start_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Emp_Wages_Income_End_Date}    \\Persons\\P3\\Employment\\Income_End_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Name}    \\Persons\\P3\\Employment\\Add_New_Job\\Employer_Name
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Phone}    \\Persons\\P3\\Employment\\Add_New_Job\\PH_Nbr
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Address_Line_1}    \\Persons\\P3\\Employment\\Add_New_Job\\Address_Line1
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_suite_number}    \\Persons\\P3\\Employment\\Add_New_Job\\Apt_Num
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_City}    \\Persons\\P3\\Employment\\Add_New_Job\\City
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_State}    \\Persons\\P3\\Employment\\Add_New_Job\\State
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Zip_Code}    \\Persons\\P3\\Employment\\Add_New_Job\\ZIP
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wages}    \\Persons\\P3\\Employment\\Add_New_Job\\Wages
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wges_Hw_Oftn}    \\Persons\\P3\\Employment\\Add_New_Job\\How_Often
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wges_Strt_Date}    \\Persons\\P3\\Employment\\Add_New_Job\\Income_Start_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_Add_New_Jobs_Emp_Wges_End_Date}    \\Persons\\P3\\Employment\\Add_New_Job\\Income_End_Date
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Employed_In_The_Past_Year_Did_P3}    \\Persons\\P3\\Employment\\Change_Job_Past_Year
    # Select Checkbox From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Self_Employed}    \\Persons\\P3\\Self_Employed
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Self_Employed_Type_Of_Work}    \\Persons\\P3\\Self_Employed\\Type_Of_Work
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplmnt_Slf_Emply_Tpe_Of_Wrk_Hw_Mch_Nt_Incm_Yu_Gt_Pd}    \\Persons\\P3\\Self_Employed\\Paid_Net_Income
    Select Radio Button From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Not_Employed}    \\Persons\\P3\\Not_Employed
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Other_Income_This_Month_Income_Type}    \\Persons\\P3\\Other_Income\\Income_Type
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Other_Income_This_Month_Income_Amount}    \\Persons\\P3\\Other_Income\\Amount
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Other_Income_This_Mnth_Incm_Amnt_Hw_Oftn}    \\Persons\\P3\\Other_Income\\How_Often
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_This_Mnth_Incm_Avg_Hrs_Wkd_EWeek}    \\Persons\\P3\\Other_Income\\Dys_Wrkd_Ech_Wk
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_This_Mnth_Incme_Strt_Date}    \\Persons\\P3\\Other_Income\\Income_Start_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_This_Mnth_Incme_End_Date}    \\Persons\\P3\\Other_Income\\Income_End_Date
    # # Click Element    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_Add_More_Income_Types}
    # # Select List Item From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_Add_More_Income_Types_Othr_Incme}    \\Persons\\P3\\Other_Income\\Add_More_Income\\Income_Type
    # # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplmnt_Othr_Incm_Add_Mre_Incm_Typ_Typ_Amnt}    \\Persons\\P3\\Other_Income\\Add_More_Income\\Amount
    # # Select List Item From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_How_Often}    \\Persons\\P3\\Other_Income\\Add_More_Income\\How_Often
    # # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_NDys_Wkd_EWeek}    \\Persons\\P3\\Other_Income\\Add_More_Income\\Dys_Wrkd_Ech_Wk
    # # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_Incme_Strt_Dte}    \\Persons\\P3\\Other_Income\\Add_More_Income\\Income_Start_Date
    # # Input Text From Profile    ${Path_LFRY_HHD_P3_Tpe_Of_Emplymnt_Othr_Incme_Add_Mre_Incm_Typs_Incme_End_Dte}    \\Persons\\P3\\Other_Income\\Add_More_Income\\Income_End_Date
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Type_Of_Dductn}    \\Persons\\P3\\Deductions\\Type_Of_Deduction
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Amount}    \\Persons\\P3\\Deductions\\Amount
    # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Amount_How_Often}    \\Persons\\P3\\Deductions\\How_Often
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Deduction_Start_Date}    \\Persons\\P3\\Deductions\\Deductn_Start_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Deduction_End_Date}    \\Persons\\P3\\Deductions\\Deductn_End_Date
    # # Click Element    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Add_MDductions}
    # # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Add_MDductions_TDduction}    \\Persons\\P3\\Deductions\\Add_More_Deductn\\Type_Of_Deduction
    # # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Add_MDductions_Amount}    \\Persons\\P3\\Deductions\\Add_More_Deductn\\Amount
    # # Select List Item From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Add_MDductions_Hw_Oftn}    \\Persons\\P3\\Deductions\\Add_More_Deductn\\How_Often
    # # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Add_MDductions_Dductn_Strt_Date}    \\Persons\\P3\\Deductions\\Add_More_Deductn\\Deductn_Start_Date
    # # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Deductions_Add_MDductions_Dductn_End_Date}    \\Persons\\P3\\Deductions\\Add_More_Deductn\\Deductn_End_Date
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Yearly_Income_Total_Income_This_Year}    \\Persons\\P3\\Yearly_Income\\Total income This year
    # Input Text From Profile    ${Path_LFRY_HHD_P3_Type_Of_Employment_Yearly_Income_Total_Income_Next_Year}
    Click On Button    ${Path_LFRY_HHD_P2_Save_And_Next}

Iterate VI Table
    [Arguments]    ${rows}
    ${select_id}=    Set Variable    _s_2_l_Status
    ${input_id}    Set Variable    _Status
    # ${i}    Set Variable    1
    FOR    ${i}    IN RANGE    1    ${rows}+1
        ${idd}=    Catenate    ${Path_Siebel_Verification_Items_Status_Element_Select}'${i}${select_id}')]
        log    ${idd}
        ${Inp_id}=    Catenate    ${Path_Siebel_Verification_Items_Status_Input}'${i}${input_id}']
        log    ${Inp_id}
        Click Element    ${idd}    # \    Run Keyword If    ${i} > 1    Click Element    ${idd}    # \    ...    # ELSE    Exit For Loop
        # \    Click Element    ${Path_Siebel_Verification_Items_Status_Element}
        ${status}=    Get Element Attribute    ${Inp_id}    attribute=value
        log    ${status}
        sleep    1
        Run Keyword If    '${status}' == 'E-Failure' or 'Pending Review'    Clear Element Text    ${Inp_id}
        Run Keyword If    '${status}' == 'E-Failure' or 'Pending Review'    Input Text    ${Inp_id}    Verified
        Run Keyword If    '${status}' == 'E-Failure' or 'Pending Review'    Press Keys    ${Inp_id}    ENTER
        ...    ELSE    Continue For Loop
    END

Change VerificationItems
    ${rows}=    Get Element Count    ${Path_Siebel_Contacts_Table_Rows_Count}
    log    ${rows}
    Click Link    ${Path_Siebel_Verification_Items}
    FOR    ${i}    IN RANGE    1    ${rows}+1
        ${hh}=    Catenate    ${Path_Siebel_Contacts_Table_Row_HH}'${i}']
        Click Element    ${hh}
        Change VerificationItems Status Manually
    END

Change VerificationItems Status Manually
    # For Primary
    Click Button    ${Path_Siebel_Verification_Items_Table_Menu}
    Wait Until Keyword Succeeds    50 sec    5 sec    Scroll Element Into View    ${Path_Siebel_Verification_Items_Table_Menu_SelectAll}
    #Scroll Element Into View    ${Path_Siebel_Verification_Items_Table_Menu_SelectAll}
    Wait Until Element Is Visible    ${Path_Siebel_Verification_Items_Table_Menu_SelectAll}    1 min
    Click Element    ${Path_Siebel_Verification_Items_Table_Menu_SelectAll}
    Click Element    ${Path_Siebel_Appl_MainMenu_Edit}
    Click Element    ${Path_Siebel_Appl_MainMenu_Edit_Submenu_ChngeRecords}
    Input Text    ${Path_Siebel_Appl_MainMenu_Edit_Submenu_ChngeRecords_Dialog_Fld1}    Status
    Input Text    ${Path_Siebel_Appl_MainMenu_Edit_Submenu_ChngeRecords_Dialog_Fld2}    Ver
    Click Button    ${Path_Siebel_Appl_MainMenu_Edit_Submenu_ChngeRecords_Dialog_OK}

Run Eligibility
    Click Button    ${Path_Siebel_Process_Change_Btn}
    ${message}=    Handle Alert    ACCEPT    2 min
    ${Batch_status}=    Get Element Attribute    ${Path_Siebel_Case_Batch_Status}    attribute=value
    Run Keyword and Return If    '${Batch_status}' == 'Error'    FAIL    Case status is ERROR and Failing the test case
    Change VerificationItems
    Click Button    ${Path_Siebel_Process_Change_Btn}
    ${message}=    Handle Alert    ACCEPT    2 min
    ${Batch_status}=    Get Element Attribute    ${Path_Siebel_Case_Batch_Status}    attribute=value
    Run Keyword and Return If    '${Batch_status}' == 'Error'    FAIL    Case status is ERROR and Failing the test case

Verify Benefit Plan
    Click Button    ${Path_Siebel_Process_Change_Btn}
    ${message}=    Handle Alert    ACCEPT    2 min
    ${Batch_status}=    Get Element Attribute    ${Path_Siebel_Case_Batch_Status}    attribute=value
    Run Keyword and Return If    '${Batch_status}' == 'Error'    FAIL    Case status is ERROR and Failing the test case
    Change VerificationItems
    Click Button    ${Path_Siebel_Process_Change_Btn}
    ${message}=    Handle Alert    ACCEPT    2 min
    ${Batch_status}=    Get Element Attribute    ${Path_Siebel_Case_Batch_Status}    attribute=value
    Run Keyword and Return If    '${Batch_status}' == 'Error'    FAIL    Case status is    and Failing the test case
    ${case_status}=    Get Element Attribute    ${Path_Siebel_Case_Status}    attribute=value
    log    ${case_status}
    Run Keyword If    '${case_status}' == 'Active'    Wait Until Keyword Succeeds    50 sec    5 sec    Click Link    ${Path_Siebel_Benefit_Plans}
    Wait Until Keyword Succeeds    50 sec    5 sec    Scroll Element Into View    ${Path_Siebel_Benefit_Plans_Table}
    ${time}=    Get time    Seconds
    ${Benefit_PlanName}=    Catenate    Benefit_PlanName${time}
    Capture Page Screenshot    ${Benefit_PlanName}.png

Verify COC Decision Report
    #Click Button    ${Path_Siebel_Process_Change_Btn}
    #${message}=    Handle Alert    ACCEPT    2 min
    Wait Until Keyword Succeeds    50 sec    5 sec    Click Link    ${Path_Siebel_Benefit_Plans}
    Wait Until Keyword Succeeds    50 sec    5 sec    Scroll Element Into View    ${Path_Siebel_Display_Decision_Report}
    Wait Until Keyword Succeeds    50 sec    5 sec    Click Element    ${Path_Siebel_Display_Decision_Report}
    ${status}=    Run Keyword and Return Status    Wait Until Keyword Succeeds    1 min    5 sec    Switch Window    NEW

misc1
    ${Appl_Benefit_PlanName}=    Get Text    ${Path_Siebel_Benefits_Table_Check_PlanName}    #log    ${Appl_Benefit_PlanName}    #${keyPresent}    ${Profile_Benefit_Plan}=    Get value    \\Benefit_Plan    #log    ${Profile_Benefit_Plan}    #Run Keyword If    '${Appl_Benefit_PlanName}' == '${Profile_Benefit_Plan}'    log    Benefit Name Matched    #...    # ELSE
    ...    # log    Benefit Name Not Matched
    [Return]    ${Appl_Benefit_PlanName}

Apply For MAGI Excepted Benefits
	[Arguments]	${rowid}=1
    Click Element    ${Path_Siebel_Task_Btn}
    Click Link    ${Path_Siebel_MAGI1100B_Form}
    Wait Until Element Is Visible    ${Path_Siebel_MAGI_Excepted_Appl_Date}    1 min
    Click Link    ${Path_Siebel_TaskPane_Close}
	Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${rowid}]${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_ClientID }
    Valid Date Entry    ${Path_Siebel_MAGI_Excepted_Appl_Date}    \\1100B\\Magi_Except_Dt
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Next_Btn}
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    \\1100B\\Resource_Type
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    \\1100B\\Resource_Value
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Income_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Spse_sell_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Health_Cvg_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Medcl_Bills_Finish}

Apply For MAGI Benefits
    Click Element    ${Path_Siebel_Task_Btn}
    Click Link    ${Path_Siebel_MAGI1100B_Form}
    Click Link    ${Path_Siebel_TaskPane_Close}
    Valid Date Entry    ${Path_Siebel_MAGI_Excepted_Appl_Date}    \\1100B\\Magi_Except_Dt
    Click Element    xpath=//input[@aria-label='Opt-out of MAGI']
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Next_Btn}
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    \\1100B\\Resource_Type
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text From Profile    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    \\1100B\\Resource_Value
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Income_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Spse_sell_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Health_Cvg_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Medcl_Bills_Finish}

Apply For MAGI Excepted Benefits To Verify Smoke Test
    ${CurDt}=    Get Current Date
    ${CurDt}    Add Time To Date    ${CurDt}    -1 days
    ${CurDt}    Convert Date    ${CurDt}    result_format=%m/%d/%Y
    ${Year_ltr}=    Get Current Date
    ${Year_ltr}=    Add Time To Date    ${Year_ltr}    370 days
    ${Year_ltr}=    Convert Date    ${Year_ltr}    result_format=%m/%d/%Y
    Click Element    ${Path_Siebel_Task_Btn}
    Click Link    ${Path_Siebel_MAGI1100B_Form}
    Click Link    ${Path_Siebel_TaskPane_Close}
    sleep    5
    Input Text    ${Path_Siebel_LTC_Appl_Date}    ${CurDt}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Date}    ${CurDt}
    Select Checkbox    ${Path_Siebel_MAGI_Excepted_Appl_OptOut_Of_MAGI_Chkbx}
    Select Checkbox    ${Path_Siebel_MAGI_Excepted_Appl_NeedHelp_WithDaily_Chkbx}
    Wait Until Keyword Succeeds    50 sec    5 sec    Scroll Element Into View    ${Path_Siebel_MAGI_Excepted_Appl_Disclosed_Annuity_Drpdwn}
    #Scroll Element Into View    ${Path_Siebel_MAGI_Excepted_Appl_Disclosed_Annuity_Drpdwn}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Disclosed_Annuity_Drpdwn}    Y
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Disclosed_Annuity_Drpdwn}    ENTER
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_CommSpse_Disclose_Drpdwn}    Y
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_CommSpse_Disclose_Drpdwn}    ENTER
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_SpsPrnt_Honrbly_Dischrd}    N
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_SpsPrnt_Honrbly_Dischrd}    ENTER
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Does_spse_Liv_Medical_Faclty}    N
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Does_spse_Liv_Medical_Faclty}    ENTER
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_NewBtn}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_FacCode_Srchicon}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_FacCode_Inp}    404
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_FacCode_Inp}    ENTER
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_FacCode_Popup_OK}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_AdmitDate_Fld}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_AdmitDate_Ipt}    ${CurDt}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_DischrgeDate_Fld}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_FacInfo_DischrgeDate_Ipt}    ${Year_ltr}
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Add_LOC_NewBtn}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_LOC_Strdt}    ${CurDt}
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Add_LOC_Strdt}    TAB
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_LOC_Enddt}    ${Year_ltr}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Add_LOC_AprdSts_Fld}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_LOC_AprdSts_Inp}    Acute Waitlist ICF
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Add_LOC_AprdSts_Inp}    ENTER
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_NewBtn}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_SrchIcon}
    # Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_PopName_Ipt}    Acute Care Facility(Hospital)
    # Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_PopName_Ipt}    ENTER
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_Popup_OKBtn}
    sleep    2
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_Type}    TAB
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_StartDate}    ${CurDt}
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_StartDate}    TAB
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Add_LivArng_EndDate}    ${Year_ltr}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Next_Btn}
    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    Cash
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    1000
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Income_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Spse_sell_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Health_Cvg_Next}
    Click Element    ${Path_Siebel_MAGI_Excepted_Appl_MAGI_Excepted_Medcl_Bills_Finish}

Enter Valid Date Format
    [Arguments]    ${Locator}    ${Key}
    Input Text From Profile    ${Locator}    ${Key}
    FOR    ${i}    IN RANGE    10
        # \    Input Text From Profile    ${Locator}    ${Key}
        ${keyPresent}    ${Profile_date}=    Get value    ${Key}
        log    ${Profile_date}
        ${Temp_date}=    Get Element Attribute    ${Locator}    attribute=value
        # \    sleep    5
        Run Keyword If    '${Temp_date}' != '${Profile_date}'    Clear Element Text    ${Locator}
        Run Keyword If    '${Temp_date}' != '${Profile_date}'    sleep    3
        Run Keyword If    '${Temp_date}' != '${Profile_date}'    Input Text From Profile    ${Locator}    ${Key}
        Run Keyword If    '${Temp_date}' != '${Profile_date}'    sleep    3
        ...    ELSE    Exit For Loop
    END

Valid Date Entry
    [Arguments]    ${locator}    ${Key}
    ${keyPresent}    ${Date}=    Get value    ${Key}
    ${Pdate}=    Set Variable    ${Date}
    ${Pdate}=    Split String    ${Pdate}    /
    # log    ${dte}
    Run Keyword If    ${keyPresent}    Set Variable    ${Pdate}[0]
    Run Keyword If    ${keyPresent}    Set Variable    ${Pdate}[1]
    Run Keyword If    ${keyPresent}    Set Variable    ${Pdate}[2]
    # Run Keyword If    ${keyPresent}    Input Text    ${locator}    ${Pdate}[0]${Pdate}[1]${Pdate}[2]
    Run Keyword If    ${keyPresent}    Click Element    ${locator}
    Run Keyword If    ${keyPresent}    Press Keys    ${locator}    ESC
    Run Keyword If    ${keyPresent}    Press Keys    ${locator}    ${Pdate}[0]${Pdate}[1]${Pdate}[2]
    # Run Keyword If    ${keyPresent}    Press Keys    ${locator}    ESC
    sleep    2

Navigate to Medical Services
    Wait Until Keyword Succeeds    50 sec    5 sec    Mouse Over    ${Path_Siebel_Application_Data}
    Click Link    ${Path_Siebel_Medical_Services}
    #Wait Until Element Is Visible    ${Path_Siebel_Dates_Of_Service_Table}    1 min

Apply Medical Services
    ${rows}=    Get Element Count    ${Path_Siebel_Dates_Of_Service_Table}
    Run Keyword If    ${rows}>1    Run Keywords    Click Element    ${Path_Siebel_Dates_Of_Service_Change_Status_Cell}
    ...    AND    Clear Element Text    ${Path_Siebel_Dates_Of_Service_Change_Status_Cell_Input}
    ...    AND    Input Text    ${Path_Siebel_Dates_Of_Service_Change_Status_Cell_Input}    Approved
    ...    AND    Press Keys    ${Path_Siebel_Dates_Of_Service_Change_Status_Cell_Input}    ENTER
    ...    ELSE    log    No table rows

Change Medical Services
    Wait Until Keyword Succeeds    50 sec    5 sec    Scroll Element into View    ${Path_Siebel_Contacts_Table_Rows_Count}
    ${contact_rows}=    Wait Until Keyword Succeeds    50 sec    5 sec    Get Element Count    ${Path_Siebel_Contacts_Table_Rows_Count}
    #${contact_rows}=    Get Element Count    ${Path_Siebel_Contacts_Table_Rows_Count}
    Wait Until Keyword Succeeds    50 sec    5 sec    Mouse Over    ${Path_Siebel_Application_Data}
    Click Link    ${Path_Siebel_Medical_Services}
    FOR    ${i}    IN RANGE    1    ${contact_rows}+1
        ${hh}=    Catenate    ${Path_Siebel_Contacts_Table_Row_HH}'${i}']
        Click Element    ${hh}
        #sleep    5
        Apply Medical Services
    END

Verify Audit Trail Applet
    [Arguments]    ${Row}    ${Business_Comp}    ${Field_Value_Changed}    ${Field_Old_Value}    ${Field_New_Value}
    # ${BC}=    Get Table Cell    ${Path_Siebel_Audit_Trail_Table_Business_Comp_cell}    ${row}    2
    # Run Keyword If    '${BC}' == '${Business_Comp}'    log    PASS
    Table Cell Should Contain    ${Path_Siebel_SiteMap_Audit_Trail_Items_Table}    ${Row}    3    ${Business_Comp}
    Table Cell Should Contain    ${Path_Siebel_SiteMap_Audit_Trail_Items_Table}    ${row}    4    ${Field_Value_Changed}
    Table Cell Should Contain    ${Path_Siebel_SiteMap_Audit_Trail_Items_Table}    ${row}    6    ${Field_Old_Value}
    Table Cell Should Contain    ${Path_Siebel_SiteMap_Audit_Trail_Items_Table}    ${row}    7    ${Field_New_Value}

Siebel Upload Document
    Click Link    ${Path_Siebel_Attachments_Tab}
    Click Button    ${Path_Siebel_Attachments_Doc_Upload_Btn}
    Wait Until Element Is Visible    ${Path_Siebel_Attachments_Doc_Upload_Select_File_Contain}    2 min
    Select From List By Label    ${Path_Siebel_Attachments_Doc_Upload_Select_File_Contain}    input file
    Select From List By Label    ${Path_Siebel_Attachments_Doc_Upload_Select_File_Type}    input type
    Input Text    ${Path_Siebel_Attachments_Doc_Upload_Select_Doc_Recv_Date}    input date
    Click Element    ${Path_Siebel_Attachments_Doc_Upload_ChooseFile_Btn}
    ##include file selection from desktop here
    Click Element    ${Path_Siebel_Attachments_Doc_Upload_Save_Btn}
    Wait Until Element Is Visible    ${Path_Siebel_Attachments_Doc_Upload_Success_Msg}    2 min
    Click Button    ${Path_Siebel_Attachments_Doc_Upload_Finish_Btn}
    Wait Until Element Is Visible    ${Path_Siebel_Attachments_Doc_Table}    2 min
    Page Should Contain Button    ${Path_Siebel_Attachments_Doc_Table_Annotate_Btn}
    Click Button    ${Path_Siebel_Attachments_Doc_Table_Annotate_Btn}

Open All Cases
    Click link    Cases
    Wait Until Page Contains    All Cases
    Click link    All Cases
    Wait Until Page Contains    Batch Assign

Query For Active Case
    Click Button    //button[@title='Cases:Query']
    Wait Until Page Contains    Query Assistant    1 min
    Click Element    //td[@id='1_s_1_l_Status']
    #Wait Until Page Contains    <Case
    Input Text    //input[@id='1_Status']    Active
    Click Button    //button[@title='Cases:Go']
    Wait Until Page Contains    Medicaid    1 min
    Click Element    //div[@title='Cases List Applet']//span[@title='Next record set']
    ${time}    Random Int    1    9
    #Repeat Keyword    ${time}    Next Set Records
    #Wait Until Element Is Visible    //a[@role = 'textbox' and @class='drilldown' and @name='Name'][0]
    ${row}=    Evaluate    ${time}+2
    #Run Keyword If    ${row} > 11    Click Element    //div[@title='Cases List Applet']//span[@title='Next record set']
    ${Case_Name}=    Get Table Cell    //table[@id='s_1_l']    ${row}    4
    ${xpath_location}=    Catenate    SEPARATOR='    //a[text()=    ${Case_Name}
    ${xpath_location}=    Catenate    SEPARATOR='    ${xpath_location}    ]
    Click Link    ${xpath_location}
    Wait Until Page Contains    Process Change    1 min

Query For Active LTC Approved Case
    KOLEA_Key_Words.Click On Button    //button[@title='Cases:Query']
    Wait Until Page Contains    Query Assistant
    Click Element    //td[@id='1_s_1_l_Status']
    #Wait Until Page Contains    <Case
    Input Text    //input[@id='1_Status']    Active
    Click Element    ${Path_Siebel_LTC_Query_Select_LTCApproved_Field}
    Select Checkbox    ${Path_Siebel_LTC_Query_Select_LTCApproved_Chkbx}
    KOLEA_Key_Words.Click On Button    //button[@title='Cases:Go']
    Wait Until Page Contains    Medicaid
    ${time}    Random Digit
    #Repeat Keyword    ${time}    Next Set Records
    #Wait Until Element Is Visible    //a[@role = 'textbox' and @class='drilldown' and @name='Name'][0]
    ${row}=    Evaluate    ${time}+2
    ${Case_Name}=    Get Table Cell    //table[@id='s_1_l']    ${row}    4
    ${xpath_location}=    Catenate    SEPARATOR='    //a[text()=    ${Case_Name}
    ${xpath_location}=    Catenate    SEPARATOR='    ${xpath_location}    ]
    Click Link    ${xpath_location}
    Wait Until Page Contains    Process Change

Open an Active Case
    Open All Cases
    Query For Active Case
    # aa
    # root = lxml.html.fromstring(driver.page_source)
    # for row in root.xpath('.//table[@id="thetable"]//tr'):
    # cells = row.xpath('.//td/text()')
    # dict_value = {'0th': cells[0],
    # '1st': cells[1],
    # '2nd': cells[2],
    # '3rd': cells[3],
    # '6th': cells[6],
    # '7th': cells[7],
    # '10th': cells[10]}

Verify Login Error
    [Arguments]    ${uname}    ${pwd}
    ${msg}=    Run Keyword And Ignore Error    Get Text    //div[@id='errorMessage']
    ${error}    Set Variable    Element with locator '//div[@id='errorMessage']' not found.
    Run Keyword If    '''@{msg}[1]''' == '''${error}'''    log    User Login Successful
    ...    ELSE    Run Keywords    Input Text    ${Path_Siebel_Signin_Username}    ${uname}
    ...    AND    Click Element    ${Path_Siebel_Signin_Continue_Btn}
    ...    AND    Input Text    ${Path_Siebel_Signin_Pwd}    ${pwd}
    ...    AND    Press Keys    ${Path_Siebel_Signin_Pwd}    ENTER    #Click Element    ${Path_Siebel_Signin_Pwd_Enterkey}

Retro verbiage Date Input
    Set Browser Implicit Wait    2 min
    # Click On Button    ${Path_PP_Create_New_Appl}
    Wait Until Element Is Visible    ${Path_LFRY_PCI_First_Name}    1 min
    Input Text From Profile    ${Path_LFRY_PCI_First_Name}    \\Persons\\P1\\First_Name
    Input Text From Profile    ${Path_LFRY_PCI_Middle_Name}    \\Persons\\P1\\Middle_Name
    Input Text From Profile    ${Path_LFRY_PCI_Last_Name}    \\Persons\\P1\\Last_Name
    Select List Item From Profile    ${Path_LFRY_PCI_Suffix}    \\Persons\\P1\\Suffix
    Input Text From Profile    ${Path_LFRY_PCI_Home_Address_Address_Line1}    \\Persons\\P1\\Home_Address\\Address_Line1
    Input Text From Profile    ${Path_LFRY_PCI_Home_Address_Apartment_Or_Suite_Number}    \\Persons\\P1\\Home_Address\\Apartment#
    Input Text From Profile    ${Path_LFRY_PCI_Home_Address_City}    \\Persons\\P1\\Home_Address\\City
    Select List Item From Profile    ${Path_LFRY_PCI_Home_Address_State}    \\Persons\\P1\\Home_Address\\State
    Input Text From Profile    ${Path_LFRY_PCI_Home_Address_Zip_Code}    \\Persons\\P1\\Home_Address\\Zip_Code
    Select List Item From Profile    ${Path_LFRY_PCI_Home_Address_County}    \\Persons\\P1\\Home_Address\\County
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Address_Line1}    \\Persons\\P1\\Mailing_Address\\Address_Line1
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Apartment_Or_Suite_Number}    \\Persons\\P1\\Mailing_Address\\Apt_Num
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_City}    \\Persons\\P1\\Mailing_Address\\City
    Select List Item From Profile    ${Path_LFRY_PCI_Mailing_Address_State}    \\Persons\\P1\\Mailing_Address\\State
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Zip_Code}    \\Persons\\P1\\Mailing_Address\\Zip
    Select List Item From Profile    ${Path_LFRY_PCI_Mailing_Address_County}    \\Persons\\P1\\Mailing_Address\\County
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Phone_Number}    \\Persons\\P1\\Phone_Number
    Input Text From Profile    ${Path_LFRY_PCI_Mailing_Address_Other_Phone_Number}    \\Persons\\P1\\other_phone_number
    Select Radio Button From Profile    ${Path_LFRY_PCI_Do_You_Want_To_Get_Informtn_Abt_This_Appl_By_Email}    \\Persons\\P1\\Appl_By_Email
    Input Text From Profile    ${Path_LFRY_PCI_Do_You_Wnt_To_Get_Info_Abt_Ths_Appl_By_Email_Yes_Email_Addr}    \\Persons\\P1\\Email
    Select List Item From Profile    ${Path_LFRY_PCI_Preferred_Spoken_Language}    \\Persons\\P1\\Spoken_Lang
    Select List Item From Profile    ${Path_LFRY_PCI_Preferred_Written_Language}    \\Persons\\P1\\Written_Lang
    Input Text From Profile    ${Path_LFRY_PCI_How_Many_Family_Members_Live_With_You}    \\Persons\\P1\\Family_Mbrs
    Select List Item From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarcertd_Or_Residng_Hawaii_Ste_Hosptl}    \\Persons\\P1\\Incarcerated
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Fname}    \\Persons\\P1\\Inc_Fname
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Mname}    \\Persons\\P1\\Inc_Mname
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Lname}    \\Persons\\P1\\Inc_Lname
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_Sdate}    \\Persons\\P1\\Start_Date
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Live_Wth_Incarctd_Or_Resdng_Hwai_Ste_Hsp_Y_RLdate}    \\Persons\\P1\\Release_Date
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Fname}    \\Persons\\P1\\Any_incarcerated\\AFM_First_Name
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Mname}    \\Persons\\P1\\Any_incarcerated\\AFM_Middle_Name
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Lname}    \\Persons\\P1\\Any_incarcerated\\AFM_Last_Name
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Sdate}    \\Persons\\P1\\Any_incarcerated\\AFM_Start_Date
    Input Text From Profile    ${Path_LFRY_PCI_Any_Fmly_Mbr_Liv_Wth_Incarctd_Resdng_Hwai_Ste_Hsp_Y_AFM_Rdate}    \\Persons\\P1\\Any_incarcerated\\AFM_Start_Date
    Click On Button    ${Path_LFRY_PCI_Next_button}
    Click On Button    ${Path_LFRY_SA_Next_button}
    Select List Item From Profile    ${Path_LFRY_PAD_Suffix_P1}    \\Persons\\P1\\Suffix
    sleep    8
    #######Have issue with invalid date format entry in the appl, hence handling with FOR loop till enters valid date format
    # Input Text From Profile    ${Path_LFRY_PAD_DOB_P1}    \\Persons\\P1\\DOB
    # Enter Valid Date Format    ${Path_LFRY_PAD_DOB_P1}    \\Persons\\P1\\DOB
    Valid Date Entry    ${Path_LFRY_PAD_DOB_P1}    \\Persons\\P1\\DOB
    # Click Element    ${Path_LFRY_PAD_DOB_P1}
    # sleep    5
    # Click Link    ${Path_LFRY_PAD_Date_Of_Birth_P2_Select_Cal}
    Select List Item From Profile    ${Path_LFRY_PAD_Gender_P1}    \\Persons\\P1\\Gender
    Select List Item From Profile    ${Path_LFRY_PAD_Gender_P1_Female_Pregnant}    \\Persons\\P1\\Pregnancy\\Pregnant
    Select List Item From Profile    ${Path_LFRY_PAD_Gender_P1_Female_Pregnant_Babies_Exptd}    \\Persons\\P1\\Pregnancy\\Babies_Expected
    sleep    3
    Valid Date Entry    ${Path_LFRY_PAD_Gender_P1_Female_Pregnant_Babies_Exptd_Dt}    \\Persons\\P1\\Pregnancy\\Expected_Due_Dt
    Input Text From Profile    ${Path_LFRY_PAD_SpouseName_If_Married_P1}    \\Persons\\P1\\Name_of_Spouse
    Input Text From Profile    ${Path_LFRY_PAD_SSN_P1}    \\Persons\\P1\\SSN
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Plan_To_File_Federal_Inctx_Rtn_NEXT_Year}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe
    Input Text From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse_Yes_Fname}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse_Yes_Mname}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Jointly_File_With_Spouse_Yes_Lname}    \\Persons\\P1\\Tax_Info\\Plan_To_File_Tax_Nxt_Yr\\Jnt_Spe\\Lname
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtrn}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Yes_Fname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Yes_Mname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Yes_Lname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Add_Dependnt_Fname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Add_Dependnt_Mname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claim_Any_Dependt_On_Your_Tx_Rtn_Add_Dependnt_Lname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Add_Dpnd\\Lname
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn_Yes_Fname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Fname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn_Yes_Mname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Mname
    Input Text From Profile    ${Path_LFRY_PAD_P1_Claimed_As_Dependt_On_someones_Tx_Rtn_Yes_Lname}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Lname
    Select Checkbox From Profile    ${Path_LFRY_PAD_P1_Chk_If_Tx_Filer_Claimng_You_As_Dependt_Is_Nt_Prt_Of_Hsehold}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Nt_Prt_Of_Hsehold
    Select List Item From Profile    ${Path_LFRY_PAD_P1_How_Are_You_Related_To_Tx_Filer}    \\Persons\\P1\\Tax_Info\\Dependent_On_Tax_Return\\Tax_Filer
    # Wait Until Element Is Visible    ${Path_LFRY_PAD_P1_Do_You_Need_Health_Coverage}    1 min
    Select Radio Button From Profile    ${Path_LFRY_PAD_P1_Do_You_Need_Health_Coverage}    \\Persons\\P1\\Need_Hlth_Cvrge
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Have_Disability_Tht_Will_last_More_Than_Twelve_Mnths}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Do_You_Currently_Receive_Long_Trm_Care_Nursing_servces}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\Nursing_servces
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Have_You_Recvd__Lng_Trm_Cre_Nursng_srvcs_In_Lst_Three_Mnths}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\Lst_Three_Mnths
    Input Text From Profile    ${Path_LFRY_PAD_P1_Recvd__Lng_Trm_Cre_Nursng_srvcs_In_Lst_Three_Mnths_Yes_From}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\From_Dt
    Input Text From Profile    ${Path_LFRY_PAD_P1_Recvd__Lng_Trm_Cre_Nursng_srvcs_In_Lst_Three_Mnths_Yes_To}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\To_Dt
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Do_You_Think_You_Need_Lng_Trm_Cre_Nursng_srvcs_Now }    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\Nursng_srvcs_Now
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Do_You_Recve_Supplemental_Security_Income_SSI}    \\Persons\\P1\\Health_Coverage\\Disability_Lasts_12_Months\\SSI
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_imdt_Prior_date_Of_Appl}    \\Persons\\P1\\Health_Coverage\\Recve_Med_Servc
    sleep    3    #without sleep, entering invalid date
    # Input Text From Profile    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ten_Cal_Days_Prior_date_Of_App_Y_Frm}    \\Persons\\P1\\Health_Coverage\\From_Dt
    # ${key}    ${From_Date}=    Get value    \\Persons\\P1\\Health_Coverage\\From_Dt
    # log    ${From_Date}
    Valid Date Entry    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_Prior_date_Of_App_Y_Frm}    \\Persons\\P1\\Health_Coverage\\From_Dt
    # Enter Valid Date Format    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ten_Cal_Days_Prior_date_Of_App_Y_Frm}    \\Persons\\P1\\Health_Coverage\\From_Dt
    sleep    3
    # Input Text From Profile    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ten_Cal_Days_Prior_date_Of_App_Y_To}    \\Persons\\P1\\Health_Coverage\\To_Dt
    # ${key}    ${To_Date}=    Get value    \\Persons\\P1\\Health_Coverage\\To_Dt
    Valid Date Entry    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ninety_Cal_Days_Prior_date_Of_App_Y_To}    \\Persons\\P1\\Health_Coverage\\To_Dt
    # Enter Valid Date Format    ${Path_LFRY_PAD_P1_Recvd_Medcl_Srvcs_Past_Ten_Cal_Days_Prior_date_Of_App_Y_To}    \\Persons\\P1\\Health_Coverage\\To_Dt
    Select List Item From Profile    ${Path_LFRY_PAD_P1_Are_You_US_Citizen_Or_US_National}    \\Persons\\P1\\Health_Coverage\\US_Citizen

Access COC Tab Options
    [Arguments]    ${xpath}
    Click Link    ${Path_Siebel_COC_Tab}
    Wait Until Element Is Visible    ${Path_Siebel_COC_ChangeAddr_Btn}    2 min
    Wait Until Keyword Succeeds    1 min    5 sec    Scroll Element Into View    ${Path_Siebel_COC_Contacts_Table_Next_Rec}
    Wait Until Keyword Succeeds    1 min    5 sec    Mouse Over    ${Path_Siebel_COC_Tab}
    Click Link    ${xpath}
    Wait Until Element Is Visible    ${Path_Siebel_Process_Change_Btn}    1 min

COC Add Spenddown
    Scroll Element Into View    ${Path_Siebel_COC_Spenddown_Recurring_Exp_New_Btn}
    sleep    3
    Click Button    ${Path_Siebel_COC_Spenddown_Recurring_Exp_New_Btn}
    sleep    3
    Input Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Type_Field_Input}    Medical
    Press Keys    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Type_Field_Input}    ENTER
    Press Keys    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Type_Field_Input}    TAB
    sleep    3
    Press Keys    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Bill_Amount_Input}    DELETE
    # Clear Element Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Bill_Amount_Input}
    sleep    2
    Input Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Bill_Amount_Input}    2950
    Click Element    ${Path_Siebel_COC_Spenddown_Recurring_Exp_StartDate_Field}
    ${start_dt}=    Get Random Any Past Date
    ${end_dt}=    Get Random Any Future Date
    Input Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_StartDate_Input}    ${start_dt}
    Press Keys    ${Path_Siebel_COC_Spenddown_Recurring_Exp_StartDate_Input}    TAB
    Input Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_EndDate_Input}    ${end_dt}

COC Add Spenddown For HH
    ${rows}=    Get Element Count    ${Path_Siebel_Contacts_Table_Rows_Count}
    log    ${rows}
    Run Keyword If    ${rows}>1    Click Element    ${Path_Siebel_Contacts_Table_Row_HH}
    Run Keyword If    ${rows}>1    COC Add Spenddown
    ...    ELSE    log    No household present

Window Handles
    [Arguments]    ${Browser_Name}
    @{aliases}    Get Browser Aliases
    ${Browser_Present}=    Run Keyword And Return Status    Dictionary should contain key    ${aliases}    ${Browser_Name}
    Run Keyword If    '${Browser_Present}' != 'True'    Login to specific Browser    ${Browser_Name}
    ...    ELSE    Run Keyword And Return If    '${Browser_Present}' == 'True'    Switch Browser    ${Browser_Name}

Login to specific Browser
    [Arguments]    ${Browser_Name}
    Run Keyword If    '${Browser_Name}' == 'WP_SIT01C'    Login to Worker Portal    ${Env_WP}    ${uname}    ${pwd}    ${Sec_Ans}
    ...    ELSE IF    '${Browser_Name}' == 'CP_SIT01C'    Access LFRY_Portal_SIT01    ${Env_CP}
    ...    ELSE IF    '${Browser_Name}' == 'SSD_SIT01C'    Login to SSD Portal    ${Env_SSD}    ${uname}    ${pwd}
    ...    ELSE IF    '${Browser_Name}' == 'IDM_SIT01C'    Login to IDM Portal
    ...    ELSE IF    '${Browser_Name}' == 'Portal_Nav_SIT01C'    Portal User Login    ${Nav_uname}    ${Nav_pwd}

Login to IDM Portal
    Log    Login to IDM portal

Clear Chrome Cache
    Run Process    PowerShell.exe    C:\Scripts\Clear_Chrome_Cache.ps1

Navigate to Kolea Home Page
    Click Link    xpath=//a[text()='Home']
    Wait Until Element Is Visible    ${Path_LifeRay_Pre_Assess_Button}    2 min




Create User Account With BackPage Verification
    # Access LFRY_Portal_SIT01
    ####User create account#######
    Click On Button    ${Path_PP_CA_Apply_Now}
    Wait Until Element Is Visible    ${Path_PP_CA_Create_Account_First_Name}    1 min
    Input Text From Profile    ${Path_PP_CA_Create_Account_First_Name}    \\Create Account\\First_Name
    Input Text From Profile    ${Path_PP_CA_Create_Account_Last_Name}    \\Create Account\\Last_Name
    Input Text From Profile    ${Path_PP_CA_Create_Account_Email}    \\Create Account\\Email
    Input Text From Profile    ${Path_PP_CA_Create_Account_Re_Enter_Email}    \\Create Account\\ReEnter_Email
    ${Keypresent}    ${uname}=    Get value    \\Create Account\\User_Name
    ${time}=    Get time    Seconds
    ${User_name}=    Catenate    ${uname}${time}
    Input Text    ${Path_PP_CA_Create_Account_User_Name}    ${User_name}
    ${uname}=    Get Element Attribute    ${Path_PP_CA_Create_Account_User_Name}    attribute=value
    log    ${uname}
    # Write To Excel    portal users    2    1    ${User_name}
    Input Text From Profile    ${Path_PP_CA_Create_Password}    \\Create Account\\Password
    ${pwd}=    Get Element Attribute    ${Path_PP_CA_Create_Password}    attribute=value
    log    ${pwd}
    # Write To Excel    portal users    2    2    ${pwd}
    Input Text From Profile    ${Path_PP_CA_Create_Re_Enter_Password}    \\Create Account\\ReEnter_Pswd
    sleep    5
    Select From List By index    ${Path_PP_CA_Create_Security_Question_1}    1
    sleep    3
    Input Text From Profile    ${Path_PP_CA_Create_Answer_1}    \\Create Account\\Answer1
    Select From List By index    ${Path_PP_CA_Create_Security_Question_2}    1
    Input Text From Profile    ${Path_PP_CA_Create_Answer_2}    \\Create Account\\Answer2
    Select From List By index    ${Path_PP_CA_Create_Security_Question_3}    1
    Input Text From Profile    ${Path_PP_CA_Create_Answer_3}    \\Create Account\\Answer3
    Select Radio Button From Profile    ${Path_PP_CA_If_Approved_By_State_Of_Hawaii}    \\Create Account\\Counselor
    Click On Button    ${Path_PP_CA_Create_Account}
    Wait Until Element Is Visible    ${Path_PP_Login}    1 min
    Capture Page Screenshot    User_Creation.png
	#Go Back
	
    # log    ${Temp_uname}    ${Temp_Pwd}
    ########LOgin#########
    #Click Button    ${Path_PP_Login}
    #Input Text    ${Path_PP_Login_Userid}    ${uname}
    #Click Button    ${Path_PP_Login_Continue_Btn}
    #Input Text    ${Path_PP_Login_Pwd}    ${pwd}
    ## Click Element    ${Path_PP_Login_Pwd_Enterkey}
    #Press Keys    ${Path_PP_Login_Pwd}    ENTER
    #${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Path_Siebel_Login_Error_Msg}    10 sec
    #Run Keyword If    '${status}' == 'False'    Wait Until Keyword Succeeds    2 min    5 sec    Click Element    ${Path_PP_Create_New_Appl}
    #...    ELSE    Run Keywords    Capture Page Screenshot    Login_Page.png
    #...    AND    Close Browser
    #...    AND    FAIL    Client Portal Login Failure
    # [Return]    ${uname}    ${pwd}
	

Validate Confirmation Number On Client Portal
	[Arguments]    ${Appl_Cnf_Nbr}
	${ConfirmationNumber}=    Get Text    //td[@id='appIntakeEntityModelsSearchContainer_col-hawaii.myhealthplans.applicationid_row-1']
    ${status}=    Run Keyword And Return Status    Should Be Equal    ${Appl_Cnf_Nbr}    ${ConfirmationNumber}
    Run Keyword If    '${status}' == 'True'    Log    Confirmation Number is a Match.
    ...    ELSE    FAIL    Confirmation number is not Matched.
	
	
Create User Account Without Login
    # Access LFRY_Portal_SIT01
    ####User create account#######
    Click On Button    ${Path_PP_CA_Apply_Now}
    Wait Until Element Is Visible    ${Path_PP_CA_Create_Account_First_Name}    1 min
    Input Text From Profile    ${Path_PP_CA_Create_Account_First_Name}    \\Create Account\\First_Name
    Input Text From Profile    ${Path_PP_CA_Create_Account_Last_Name}    \\Create Account\\Last_Name
    Input Text From Profile    ${Path_PP_CA_Create_Account_Email}    \\Create Account\\Email
    Input Text From Profile    ${Path_PP_CA_Create_Account_Re_Enter_Email}    \\Create Account\\ReEnter_Email
    ${Keypresent}    ${uname}=    Get value    \\Create Account\\User_Name
    ${time}=    Get time    Seconds
    ${User_name}=    Catenate    ${uname}${time}
    Input Text    ${Path_PP_CA_Create_Account_User_Name}    ${User_name}
    ${uname}=    Get Element Attribute    ${Path_PP_CA_Create_Account_User_Name}    attribute=value
    log    ${uname}
    # Write To Excel    portal users    2    1    ${User_name}
    Input Text From Profile    ${Path_PP_CA_Create_Password}    \\Create Account\\Password
    ${pwd}=    Get Element Attribute    ${Path_PP_CA_Create_Password}    attribute=value
    log    ${pwd}
    # Write To Excel    portal users    2    2    ${pwd}
    Input Text From Profile    ${Path_PP_CA_Create_Re_Enter_Password}    \\Create Account\\ReEnter_Pswd
    sleep    5
    Select From List By index    ${Path_PP_CA_Create_Security_Question_1}    1
    sleep    3
    Input Text From Profile    ${Path_PP_CA_Create_Answer_1}    \\Create Account\\Answer1
    Select From List By index    ${Path_PP_CA_Create_Security_Question_2}    1
    Input Text From Profile    ${Path_PP_CA_Create_Answer_2}    \\Create Account\\Answer2
    Select From List By index    ${Path_PP_CA_Create_Security_Question_3}    1
    Input Text From Profile    ${Path_PP_CA_Create_Answer_3}    \\Create Account\\Answer3
    Select Radio Button From Profile    ${Path_PP_CA_If_Approved_By_State_Of_Hawaii}    \\Create Account\\Counselor
    Click On Button    ${Path_PP_CA_Create_Account}
    Wait Until Element Is Visible    ${Path_PP_Login}    1 min
    Capture Page Screenshot    User_Creation.png
	[Return]    ${uname}    ${pwd}	
	
	
Portal Signin
    [Arguments]    ${uname}    ${pwd}
    Wait Until Keyword Succeeds    1 min    5 sec    Click Button    ${Portal_Signin_Button}
    Input Text    ${Path_PP_Login_Userid}    ${uname}
    Click Button    ${Path_PP_Login_Continue_Btn}
    Input Text    ${Path_PP_Login_Pwd}    ${pwd}
    Press Keys    ${Path_PP_Login_Pwd}    ENTER
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Path_Siebel_Login_Error_Msg}    10 sec
    Run Keyword If    '${status}' == 'False'    Wait Until Keyword Succeeds    2 min    5 sec    Wait Until Element Is Visible    ${Path_PP_Create_New_Appl}
    ...    ELSE    Run Keywords    Capture Page Screenshot    Login_Page.png
    ...    AND    Close Browser
    ...    AND    FAIL    Client Portal Login Failure
	
	
Login to Worker Portal with Passed Arguments
    [Arguments]    ${Env}    ${uname}    ${pwd}    ${Sec_Ans}
    &{account}    Get Web Details    ${WebCredentials}    ${SiebelEnv}
    Open Browser    &{account}[URL]    ${BROWSER_chrome}    options=add_argument("--ignore-certificate-errors")    alias=WP_SIT01C
    #Open Browser    ${Env}    ${BROWSER_chrome}    options=add_argument("--ignore-certificate-errors")    alias=WP_SIT01C
    Maximize Browser Window
    Input Text    ${Path_Siebel_Signin_Username}    ${uname}
    #Input Text    ${Path_Siebel_Signin_Username}    &{account}[UserName]
    Click Button    ${Path_Siebel_Signin_Continue_Btn}
    Input Text    ${Path_Siebel_Signin_Pwd}    ${pwd}
    #Input Text    ${Path_Siebel_Signin_Pwd}    &{account}[Password]
    # Click Element    ${Path_Siebel_Signin_Pwd_Enterkey}
    Press Keys    ${Path_Siebel_Signin_Pwd}    ENTER
    ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Path_Siebel_Login_Error_Msg}    10 sec
    Run Keyword If    '${status}' == 'False'    Wait Until Element Is Visible    ${Path_Siebel_Salutation_MyHome}    2 min
    ...    ELSE    Run Keywords    Capture Page Screenshot    Login_Page.png
    ...    AND    Close Browser
    ...    AND    FAIL    Worker Portal Login Failure
    #Wait Until Element Is Visible    ${Path_Siebel_Salutation_MyHome}    2 min
	

Kol Add Resource in COC Spendown
    [Arguments]    ${start_dt}    ${ExpenseType}=Medical    ${ExpenseAmount}=2950
    Access COC Tab Options    ${Path_Siebel_COC_Spenddown}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_COC_Spenddown_Recurring_Exp_New_Btn}    5s
    Scroll Element Into View    ${Path_Siebel_COC_Spenddown_Recurring_Exp_New_Btn}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Spenddown_Recurring_Exp_New_Btn}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Type_Field_Input}    ${ExpenseType}
    Press Keys    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Type_Field_Input}    ENTER
    #Press Keys    None    TAB
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Bill_Amount_Field}
    Double Click Element    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Bill_Amount_Input}
	Press Keys	None	BACKSPACE+BACKSPACE+BACKSPACE+BACKSPACE+BACKSPACE
    Press Keys    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Bill_Amount_Input}    DELETE
    Sleep    2s
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_Bill_Amount_Input}    ${ExpenseAmount}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Spenddown_Recurring_Exp_StartDate_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Spenddown_Recurring_Exp_StartDate_Input}    ${start_dt}

Kol Change Emergency Status in Medical Services
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_MedicalService_Validation}    5s
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_MedicalService_EmergencyService_Status}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_MedicalService_EmergencyService_Status_Input}    Approved
    Press Keys    None    ENTER


Kol Add COC Blind Disablity
    [Arguments]    ${StartDate}	${Rowid}=1    ${Disablity}=Blind
	Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${Rowid}]${Path_Siebel_COC_MedicalCondition_ClientID}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Medical_Condition_New_Btn}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Medical_Condition_Medical_Type_Field_Input}    ${Disablity}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Medical_Condition_ReportedDateFld_AncestorPath}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Medical_Condition_ReportedDate_Input}    ${StartDate}
    Press Keys    None    ENTER

Kol Add COC Public Insitution to Incarcerated Person
    [Arguments]    ${PublicInstitute_StartDate}    ${Incarceration_StartDate}    ${PublicInstituion}=Prisoner inpatient hosp stay
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Update_Btn}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_New_Btn}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Category_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_Category_Input}    ${PublicInstituion}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_StartDate_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_StartDate_Field_Input}    ${PublicInstitute_StartDate}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_StartDate_SecondField}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_StartDate_SecondField_Input}    ${Incarceration_StartDate}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Next_Btn}
    Wait Until Keyword Succeeds    1min    5s    Page Should Not Contain    ${Path_Siebel_COC_Public_Institution_Next_Btn}
			
	
Kol Add COC Public Insitution to Incarcerated Person in Multiple HH
	#the @id=2 is static and wrong due to issue in UI. Need to be corrected.
    [Arguments]    ${PublicInstitute_StartDate}    ${Incarceration_StartDate}    ${PublicInstituion}=Prisoner inpatient hosp stay	${Rowid}=1
	Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${Rowid}]${Path_Siebel_COC_MedicalCondition_ClientID}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Update_Btn}
	Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${Rowid}]//td[contains(@id,'First_Name')]
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_New_Btn}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Category_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_Category_Input}    ${PublicInstituion}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_StartDate_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_StartDate_Field_Input}    ${PublicInstitute_StartDate}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_StartDate_SecondField}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_StartDate_SecondField_Input}    ${Incarceration_StartDate}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Next_Btn}
    Wait Until Keyword Succeeds    1min    5s    Page Should Not Contain    ${Path_Siebel_COC_Public_Institution_Next_Btn}
	Wait Until Keyword Succeeds    1min    5s    Click Element    //button[@title='Next']


Kol TakeScreenshot
    [Arguments]    ${Scenario}=Kolea    ${PageID}=Kolea
    ${time}=    Get time    epoch
    ${ScreenshotName}=    Catenate    Screenshot_${Scenario}_${PageID}_${time}
    Capture Page Screenshot    ${ScreenshotName}.png

Kol Access Application Data
    [Arguments]    ${xpath}
    Click Link    ${Path_Siebel_Application_Data}
    Wait Until Element Is Visible    ${Path_Siebel_Application_Data_Household_Information}    2 min
    Wait Until Keyword Succeeds    1 min    5 sec    Scroll Element Into View    ${Path_Siebel_Application_Data_Household_Composition}
    Wait Until Keyword Succeeds    1 min    5 sec    Mouse Over    ${Path_Siebel_Application_Data}
    Click Link    ${xpath}
    Wait Until Element Is Visible    ${Path_Siebel_Process_Change_Btn}    1 min

Kol Add Other Health Coverage
    [Arguments]    ${StartDate}    ${Rowid}=1    ${HealthCoverageSource}=TRICARE
    #This function will create Other Health coverage record for HH selected based on ROWID with default Carrier Name
    #HMSA (MEDICAL ONLY). Carrier Name can be parametrized in future if availaible.
    Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${Rowid}]${Path_Siebel_Application_Data_OtherHealthCoverage_ClientID}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Application_Data_OtherHealthCoverage_New_Btn}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_Application_Data_OtherHealthCoverage_Source_Input}    ${HealthCoverageSource}
    Press Keys    None    TAB
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Application_Data_OtherHealthCoverage_CarrierName}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Application_Data_OtherHealthCoverage_CarrierName_Input}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_Application_Data_OtherHealthCoverage_CarrierName_Applet}    5s
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Application_Data_OtherHealthCoverage_CarName_Applet_Ok}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Application_Data_OtherHealthCoverage_StrDate}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_Application_Data_OtherHealthCoverage_StrDate_Input}    ${StartDate}
	
	
	
Kol Add Resources under COC
    [Arguments]    ${Rowid}=1    ${Type}=Cash    ${Amount}=250
    Access COC Tab Options    ${Path_Siebel_COC_Resources}
    Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${Rowid}]${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_ClientID }
    Wait Until Keyword Succeeds    1min    5s    Click Element    //span[contains(text(),'Change Resources')]
    Wait Until Keyword Succeeds    1min    5s    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    Wait Until Keyword Succeeds    1min    5s    Click Element    //td[contains(@id,'Resource_Type')]
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    ${Type}
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    ${Amount}
    Wait Until Keyword Succeeds    1min    5s    Click Button    //button[@title='Finish']
	
Kol Update Resources under COC
    [Arguments]    ${Rowid}=1    ${Type}=Cash    ${Amount}=250
    Access COC Tab Options    ${Path_Siebel_COC_Resources}
    Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${Rowid}]${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_ClientID }
    Wait Until Keyword Succeeds    1min    5s    Click Element    //span[contains(text(),'Change Resources')]
    #Wait Until Keyword Succeeds    1min    5s    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    Wait Until Keyword Succeeds    1min    5s    Click Element    //td[contains(@id,'Resource_Type')]
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    ${Type}
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    ${Amount}
    Wait Until Keyword Succeeds    1min    5s    Click Button    //button[@title='Finish']
	
Kol Add Resources under COC with BankDetails
    [Arguments]    ${Rowid}=1    ${Type}=Cash    ${Amount}=250
    Access COC Tab Options    ${Path_Siebel_COC_Resources}
    Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=${Rowid}]${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_ClientID }
    Wait Until Keyword Succeeds    1min    5s    Click Element    //span[contains(text(),'Change Resources')]
    Wait Until Keyword Succeeds    1min    5s    Click Button    ${Path_Siebel_MAGI_Excepted_Appl_Resources_New}
    Wait Until Keyword Succeeds    1min    5s    Click Element    //td[contains(@id,'Resource_Type')]
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    ${Type}
    Press Keys    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Type_Input}    TAB
    Clear Element Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}
    Input Text    ${Path_Siebel_MAGI_Excepted_Appl_Resource_Value_Amount_Input}    ${Amount}
	Wait Until Keyword Succeeds    1min    5 sec    Click Element    ${Path_Siebel_COC_Resource_SelectBankQueryButton}
    Wait Until Keyword Succeeds    1min    5 sec    Wait Until Element Is Visible    ${Path_Siebel_COC_Resource_SelectBank_GoButton}    5 sec
    Wait Until Keyword Succeeds    1min    5 sec    Click Element    ${Path_Siebel_COC_Resource_SelectBank_GoButton}
    Wait Until Keyword Succeeds    1min    5 sec    Click Element    ${Path_Siebel_COC_Resource_SelectBank_OkButton}
    Wait Until Keyword Succeeds    1min    5s    Click Button    ${Path_Siebel_COC_Resource_SelectBank_Finish}
	


Kol Add Income Under COC
	[Arguments]	${Amount}=1256	${Type}=Farming or Fishing
    #Access COC Tab Options    ${Path_Siebel_COC_Income}
    Wait Until Keyword Succeeds    1min    5sec    Click Element    //button[@title='Contacts:Update Income Record']
    Wait Until Keyword Succeeds    1min    5 sec    Click Element    //button[@title='Income:New']
    Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=1]//td[contains(@id,'Source')]
    Input Text    //input[@name='Source']    ${Type}
    Press Keys    //input[@name='Source']    TAB
    Press Keys    None    TAB
    Clear Element Text    //input[@name='Amount']
    Input Text    //input[@name='Amount']    ${Amount}
    Wait Until Keyword Succeeds    1min    5 sec    Click Element    //button[@title='Next']
	
Kol Create RunTimeStamp
    ${TimeStamp}=    Get Current Date    result_format=epoch    exclude_millis=yes
    Set Global Variable    ${TimeStamp}
    

Kol Refresh Case Details
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_CaseQuery_button}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_CaseQuery_button_Validation}    5s
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_CaseQuery_Go_button}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_CaseQuery_NextRecordButton}    5s

Kol Click Process Change
    Wait Until Keyword Succeeds    1min    5s    Click Button    ${Path_Siebel_Process_Change_Btn}
    ${message}=    Handle Alert    ACCEPT    2 min
    ${Batch_status}=    Get Element Attribute    ${Path_Siebel_Case_Batch_Status}    attribute=value
    Run Keyword If    '${Batch_status}' == 'Error'    FAIL    Case status is ERROR and Failing the test case

Kol Validate Benefit Plan
    [Arguments]    ${Plan}    ${Status}=Approved
    Wait Until Keyword Succeeds    50 sec    5 sec    Click Link    ${Path_Siebel_Benefit_Plans}
    Wait Until Keyword Succeeds    50 sec    5 sec    Scroll Element Into View    ${Path_Siebel_Benefit_Plans_Table}
    ${Profile_Benefit_Plan}=    Set Variable    ${Plan}
    #${Benefitstatus}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Status}
    ${BenefitStatus}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Status}
    ${status}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Profile_Benefit_Plan}
    Run Keyword If    '${status}' == 'True' and '${BenefitStatus}' == 'True'    Log    PASS - Benefit name matched.
    ...    ELSE    FAIL    Benefit name not matched.

Kol Validate Batch Status
    [Arguments]    ${Status}
    ${Batch_status}=    Get Element Attribute    ${Path_Siebel_Case_Batch_Status}    attribute=value
    Run Keyword If    '${Batch_status}' == '${Status}'    Log    COC Changes are reflected correctly in Siebel
    ...    ELSE    FAIL    COC Changes are not reflected in Siebel Workflow.
	
Kol Access Application Data Options
    [Arguments]    ${xpath}
    Click Link    ${Path_Siebel_Application_Data}
    Wait Until Element Is Visible    ${Path_Siebel_Application_Data_Household_Information}    2 min
    Wait Until Keyword Succeeds    1 min    5 sec    Scroll Element Into View    ${Path_Siebel_Application_Data_Household_Composition}
    Wait Until Keyword Succeeds    1 min    5 sec    Mouse Over    ${Path_Siebel_Application_Data}
    Click Link    ${xpath}
    Wait Until Element Is Visible    ${Path_Siebel_Process_Change_Btn}    1 min
	
Kol Select All Cases in Siebel
    Wait Until Keyword Succeeds    1min    5s    Click Link    ${Path_Siebel_Cases}
    Wait Until Element Is Visible    ${Path_Siebel_Confirmation_Nbr}    1 min
    Wait Until Keyword Succeeds    1min    5s    Click Link    ${Path_Siebel_All_Cases}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_BatchAssign_Btn}    5s

Kol Fetch Query Results Based on Case Status and Source
    [Arguments]    ${Status}    ${Source}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_CaseQuery_button}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_CaseQuery_button_Validation}    5s
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Seibel_Case_Source_Element}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Seibel_Case_Source_Input}    ${Source}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Seibel_Case_Status_Element}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Seibel_Case_Status_Input}    ${Status}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_CaseQuery_Go_button}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_CaseQuery_NextRecordButton}    5s

Kol Select FFM Transfer from Dropdown
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Attchmnts_Drpdwn}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Attchmnts_FFMTransfer}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_Transfer_Query_Button}    5s

Kol Search Case by Case Number
	[Arguments]	${CaseNum}
	Click Case
    SearchCasebyCaseNumber    ${CaseNum}
    SelectCasebyCaseNumber

Kol Query Benefit Applet Section on SubStatus
	[Arguments]	${ClientId}	${SubStatus}=Suspended	${BenefitName}=${EMPTY}
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_BenefitApplet_QueryButton}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_BenefitApplet_Query_Go_Button}    5s
	Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_BenefitApplet_BenefitName_Input}    ${BenefitName}
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_BenefitApplet_ClientId}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_BenefitApplet_ClientId_Input}    ${ClientId}
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_BenefitApplet_SubStatus}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_BenefitApplet_SubStatus_Input}    ${SubStatus}
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_BenefitApplet_SubStatus}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_BenefitApplet_SubStatus_Input}    ${SubStatus}
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_BenefitApplet_Query_Go_Button}
	Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_BenefitApplet_NewButton}    5s
	
	
Kol Add Income Under COC With Specific Start Date
	[Arguments]	${FirstName}	${StartDate}	${Amount}=1256	${Type}=Farming or Fishing
    #Access COC Tab Options    ${Path_Siebel_COC_Income}
	Wait Until Keyword Succeeds    1min    5s	Scroll Element Into View    //td[contains(@id,'First_Name')][@title='${FirstName}']
	Wait Until Keyword Succeeds    1min    5s    Click Element    //td[contains(@id,'First_Name')][@title='${FirstName}']
    Wait Until Keyword Succeeds    1min    5sec    Click Element    //button[@title='Contacts:Update Income Record']
    Wait Until Keyword Succeeds    1min    5 sec    Click Element    //button[@title='Income:New']
    Wait Until Keyword Succeeds    1min    5s    Click Element    //tr[@id=1]//td[contains(@id,'Source')]
    Input Text    //input[@name='Source']    ${Type}
    Press Keys    //input[@name='Source']    TAB
    Press Keys    None    TAB
    Clear Element Text    //input[@name='Amount']
    Wait Until Keyword Succeeds    1min    5s	Input Text    //input[@name='Amount']    ${Amount}
	Wait Until Keyword Succeeds    1min    5s    Click Element    //td[contains(@id,'Start_Date')]
	Wait Until Keyword Succeeds    1min    5s	Input Text    //input[@name='Start_Date']    ${StartDate}	
    Wait Until Keyword Succeeds    1min    5 sec    Click Element    //button[@title='Next']
	
Kol Select Insurance Plan Applet in Siebel
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Attchmnts_Drpdwn}
	Scroll Element Into View    //span[@title='Next record set']
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Attchmnts_InsurancePlan}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_InsurancePlan_Items_Validation}    5s
	
Kol Fetch Insurance Plan RowID
    [Arguments]    ${ClientId}
    Wait Until Keyword Succeeds    1min    5s    Click Element    //td[@title='${ClientId}']
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Help_Menu}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_Help_Menu_AboutRecord_Link}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Help_Menu_AboutRecord_Link}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_Help_Menu_AboutRecord_Link_Validation}
    ${RowID}	Wait Until Keyword Succeeds    1min    5s    Get Element Attribute    ${Path_Siebel_Help_Menu_AboutRecord_RowId}    title
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_Help_Menu_AboutRecord_Ok}
	[Return]	${RowID}
	
Kol Execute Insert Or Update Operation
    [Arguments]    ${FileName}
    Connect To Database Using Custom Params    cx_Oracle    ${DB_CONNECT_STRING_Cloud}
    Log to Console    "Connection is success"
    Execute Sql Script    ${FileName}
    Disconnect From Database
	
Kol Add COC Public Insitution to Normal Person
    [Arguments]    ${PublicInstitute_StartDate}    ${PublicInstitute_EndDate}	${FirstName}    ${PublicInstituion}=The Hawaii State Hospital
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Update_Btn}
	Wait Until Keyword Succeeds    1min    5s	Scroll Element Into View    //td[contains(@aria-labelledby,'First_Name')][@title='${FirstName}']
	Wait Until Keyword Succeeds    1min    5s    Click Element    //td[contains(@aria-labelledby,'First_Name')][@title='${FirstName}']
	Sleep	3s
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_New_Btn}
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Category_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_Category_Input}    ${PublicInstituion}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_StartDate_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_StartDate_Field_Input}    ${PublicInstitute_StartDate}
    Press Keys    None    ENTER
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_EndDate_Field}
    Wait Until Keyword Succeeds    1min    5s    Input Text    ${Path_Siebel_COC_Public_Institution_EndDate_Field_Input}    ${PublicInstitute_EndDate}
    Press Keys    None    ENTER
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${Path_Siebel_COC_Public_Institution_Next_Btn}
    Wait Until Keyword Succeeds    1min    5s    Page Should Not Contain    ${Path_Siebel_COC_Public_Institution_Next_Btn}
	${rows}=    Get Element Count    ${Path_Siebel_Contacts_Table_Rows_Count}
	#Run Keyword If    ${rows}>1 and "${PublicInstituion}"=="Incarceration"	Wait Until Keyword Succeeds    1min    5s    Click Element    #//button[@title='Next']

Kol Refresh Applet
	[Arguments]	${QueryPath}	${GoButtonPath}
	Wait Until Keyword Succeeds    1min    5s    Click Element    ${QueryPath}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${GoButtonPath}    5s
    Wait Until Keyword Succeeds    1min    5s    Click Element    ${GoButtonPath}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${Path_Siebel_QueryGo_Validation}    5s
	
Kol Select Dropdowns Option Navigated Through Contacts
    [Arguments]    ${Selectiontab}    ${SelectionTab_Validation}
    Wait Until Keyword Succeeds    1min    5s    Select From List By Label    ${Path_Seibel_Dropdown_List}    ${Selectiontab}
    Wait Until Keyword Succeeds    1min    5s    Wait Until Element Is Visible    ${SelectionTab_Validation}    5s


Kol Fetch Case Details Under Contact Tab
    [Arguments]    ${ClientID}
    Click Contacts
    SearchCasebyClientID    ${ClientID}
    SelectCaseByLastName

	