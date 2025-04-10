*** Settings ***
Library           RequestsLibrary
Library           SeleniumLibrary
Library           Collections

*** Test Cases ***
TC01_ListSet
    @{SampleList}    Create List    kiwi
    Append To List    ${SampleList}    apple
    Append To List    ${SampleList}    orange
    Append To List    ${SampleList}    banana
    Append To List    ${SampleList}    grape
    FOR    ${items}    IN    @{sampleList}
        Run Keyword And Continue On Failure    Should Be Equal    ${items}    orange    failed
    END

TC_02_DictionarySet
    ${sampleDict}    Create Dictionary    Name=john    age=30    city=New york
    FOR    ${items}    IN    @{sampleDict}
        ${tempName}    Get From Dictionary    ${sampleDict}    age
        Run Keyword And Continue On Failure    Should Be Equal    ${tempName}    JONH    failed
    END
