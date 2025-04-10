*** Settings ***
Suite Setup       Kol Define Interface Suite Variable    #
Resource          ../Resources/Kalo_Interface_Keyword.robot    #

*** Variables ***
${WebCredentials}    C:\\RideWorkspace\\KOLEA_AUTOMATION\\WebCredentials.yaml
${SiebelEnv}      SiebelSIT01C
${FilesLocation}    \\InterfaceUpgrades\\TESTDATAFORFILECREATION
#${OutputLocation}    ${CURDIR}\\TESTDATAFORFILECREATION\\OUTPUT\\DPS\\DPSFile.txt
#${SQLFile}       ${CURDIR}\\TESTDATAFORFILECREATION\\Query\\Command.sql

*** Test Cases ***
sample
    #py bendex partb    ${DB_HostName}    ${DB_Port}    ${DB_Service}    ${DB_USER_NAME}    ${DB_PASSWORD}    ${SOA_SOAP_WSDL_Endpoint}
    #${CaseDictionary}=    Create Dictionary    LastName=Rogers    FirstName=Jonathan    SSN=462329254    ClientID=0001162131    StartDate=202103    DOB=19581005    MedicareNumber=462329254A1
    #Py Interface Inbound Mockupfile    ${CaseDictionary}    BUYINA    ${EMPTY}    ${FilesLocation}
    Py Buyin PartA Activebatch    ${DB_HostName}    ${DB_Port}    ${DB_Service}    ${DB_USER_NAME}    ${DB_PASSWORD}    ${ActiveBatch_Endpoint}    ${ActiveBatch_Port}    ${ActiveBatch_UserName}    ${ActiveBatch_Password}
    #kalo transfer inbound file to sftp    PUR.PARTB.TPTAB120M    BUYINB    ${EMPTY}

TC001_BUYIN_MANDATORLYDISABLED
    Window Handles    WP_SIT01C
    ${Profile}=    Mandatory Blind or Disabled
    log    ${Profile}
    Set Suite Variable    ${Profile}
    ${CaseNumber}=    kalo create mandatory disabled case
    ${Results}    ${CaseDictionary}    ${MedicareInsuranceNumber}=    kalo bendex scenario validation    ${CaseNumber}    MandatoryDisabled
    ${Filename_Med}=    kalo create inbound file    ${CaseDictionary}    BUYINB    ${EMPTY}
    kalo transfer inbound file to sftp    ${Filename_Med}    BUYINB    ${EMPTY}
    Log To Console    FileTransfered Sucessfully-Wait for 5-7 mins for poller to pick
    Sleep    300s
    kalo validate inbound file in staging table    ${Results}[5]    BUYINB    ${Results}[10]
    kalo trigger active batch for interface    BUYINB
    Log To Console    Wait for 5 second for Batch to make affect
    Sleep    5s
    Kol Select Dropdowns Option Navigated Through Contacts    Medicare Buy-In    ${Path_Seibel_MedicareBuy_Validation}
    ${HICN}    SeleniumLibrary.Get Value    //input[@aria-labelledby='KIESMedicareClaimNumber_Label']
    ${MedicarePartB_TransactionCode}    SeleniumLibrary.Get Value    //input[@aria-label='Reply Transaction Code Part B']
    Run Keyword And Continue On Failure    Should Be Equal    ${HICN}    ${MedicareInsuranceNumber}
    Run Keyword And Continue On Failure    Should Be Equal    ${MedicarePartB_TransactionCode}    41    Value should have been B
    [Teardown]    Unselect Frame

TC002_BUYIN_QMB
    Window Handles    WP_SIT01C
    ${Profile}=    Profile-052
    log    ${Profile}
    Set Suite Variable    ${Profile}
    ${CaseNumber}=    kalo create qmb case
    ${Results}    ${CaseDictionary}    ${MedicareInsuranceNumber}=    kalo bendex scenario validation    ${CaseNumber}    QMB
    ${Filename_MedB}=    kalo create inbound file    ${CaseDictionary}    BUYINB    ${EMPTY}
    ${Filename_MedA}=    kalo create inbound file    ${CaseDictionary}    BUYINA    ${EMPTY}
    kalo transfer inbound file to sftp    ${Filename_MedB}    BUYINB    ${EMPTY}
    kalo transfer inbound file to sftp    ${Filename_MedA}    BUYINA    ${EMPTY}
    Log To Console    FileTransfered Sucessfully-Wait for 5-7 mins for poller to pick
    Sleep    300s
    kalo validate inbound file in staging table    ${Results}[5]    BUYINB    ${Results}[10]
    kalo validate inbound file in staging table    ${Results}[5]    BUYINA    ${Results}[10]
    kalo trigger active batch for interface    BUYINB
    kalo trigger active batch for interface    BUYINA
    Log To Console    Wait for 5 second for Batch to make affect
    Sleep    5s
    Kol Select Dropdowns Option Navigated Through Contacts    Medicare Buy-In    ${Path_Seibel_MedicareBuy_Validation}
    ${HICN}    SeleniumLibrary.Get Value    //input[@aria-labelledby='KIESMedicareClaimNumber_Label']
    ${MedicarePartB_TransactionCode}    SeleniumLibrary.Get Value    //input[@aria-label='Reply Transaction Code Part B']
    ${MedicarePartA_TransactionCode}    SeleniumLibrary.Get Value    //input[@aria-label='Reply Transaction Code Part A']
    Run Keyword And Continue On Failure    Should Be Equal    ${HICN}    ${MedicareInsuranceNumber}
    Run Keyword And Continue On Failure    Should Be Equal    ${MedicarePartB_TransactionCode}    41    Value should have been 41
    Run Keyword And Continue On Failure    Should Be Equal    ${MedicarePartA_TransactionCode}    41    Value should have been 41
    [Teardown]    Unselect Frame

TC003_BUYIN_QDWI
    Window Handles    WP_SIT01C
    ${Profile}=    Profile-QDWI
    log    ${Profile}
    Set Suite Variable    ${Profile}
    ${CaseNumber}=    kalo create qdwi case
    ${Results}    ${CaseDictionary}    ${MedicareInsuranceNumber}=    kalo bendex scenario validation    ${CaseNumber}    QDWI
    ${Filename_Med}=    kalo create inbound file    ${CaseDictionary}    BUYINA    ${EMPTY}
    kalo transfer inbound file to sftp    ${Filename_Med}    BUYINA    ${EMPTY}
    Log To Console    FileTransfered Sucessfully-Wait for 5-7 mins for poller to pick
    Sleep    300s
    kalo validate inbound file in staging table    ${Results}[5]    BUYINA    ${Results}[10]
    kalo trigger active batch for interface    BUYINA
    Log To Console    Wait for 5 second for Batch to make affect
    Sleep    5s
    Kol Select Dropdowns Option Navigated Through Contacts    Medicare Buy-In    ${Path_Seibel_MedicareBuy_Validation}
    ${HICN}    SeleniumLibrary.Get Value    //input[@aria-labelledby='KIESMedicareClaimNumber_Label']
    ${MedicarePartA_TransactionCode}    SeleniumLibrary.Get Value    //input[@aria-label='Reply Transaction Code Part A']
    Run Keyword And Continue On Failure    Should Be Equal    ${HICN}    ${MedicareInsuranceNumber}
    Run Keyword And Continue On Failure    Should Be Equal    ${MedicarePartA_TransactionCode}    41    Value should have been B
    [Teardown]    Unselect Frame

TC04_BUYIN_AGEDSPENDDOWN
    Window Handles    WP_SIT01C
    ${Profile}=    Profile-Aged Spenddown
    log    ${Profile}
    Set Suite Variable    ${Profile}
    ${CaseNumber}=    kalo create aged spendown case
    ${Results}    ${CaseDictionary}    ${MedicareInsuranceNumber}=    kalo bendex scenario validation    ${CaseNumber}    AgedSpenddown
    ${Filename_Med}=    kalo create inbound file    ${CaseDictionary}    BUYINB    ${EMPTY}
    kalo transfer inbound file to sftp    ${Filename_Med}    BUYINB    ${EMPTY}
    Log To Console    FileTransfered Sucessfully-Wait for 5-7 mins for poller to pick
    Sleep    300s
    kalo validate inbound file in staging table    ${Results}[5]    BUYINB    ${Results}[10]
    kalo trigger active batch for interface    BUYINB
    Log To Console    Wait for 5 second for Batch to make affect
    Sleep    5s
    Kol Select Dropdowns Option Navigated Through Contacts    Medicare Buy-In    ${Path_Seibel_MedicareBuy_Validation}
    ${HICN}    SeleniumLibrary.Get Value    //input[@aria-labelledby='KIESMedicareClaimNumber_Label']
    ${MedicarePartB_TransactionCode}    SeleniumLibrary.Get Value    //input[@aria-label='Reply Transaction Code Part B']
    Run Keyword And Continue On Failure    Should Be Equal    ${HICN}    ${MedicareInsuranceNumber}
    Run Keyword And Continue On Failure    Should Be Equal    ${MedicarePartB_TransactionCode}    41    Value should have been B
    [Teardown]    Unselect Frame

TC05_BUYIN_BLINDSPENDOWN
    Window Handles    WP_SIT01C
    ${CaseNumber}=    Kol Create Blind Spendown Case
    [Teardown]    Unselect Frame

TC06_BUYIN_MANDATORYAGED
    Window Handles    WP_SIT01C
    ${CaseNumber}=    Kol Create Mandatory Aged Case
    [Teardown]    Unselect Frame

TC07_BUYIN_OPTIONALAGEDSSI
    Window Handles    WP_SIT01C
    ${CaseNumber}=    Kol Create Optional Aged with SSI Case
    [Teardown]    Unselect Frame

TC08_BUYIN_OPTIONALDISABLED
    Window Handles    WP_SIT01C
    ${CaseNumber}=    Kol Create Optional Disabled Without SSI Case
    [Teardown]    Unselect Frame

TC09_BUYIN_PREGNANTWOMENTBD
    Window Handles    WP_SIT01C
    ${CaseNumber}=    Kol Create Pregnant Women BD Case
    [Teardown]    Unselect Frame

*** Keywords ***
Kol Create Medicare Buyin Inbound File
    ${CaseDictionary}=    Create Dictionary    LastName=${ClientLastName}    FirstName=${ClientFirstName}    SSN=${SSNValue}    ClientID=${ClientID}    BENDEXDATE=${PastDate}
    Set To Dictionary    ${CaseDictionary}    DOB=${DOB}    StartDate=${BillingStartDate}    MedicareNumber=${MedicareInsuranceNumber}
    ${Filename_Med}=    kalo create inbound file    ${CaseDictionary}    BUYINA    ${EMPTY}
    kalo transfer inbound file to sftp    ${Filename_Med}    BUYINA    ${EMPTY}
    Log To Console    FileTransfered Sucessfully-Wait for 5-7 mins for poller to pick
    Sleep    300s
    kalo validate inbound file in staging table    ${ClientID}    BUYINA    ${SSNValue}
    Log To Console    Active Batch for Buy In Medicare Part A/Part B is triggered- Wait for 30-60 seconds to execute.
    kalo trigger active batch for interface    BUYINA
    kalo trigger active batch for interface    BUYINB
    Kol Select Dropdowns Option Navigated Through Contacts    Medicare    ${Path_Seibel_MedicareBuy_Validation}
    ${HICN}    SeleniumLibrary.Get Value    //input[@aria-labelledby='KIESMedicareClaimNumber_Label']
    Should Be Equal    ${HICN}    ${MedicareInsuranceNumber}
    Run Keyword If    "${HICN}"!="${MedicareInsuranceNumber}"    Fail    Medicare Job Did Not Ran Properly
    ${MedicarePartB_TransactionCode}    SeleniumLibrary.Get Value    //input[@aria-label='Reply Transaction Code Part B']
    ${MedicarePartA_TransactionCode}    SeleniumLibrary.Get Value    //input[@aria-label='Reply Transaction Code Part A']
    Run Keyword And Continue On Failure    Should Be Equal    ${MedicarePartB_TransactionCode}    41    Value should have been 41
    Run Keyword And Continue On Failure    Should Be Equal    ${MedicarePartA_TransactionCode}    B    Value should have been 41

Kol Create Blind Spendown Case
    ${StartDate}=    Get Random Any Past Date
    ${Profile}=    Profile-Blind Spenddown FPL 1 HH    3705
    log    ${Profile}
    Set Suite Variable    ${Profile}
    Create New Appl On Worker Portal
    ${Appl_Cnf_Nbr}=    Case_Creation_Test
    log    ${Appl_Cnf_Nbr}
    Unselect Frame
    Search a Case on worker Portal    ${Appl_Cnf_Nbr}
    Apply For MAGI Excepted Benefits
    Access COC Tab Options    ${Path_Siebel_COC_Medical_Condition}
    Kol Add COC Blind Disablity    ${StartDate}
    Kol Add Resource in COC Spendown    ${StartDate}
    Verify Benefit Plan
    ${keyPresent}    ${Profile_Benefit_Plan}=    Get value    \\Benefit_Plan
    ${status}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Profile_Benefit_Plan}
    Run Keyword If    '${status}' == 'True'    Log    PASS - Benefit name matched.
    ...    ELSE    FAIL    Benefit name not matched.

Kol Create Mandatory Aged Case
    ${Profile}=    Profile Mandatory Aged FPL    794
    log    ${Profile}
    Set Suite Variable    ${Profile}
    Create New Appl On Worker Portal
    ${Appl_Cnf_Nbr}=    Case_Creation_Test
    log    ${Appl_Cnf_Nbr}
    Unselect Frame
    Search a Case on worker Portal    ${Appl_Cnf_Nbr}
    Apply For MAGI Excepted Benefits
    Verify Benefit Plan
    ${keyPresent}    ${Profile_Benefit_Plan}=    Get value    \\Benefit_Plan
    ${status}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Profile_Benefit_Plan}
    Run Keyword If    '${status}' == 'True'    Log    PASS - Benefit name matched.
    ...    ELSE    FAIL    Benefit name not matched.

Kol Create Optional Aged with SSI Case
    ${Profile}=    Profile Optional Aged SSI FPL    1235
    log    ${Profile}
    Set Suite Variable    ${Profile}
    Create New Appl On Worker Portal
    ${Appl_Cnf_Nbr}=    Case_Creation_Test
    log    ${Appl_Cnf_Nbr}
    Unselect Frame
    Search a Case on worker Portal    ${Appl_Cnf_Nbr}
    Apply For MAGI Excepted Benefits
    Verify Benefit Plan
    ${keyPresent}    ${Profile_Benefit_Plan}=    Get value    \\Benefit_Plan
    ${status}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Profile_Benefit_Plan}
    Run Keyword If    '${status}' == 'True'    Log    PASS - Benefit name matched.
    ...    ELSE    FAIL    Benefit name not matched.
    [Teardown]    Unselect Frame

Kol Create Optional Disabled Without SSI Case
    ${Profile}=    Optional Disabled Without SSI FPL    1235
    log    ${Profile}
    Set Suite Variable    ${Profile}
    Create New Appl On Worker Portal
    ${Appl_Cnf_Nbr}=    Case_Creation_Test
    log    ${Appl_Cnf_Nbr}
    Unselect Frame
    Search a Case on worker Portal    ${Appl_Cnf_Nbr}
    Apply For MAGI Benefits
    Verify Benefit Plan
    ${keyPresent}    ${Profile_Benefit_Plan}=    Get value    \\Benefit_Plan
    ${status}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Profile_Benefit_Plan}
    Run Keyword If    '${status}' == 'True'    Log    PASS - Benefit name matched.
    ...    ELSE    FAIL    Benefit name not matched.

Kol Create Pregnant Women BD Case
    ${Profile}=    Profile Pregnant Women BD FPL    2421
    log    ${Profile}
    Set Suite Variable    ${Profile}
    Create New Appl On Worker Portal
    ${Appl_Cnf_Nbr}=    Case_Creation_Test
    log    ${Appl_Cnf_Nbr}
    Unselect Frame
    Search a Case on worker Portal    ${Appl_Cnf_Nbr}
    Verify Benefit Plan
    ${keyPresent}    ${Profile_Benefit_Plan}=    Get value    \\Benefit_Plan
    ${status}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Profile_Benefit_Plan}
    Run Keyword If    '${status}' == 'True'    Log    PASS - Benefit name matched.
    ...    ELSE    FAIL    Benefit name not matched.

Kol Create SLMB Retro Case
    ${Profile}=    Profile-SLMB 1 HH    1482    7970
    log    ${Profile}
    Set Suite Variable    ${Profile}
    Create New Appl On Worker Portal
    ${Appl_Cnf_Nbr}=    Case_Creation_Test
    log    ${Appl_Cnf_Nbr}
    Unselect Frame
    Search a Case on worker Portal    ${Appl_Cnf_Nbr}
    Apply For MAGI Excepted Benefits
    Unselect Frame
    Verify Benefit Plan
    ${keyPresent}    ${Profile_Benefit_Plan}=    Get value    \\Benefit_Plan
    ${status}=    Run Keyword and Return Status    Table Should Contain    xpath=//div//table[@summary='Benefits']    ${Profile_Benefit_Plan}
    Run Keyword If    '${status}' == 'True'    Log    PASS - Benefit name matched.
    ...    ELSE    FAIL    Benefit name not matched.

Kol aoo
    Kol Access Application Data    ${Path_Siebel_Medical_Services}

Kol Create and Push Medicare Part A or Part B IB File
    [Arguments]    ${CaseDictionary}    ${DOB}    ${BillingStartDate}    ${MedicareInsuranceNumber}    ${BuyIn}
    Set To Dictionary    ${CaseDictionary}    DOB=${DOB}    StartDate=${BillingStartDate}    MedicareNumber=${MedicareInsuranceNumber}
    ${Filename_MedicarePartA}=    Run Keyword If    "${BuyIn}"=="BUYINA"    kalo create inbound file    ${CaseDictionary}    BUYINA    ${EMPTY}
    Run Keyword If    "${BuyIn}"=="BUYINA"    kalo transfer inbound file to sftp    ${Filename_MedicarePartA}    BUYINA    ${EMPTY}
