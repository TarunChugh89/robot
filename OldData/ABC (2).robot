*** Settings ***
Suite Setup       Run Keyword And Ignore Error    Kol Create Suite Level Bendex Interface Data    #    #
Resource          ../Resources/Kalo_Interface_Keyword.robot    #

*** Variables ***
${WebCredentials}    C:\\RideWorkspace\\KOLEA_AUTOMATION\\WebCredentials.yaml
${SiebelEnv}      SiebelSIT01C
${FilesLocation}    \\InterfaceUpgrades\\TESTDATAFORFILECREATION
${OutputLocation}    ${CURDIR}\\TESTDATAFORFILECREATION\\OUTPUT\\BENDEX\\BendexFile.txt
${PartB_OBFILE}    ${CURDIR}\\TESTDATAFORFILECREATION\\BENDEX\\Outbound\\KH.PN9E1D.TXT
${PartA_OBFILE}    ${CURDIR}\\TESTDATAFORFILECREATION\\BENDEX\\Outbound\\KH.PN5A1D.TXT
${BendexScenarioList}    ${CURDIR}\\TESTDATAFORFILECREATION\\BENDEX\\ScenarioList\\ScenarioList.xlsx

*** Test Cases ***
TC_001_Bendex_MandatoryDisabled
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    Mandatory Disabled
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    ${FutureDate}=    Add Time To Date    ${Temp}    0 days    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_002_Bendex_QMB
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    QMB
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    #${FutureDate}=    Add Time To Date    ${Temp}    30 days    result_format=%Y%m
    #Benefit for QMB start next month and hence same date in Outbound File.
    ${FutureDate}=    py_Add_Month_toDate    ${Temp}    1
    ${FutureDate}=    Convert Date    ${FutureDate}    date_format=%Y%m%d    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    Kol Validate Part A Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartA_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_003_Bendex_QDWI
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    QDWI
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    #Subtraction since ES start date is also 30 days in past.
    ${FutureDate}=    Subtract Time From Date    ${Temp}    30 days    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part A Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartA_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_004_Bendex_MandatoryAged
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    Mandatory Aged
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    ${FutureDate}=    Add Time To Date    ${Temp}    0 days    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_005_Bendex_OptionalAgedSSI
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    Optional Aged with SSI
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    ${FutureDate}=    Add Time To Date    ${Temp}    0 days    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_006_Bendex_OptionalDisabledWithoutSSI
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    Optional Disabled
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    #${FutureDate}=    Add Time To Date    ${Temp}    60 days    result_format=%Y%m
    ${FutureDate}=    py_Add_Month_toDate    ${Temp}    2
    ${FutureDate}=    Convert Date    ${FutureDate}    date_format=%Y%m%d    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_007_Bendex_PregnantWomenBD
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    Pregnant Woman BD
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    # Three months in future since pregnant disablity kicks in next month.
    #${FutureDate}=    Add Time To Date    ${Temp}    60 days    result_format=%Y%m
    ${FutureDate}=    py_Add_Month_toDate    ${Temp}    3
    ${FutureDate}=    Convert Date    ${FutureDate}    date_format=%Y%m%d    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}    Gender=Female
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]    Gender=F
    [Teardown]    Unselect Frame

TC_008_Bendex_AgedSpendown
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    Aged Spenddown
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    #${FutureDate}=    Add Time To Date    ${Temp}    60 days    result_format=%Y%m
    ${FutureDate}=    py_Add_Month_toDate    ${Temp}    2
    ${FutureDate}=    Convert Date    ${FutureDate}    date_format=%Y%m%d    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_009_Bendex_BlindSpendown
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    Blind Spenddown
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    #${FutureDate}=    Add Time To Date    ${Temp}    60 days    result_format=%Y%m
    ${FutureDate}=    py_Add_Month_toDate    ${Temp}    2
    ${FutureDate}=    Convert Date    ${FutureDate}    date_format=%Y%m%d    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame

TC_0010_Bendex_SLMBRetro
    ${CaseInfo}=    Py Read Data From BendexorBuyIn Pandas    ${OutputLocation}    SLMB
    Should Not Be Empty    ${CaseInfo}    Data for this Particular Benefit is not created during runtime.
    ${Temp}=    Set Variable    ${CaseInfo}[0][11]
    # Subtract 60 days since ES start date is also 60 days in past.
    ${FutureDate}=    Subtract Time From Date    ${Temp}    60 days    result_format=%Y%m
    Window Handles    WP_SIT01C
    Kol Validate Bendex Validation    ${CaseInfo}
    ${MedicareInsuranceNumber}    Get Element Attribute    //tr[@id=1]//td[contains(@id,'HICN')]    title
    Kol Validate Part B Buy In Outbound File    ${CaseInfo}[0][2]    ${CaseInfo}[0][3]    ${FutureDate}    ${MedicareInsuranceNumber}    ${PartB_OBFILE}    ${CaseInfo}[0][4]    ${CaseInfo}[0][5]    ${CaseInfo}[0][6]
    [Teardown]    Unselect Frame
