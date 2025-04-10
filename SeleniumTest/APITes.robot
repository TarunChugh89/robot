*** Settings ***
Library           RequestsLibrary
Library           SeleniumLibrary
Library           Collections

*** Test Cases ***
TC01_ReadAPI
    Create Session    mysession    https://reqres.in
    ${response}    GET On Session    mysession    url=/api/users?page=2
    ${responseJson}    Set Variable    ${response.json()}
    Log    ${responseJson}
    ${dataList}    Get From Dictionary    ${responseJson}    data
    FOR    ${item}    IN    @{dataList}
    ${email}    Get From Dictionary    ${item}    email
    Run Keyword And Continue On Failure    Should Be Equal    ${email}    "tarun"    not matching
    Log    ${email}
    END
