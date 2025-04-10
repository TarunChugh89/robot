*** Settings ***
Library    Collections    
Library    ../Utility/ReadXL.py
# Library    ../Utility/PythonLib.py 
Library    ../Utility/PythonLib2.py  
Library    ../Utility/Generic.py                   
*** Keywords ***
Get Excel Rows
    [Arguments]    ${path}    ${sheet}
    ${xlrows}    Xl Rows    ${path}    ${sheet}  
    [Return]    ${xlrows}
Get Excel Cols
    [Arguments]    ${path}    ${sheet}
    ${xlrows}    Xl Cols    ${path}    ${sheet}  
    [Return]    ${xlrows}

Get Excel Row
    [Arguments]    ${path}    ${sheet}    ${txtSeacrh}
    ${xlrow}    Get Row    ${path}    ${sheet}    ${txtSeacrh} 
    [Return]    ${xlrow}
Get Excel Col
    [Arguments]    ${path}    ${sheet}    ${txtSeacrh}
    ${xlcol}    Get Col No    ${path}    ${sheet}    ${txtSeacrh} 
    [Return]    ${xlcol}
Get Excel Cell Value
    [Arguments]    ${path}    ${sheet}    ${row}    ${col}
    ${cellValue}    Xl Cell Value    ${path}    ${sheet}    ${row}    ${col}
    [Return]    ${cellValue}
Open the Browser
    [Arguments]    ${url}
    Launch Browser    ${url}
Input Text
    [Arguments]    ${xpath}    ${txtValue}
    Enter Text    ${xpath}    ${txtValue}
Click WebElement
    [Arguments]    ${xpath}
    ${status}    Click Button    ${xpath}
    Log Many    ${xpath}    Found and Clicked    
Close Alert Popups
    [Arguments]    ${action}
    ${status}=    Handle Alet Popup    ${action}
    Log    ${status}
Select an Item
    [Arguments]    ${xpath}    ${item}
    ${status}    Select Item    ${xpath}    ${item}   
    Log    ${status} 
Get Session Variables
    [Arguments]    ${path}
    @{list}    create list  
    ${list}    Session Vars    ${path} 
    [Return]    ${list}
Hack Opened Browser
    [Arguments]    ${session}    ${url}
    Create Session    ${session}    ${url}
Hack Opened Browsers
    ${list}    Get Session Variables    .\\TestData\\SessionInfo.txt
    Create Session    @{list}[0]    @{list}[1]
Wait For WebElement
    [Arguments]    ${xpath}    ${timeunit} 
    ${element}    Waitfor Object    ${xpath}    ${timeunit}    
Get Table Rows
    [Arguments]    ${xpath}
    ${xpath}    Append Xpath    ${xpath}    //tr
    ${rows}    No Ofelements    ${xpath}
    [Return]    ${rows}
Get Table Columns
    [Arguments]    ${xpath}
    ${xpath}    Append Xpath    ${xpath}    //tr[1]//td
    ${cols}    No Ofelements    ${xpath}
    [Return]    ${cols}
Get Text1
    [Arguments]    ${xpath}
    ${text}    Get Text    ${xpath}
    [Return]    ${text}
Replace Xpath
    [Arguments]    @{vars}
    ${xpath}    Change Xpath    @{vars}
    [Return]    ${xpath}
Get Table Data
    [Arguments]    ${xpath}
    @{tableData}    Create List  
    ${rows}    Get Table Rows    ${xpath} 
    ${cols}    Get Table Columns    ${xpath}
    ${xpath}    Append Xpath    ${xpath}    //tr[row]//td[col]
    :FOR    ${i}    IN RANGE    1    ${rows}
    \    @{data}    Create List    
    \    ${data}    Get Row Data    ${xpath}    ${i}    ${cols}
    \    Append To List    ${tableData}    ${data}
    Log    ${tableData}
    [Return]    ${tableData}    
Get Row Data
    [Arguments]    ${xpath}    ${i}    ${cols}
    # ${cols}    Get Table Columns    ${xpath}
    ${row}    Convert To String    ${i}
    @{rowdata}    Create List
    ${range}    Convert To Integer    ${cols}               
    :FOR    ${j}    IN RANGE    1    ${range}
    \    ${col}    Convert To String    ${j}
    \    ${xpathnew}    Replace Xpath    ${xpath}    row    ${row}    col    ${col} 
    \    Log    ${xpathnew}    
    \    ${cellText}    Get Text1    ${xpathnew} 
    \    Log    ${cellText}    
    \    Append To List    ${rowData}    ${cellText}  
    Log    ${rowData} 
    [Return]    ${rowData} 
Get Element Attribute
    [Arguments]    ${xpath}    ${type}
    ${txtType}    Get Attrib    ${xpath}    ${type}    
    [Return]    ${txtType}
Get Element Count
    [Arguments]    ${xpath} 
    ${count}    No Ofelements    ${xpath}
    [Return]    ${count}
Change to String
    [Arguments]    ${string} 
    ${txtStr}    To String    ${string}
    [Return]    ${txtStr} 
Switch to Frame
    [Arguments]    @{list}
    Handle Frames    @{list}
Switch to IFrame
    [Arguments]    ${xpath}
    ${text}    Switch Frames    ${xpath}
    [Return]    ${text}
Switch Back to Parent
    ${text}    Switch Backto
    [Return]    ${text}
Upload File
    [Arguments]    ${autoitexe}    ${filePath}
    ${status}    Run Auto It Exe    ${autoitexe}    ${filePath}
    [Return]    ${status}
Click WebElement By Coordinates
    [Arguments]    ${xpath}
    ${status}    Click Webelement Byposition    ${xpath}
    [Return]    ${status}
Get Table Column Position
    [Arguments]    ${xpath}    ${columnName} 
    ${colNo}    Gettbl Col No   ${xpath}    ${columnName} 
    [Return]    ${colNo}  
    
      


    


