*** Settings ***
# Library    SeleniumLibrary
Library    Collections        
Library    FakerLibrary
Library    String 
Library    DateTime
Library    BuiltIn           


*** Variables ***  

*** Keywords ***

#This will return Create account details
Get Create Account         
    ${fname}        Get First Name
    ${lname}        Get Last Name
    ${email}        Get Email
    ${uname}        Set Variable    ${fname}${lname}
    ${pswd}         Get Password
      
        
    ${dic_acc}=    Create Dictionary
                   Set To Dictionary    ${dic_acc}    First_Name=${fname}    Last_Name=${lname}    Email=${email}          ReEnter_Email=${email}    
                   ...                                User_Name=${uname}     Password=${pswd}      ReEnter_Pswd=${pswd}    Answer1=answer
                   ...                                Answer2=answer     Answer3=answer    Counselor=2         
    [Return]    ${dic_acc}
    
Get TaxInfo No
    ${Tax_Info} =    Create Dictionary    Plan_To_File_Tax_Nxt_Yr=No    Dependent_On_Tax_Return=No
    [Return]         ${Tax_Info} 
    
Get Pregnant Yes
    ${Exp_Due_Dt} =    Get Expected Due Dt    
    ${Pregnant} =      Create Dictionary    Pregnant=Yes    Babies_Expected=1    Expected_Due_Dt=${Exp_Due_Dt}
    [Return]           ${Pregnant}

Get Health Coverage No
    ${Health_Coverage} =         Create Dictionary    Disability_Lasts_12_Months=No    Recve_Med_Servc=No    US_Citizen=Yes    In_foster_18=No    full_time_student=No    
    [Return]                     ${Health_Coverage}
	
Get Health Coverage Yes
    ${Health_Coverage} =    Create Dictionary    Disability_Lasts_12_Months=Yes    Recve_Med_Servc=No    US_Citizen=Yes    In_foster_18=No    full_time_student=No
    [Return]    ${Health_Coverage}	

    
Get Foster Care Details
	[Arguments]		${Disability}
    ${Health_Coverage} =         Create Dictionary    Disability_Lasts_12_Months=${Disability}    Recve_Med_Servc=No    US_Citizen=Yes    In_foster_18=Yes    full_time_student=No    
    [Return]                     ${Health_Coverage} 

	
    
Get Hlth_Cvg and US Citizen Status COFA Yes    
    [Arguments]    ${Disability}    ${Ctzn_COFA}
    
    ${immig_dt}=    Get Past 90days
    # ${rand_int}=    Random Int    digit=11
    ${US_Citizen_Info}=    Create Dictionary    Immig_Status=Yes    Immig_Doc_Type=Visa    Other_Docs=AQQW    Immig_StDate=${immig_dt}[0]
    ...                                         Ctzn_Of_COFA=${Ctzn_COFA}    Country_Of_ctznshp=Republic of Palau
    ${Health_Coverage} =         Create Dictionary    Disability_Lasts_12_Months=${Disability}    Recve_SSI_Inc=Yes    Recve_Med_Servc=No    US_Citizen=No    US_Ctzn_Info=${US_Citizen_Info}     In_foster_18=No    full_time_student=No    
    [Return]                     ${Health_Coverage}
    
Get Hlth_Cvg and US Citizen Status COFA No    
    [Arguments]    ${Disability}    ${Ctzn_COFA}
    
    ${immig_dt}=    Get Past 90days
    # ${rand_int}=    Random Int    digit=11
    ${US_Citizen_Info}=    Create Dictionary    Immig_Status=Yes    Immig_Doc_Type=Visa       Other_Docs=AQQW    Immig_StDate=${immig_dt}[0]
    ...                                         Ctzn_Of_COFA=${Ctzn_COFA}    #Country_Of_ctznshp=Republic of Palau
    ${Health_Coverage} =         Create Dictionary    Disability_Lasts_12_Months=${Disability}    Recve_Med_Servc=No    US_Citizen=No    US_Ctzn_Info=${US_Citizen_Info}     In_foster_18=No    full_time_student=No    
    [Return]                     ${Health_Coverage}    
    

    
Get Employment
    [Arguments]    ${type}=Employed    ${amount}=0    ${inc_type}=Empty
    # Log    ${amount}   
    ${Employment}=    Run Keyword If    '${type}' == 'Employed'    Employed    ${amount}       
    ...              ELSE    
    ...               Not Employed    ${inc_type}    ${amount}
    [Return]    ${Employment}

Get Review Declare File
    ${Primary_First_Name}        First Name
    ${Primary_Last_Name}         Last Name
    ${Review_Declare_File} =     Create Dictionary    Renew_Eligibility=5 years    Does_Parent_Of_Child_Live_outside_Home=false    Terms_checkbox=true    Prim_App_FName=${Primary_First_Name}    Prim_App_LName=${Primary_Last_Name}
    [Return]                     ${Review_Declare_File} 
     
Get Auth Rep
    ${Auth_Rep_fname}        Get First Name
    ${Auth_Rep_lname}        Get Last Name
    ${Address}               Get Address
    ${Phone_Num}             Phone Number
    ${Auth_Rep} =            Create Dictionary    First_Name=${Auth_Rep_fname}    Last_Name=${Auth_Rep_lname}    Address=${Address}    Phone_Number=${Phone_Num}
    [Return]                 ${Auth_Rep}
    


#################################################################################################################

#This will return the First Name of Male/Female based on the Argument, If ${Gender} value 0 - Male and 1 - Female
 Get First Name
    [Arguments]    ${gender}=0
    ${fname}=    Run Keyword If    ${gender}== 0    Get Male First Name
    ...        ELSE
    ...        Get Female First Name    
    [Return]    ${fname}
    
Get Male First Name
    ${fname_m}=    First Name Male
    [Return]    ${fname_m}
    
Get Female First Name
    ${fname_f}=    First Name Female
    [Return]    ${fname_f}  

#This will return the Last Name
Get Last Name
    ${lname}=    Last Name
    [Return]    ${lname}

#This will return an email    
Get Email
    ${valid_email}=    Generate Random String    6    [LOWER]
    ${valid_email}=    Catenate    SEPARATOR=    ${valid_email}    .automation
    ${valid_domain}=    Set Variable    @gmail.com
    ${res}=    Catenate    SEPARATOR=    ${valid_email}    ${valid_domain}
    [Return]    ${res}
    
#This will return Password
Get Password
    ${randm_letr}=    Random Letter
    ${pwd}=    Password    8    false    true    true    true
    ${Pswd}=    Set Variable    ${randm_letr}${pwd}
    [Return]    ${Pswd}
    
Get Address
    ${address_line1}=    Street Name    
    ${app#}=             Building Number  
    ${city}=             Random Element    ('Honolulu', 'East Honolulu', 'Pearl City', 'Hilo', 'Kapolei')   
    ${state}=            Set Variable        HI
    ${zipcode}=          Random Element    ('96801', '96802', '96803', '96804', '96805', '96806', '96807', '96808')    #Zipcode
    ${county}=           Set Variable        Honolulu
    
    ${address}=    Create Dictionary    
    Set To Dictionary    ${address}    Address_Line1=${address_line1}    Apartment#=${app#}    City=${city}    State=${state}    Zip_Code=${zipcode}    County=${county}
    [Return]    ${address}
    
 
Employed
    [Arguments]    ${amount}    ${freq}=Monthly    
    ${Employer_Name}             Company
    ${Address}                   Street Name
    ${Building Number}           Building Number
    ${Postcode_Employment}       Postcode 
    # ${No_of_Days_wrkd}           Random Number    digits=7
    ${wages}=                    Run Keyword If    ${amount}==0    Random Wages
    ...                        ELSE
    ...                           Set Variable     ${amount}

    ${Employed} =                Create Dictionary    Employer_Name=${Employer_Name}    Address_Line1=${Address}    Apt#=${Building Number}    City=Honolulu    State=HI    Zip_Code=${Postcode_Employment}    Wages=${wages}    How_Often=${freq}
    
            Run Keyword If    '${freq}' == 'Daily'    Set To Dictionary    ${Employed}    No_Of_Days_Worked_Week=5
    ...  ELSE
    ...     Run Keyword If    '${freq}' == 'Hourly'    Set To Dictionary    ${Employed}    Avg_Hours_Worked_Week=40             
    
    [Return]    ${Employed}
        
Not Employed
    [Arguments]    ${type}    ${amnt}    ${freq}=Monthly
    ${inc_type}=                Run Keyword If    '${type}' == 'Empty'    Random Income Type
    ...                        ELSE
    ...                           Set Variable    ${type}
    ${amount}=                  Run Keyword If     ${amnt}==0               Random Wages
    ...                        ELSE
    ...                           Set Variable    ${amnt}
    ${Not_Employed}=            Create Dictionary    Income_Type=${inc_type}    Amount=${amount}    How_Often=${freq}
    [Return]                    ${Not_Employed}
    
Self Employment
    ${Self_Emp}=                Create Dictionary    Type_Of_Work=Work    Net_Inc=500
    [Return]                    ${Self_Emp}
    
Random Income Type
    ${Random_Income_Type}        Random Element    ('Capital Gains', 'Pension/Retirement Benefits', 'Temporary Disability Insurance','Social Security Benefits', 'Unemployment Insurance Benefits', 'Rental Income', 'Royalties', 'Alimony Received', 'Child Support Payments', 'Other Earned Income', 'Farming or Fishing', 'Cancelled Debt', 'Court Awards', 'Jury Duty Pay', 'Gambling, Prizes, or Awards')  
    [Return]                     ${Random_Income_Type}
        
Random Wages
    ${Random_Wages}=             Random Element    (1000,1100,1155,1164,1548,3014,4938,2222)
    [Return]                     ${Random_Wages}
    
How Often Daily
    ${Daily}=                    Create Dictionary    No_Of_Day_Worked_Week=5
    [Return]    ${Daily}        
    
Get Expected Due Dt
    
    [Documentation]    To get a date in future 9 months
    
    ${Rand_int_futr_9mnths} =     Random Int     min=1     max=280
    ${Cur_date} =	Get Current Date    
    ${Futr_date_9mnths} =	 Add Time To Date    ${Cur_date}    ${Rand_int_futr_9mnths} days	 
    ${Futr_date_9mnths} =    Convert Date    ${Futr_date_9mnths}    result_format=%m/%d/%Y
    [Return]   ${Futr_date_9mnths} 
    
Get Past 10days
    
    [Documentation]    To get From and To dates in past 10 days 
    
    ${Cur_date} =	Get Current Date    
    ${From_Dt} =	Add Time To Date    ${Cur_date}    -10 days	 
    ${From_Dt} =    Convert Date        ${From_Dt}    result_format=%m/%d/%Y
    
    ${To_Dt} =      Add Time To Date    ${Cur_date}    -1 days
    ${To_Dt} =      Convert Date        ${To_Dt}    result_format=%m/%d/%Y    
    [Return]   ${From_Dt}    ${To_Dt}
    
    
Get Past One Month   
     [Documentation]    To get From and To dates in past one month 
    
    ${Cur_date} =	Get Current Date    
    ${From_Dt} =	Add Time To Date    ${Cur_date}    -30 days	 
    ${From_Dt} =    Convert Date        ${From_Dt}    result_format=%m/%d/%Y
    
    ${To_Dt} =      Add Time To Date    ${Cur_date}    10 days
    ${To_Dt} =      Convert Date        ${To_Dt}    result_format=%m/%d/%Y    
    [Return]   ${From_Dt}    ${To_Dt}
    
#This will return different Ages

DOB Infant
    [Documentation]    To get a date in past 1 year
    
    ${Rand_int_past_1year} =     Random Int     min=1     max=364
    ${Cur_date} =	Get Current Date    
    ${Past_date_1year} =	Add Time To Date    ${Cur_date}    -${Rand_int_past_1year} days	 
    ${Past_date_1year} =     Convert Date    ${Past_date_1year}    result_format=%m/%d/%Y
    [Return]   ${Past_date_1year}
    
DOB Youth
    [Documentation]    To get a date in 25 years to 64 years
    
    ${Rand_int_past_18to64years} =     Random Int     min=9125    max=23424
    ${Cur_date} =    Get Current Date    
    ${Past_date_18to64years} =      Add Time To Date    ${Cur_date}    -${Rand_int_past_18to64years} days   
    ${Past_date_18to64years} =     Convert Date    ${Past_date_18to64years}    result_format=%m/%d/%Y
    [Return]   ${Past_date_18to64years}
    
DOB Adult
    [Documentation]    To get a date in 18 years to 64 years
    
    ${Rand_int_past_18to64years} =     Random Int     min=6570    max=23424
    ${Cur_date} =    Get Current Date    
    ${Past_date_18to64years} =      Add Time To Date    ${Cur_date}    -${Rand_int_past_18to64years} days   
    ${Past_date_18to64years} =     Convert Date    ${Past_date_18to64years}    result_format=%m/%d/%Y
    [Return]   ${Past_date_18to64years} 
    
DOB Adult1
    [Documentation]    To get a date in 25 years to 45 years
    
    ${Rand_int_past_18to64years} =     Random Int     min=9125    max=16425
    ${Cur_date} =    Get Current Date    
    ${Past_date_18to64years} =      Add Time To Date    ${Cur_date}    -${Rand_int_past_18to64years} days   
    ${Past_date_18to64years} =     Convert Date    ${Past_date_18to64years}    result_format=%m/%d/%Y
    [Return]   ${Past_date_18to64years}       
    
DOB Aged
    [Documentation]    To get a date in 65 years and above
    
    ${Rand_int_past_above65years} =     Random Int     min=23790    max=36600
    ${Cur_date} =	Get Current Date    
    ${Past_date_above65years} =	Add Time To Date    ${Cur_date}    -${Rand_int_past_above65years} days	 
    ${Past_date_above65years} =     Convert Date    ${Past_date_above65years}    result_format=%m/%d/%Y
    [Return]   ${Past_date_above65years}
    
DOB Age between
    [Documentation]    Date for age between given dates. Default for min is 0 and Default for max is 100    
    
    [Arguments]          ${Begin_Age}=0    ${End_Age}=100
    
    ${Begin_Age} =   Evaluate     ${Begin_Age} * 365
    ${End_Age} =     Evaluate     ${End_Age} * 365
    ${Rand_Birth_Age} =     Random Int     min=${Begin_Age}    max=${End_Age}
    ${Cur_date} =	Get Current Date    
    ${Birth_Age} =	Add Time To Date    ${Cur_date}    -${Rand_Birth_Age} days	 
    ${Birth_Age} =     Convert Date    ${Birth_Age}    result_format=%m/%d/%Y
    [Return]   ${Birth_Age} 

Get Family Health Coverage Yes
    ${Past_1Year_Dt}=            DOB Infant
    ${Famly_Health_Covr} =       Create Dictionary    Enroll_HCovr=true    Type_Covrg=Medicare    Policy_Name=Health Coverage    Plicy_Start_Dt=${Past_1Year_Dt}    Includes_Medical=true
    [Return]                     ${Famly_Health_Covr} 
    
Get Past One Day    
    ${Cur_date} =	         Get Current Date
    ${1day_Past_Dt}          Add Time To Date    ${Cur_date}        -1 days
    ${1day_Past_Dt}          Convert Date        ${1day_Past_Dt}    result_format=%m/%d/%Y
    [Return]                 ${1day_Past_Dt} 
    
Get Past 90days
    [Documentation]    To get From and To dates in past 90 days 
    
    ${Cur_date} =	Get Current Date    
    ${From_Dt} =	Add Time To Date    ${Cur_date}    -90 days	 
    ${From_Dt} =    Convert Date        ${From_Dt}    result_format=%m/%d/%Y
    
    ${To_Dt} =      Add Time To Date    ${Cur_date}    -1 days
    ${To_Dt} =      Convert Date        ${To_Dt}    result_format=%m/%d/%Y    
    [Return]   ${From_Dt}    ${To_Dt}
    
Get Past More than 90days
    [Documentation]    To get From and To dates in past more than 90 days 
    
    ${Cur_date} =	Get Current Date    
    ${From_Dt} =	Add Time To Date    ${Cur_date}    -100 days	 
    ${From_Dt} =    Convert Date        ${From_Dt}    result_format=%m/%d/%Y
    
    ${To_Dt} =      Add Time To Date    ${Cur_date}    -1 days
    ${To_Dt} =      Convert Date        ${To_Dt}    result_format=%m/%d/%Y    
    [Return]   ${From_Dt}    ${To_Dt}
    
Get Past Less than 90days
    [Documentation]    To get From and To dates in past less than 90 days 
    
    ${Cur_date} =	Get Current Date    
    ${From_Dt} =	Add Time To Date    ${Cur_date}    -80 days	 
    ${From_Dt} =    Convert Date        ${From_Dt}    result_format=%m/%d/%Y
    
    ${To_Dt} =      Add Time To Date    ${Cur_date}    -1 days
    ${To_Dt} =      Convert Date        ${To_Dt}    result_format=%m/%d/%Y    
    [Return]   ${From_Dt}    ${To_Dt} 
    
Get Today    
    ${CurDt}=    Get Current Date    UTC    -10 hours    result_format=%m/%d/%Y
    [Return]    ${CurDt}

###########Below profiles written for Oct release 19.10 System testing automation##########
        
Portal ST Profile for 90Days
    [Arguments]    ${Dates}
    
    ${Create_Account}           Get Create Account
    ${P1_First_Name}            Set Variable    ${Create_Account}[First_Name]
    ${P1_Last_Name}             Set Variable    ${Create_Account}[Last_Name]
    ${Get Address}              Get Address
    ${DOB}                      DOB Aged
    ${SSN}                      Ssn  
    ${TaxInfo}                  Get TaxInfo No
    ${HealthCoverage}           Create Dictionary       Disability_Lasts_12_Months=No    Recve_Med_Servc=Yes    From_Dt=${Dates}[0]    To_Dt=${Dates}[1]    US_Citizen=Yes       In_foster_18=No    full_time_student=No                                                      
    ${Employment_Type}          Employed    1000 
    ${ReviewDeclareFile}        Get Review Declare File
    ${temp_fname}=              Set Variable    ${Create_Account}[First_Name]
    ${temp_lname}=              Set Variable    ${Create_Account}[Last_Name]
    Set To Dictionary           ${ReviewDeclareFile}    Prim_App_FName=${temp_fname}    Prim_App_LName=${temp_lname}                                            
    ${temp} =                   Create Dictionary       First_Name=${P1_First_Name}     Last_Name=${P1_Last_Name}            Home_Address=${Get Address}    Spoken_Lang=English               
    ...                                                 Writen_Lang=English             Incarcerated=No    DOB=${DOB}        Gender=Male    SSN=${SSN}      Tax_Info=${TaxInfo}                                                                             
    ...                                                 Need_Hlth_Cvrge=true            Health_Coverage=${HealthCoverage}    Type_Of_Employment=true        Employment=${Employment_Type}                        
    ${person1}=                 Create Dictionary       P1=${temp}       
    ${ST_Portal}=               Create Dictionary       Create Account=${Create_Account}    Persons=${person1}    Tax_Dep=false    Incarceratd=false    Famly_Hlth_Covr=No    Hlth_Covr_Jobs=No        
    ...                                                 AI_AN_Info=No    Authorized_Rep=No     Review_Declare_File=${ReviewDeclareFile}
    [Return]    ${ST_Portal}
    
Siebel ST Profile for 90Days
    [Arguments]    ${Dates}
    
    ${P1_First_Name}            Get First Name    
    ${P1_Last_Name}             Get Last Name
    ${Get Address}              Get Address
    ${DOB}                      DOB Aged
    ${SSN}                      Ssn  
    ${TaxInfo}                  Get TaxInfo No
    ${HealthCoverage}           Create Dictionary       Disability_Lasts_12_Months=No    Recve_Med_Servc=Yes    From_Dt=${Dates}[0]    To_Dt=${Dates}[1]    US_Citizen=Yes     In_foster_18=No    full_time_student=No                                                     
    ${Employment_Type}          Employed    1000 
    ${ReviewDeclareFile}        Get Review Declare File
    ${temp_fname}=              Set Variable    ${P1_First_Name}
    ${temp_lname}=              Set Variable    ${P1_Last_Name}
    Set To Dictionary           ${ReviewDeclareFile}    Prim_App_FName=${temp_fname}    Prim_App_LName=${temp_lname}                                            
    ${temp} =                   Create Dictionary       First_Name=${P1_First_Name}     Last_Name=${P1_Last_Name}            Home_Address=${Get Address}    Spoken_Lang=English               
    ...                                                 Writen_Lang=English             Incarcerated=No    DOB=${DOB}        Gender=Male    SSN=${SSN}      Tax_Info=${TaxInfo}                                                                             
    ...                                                 Need_Hlth_Cvrge=true            Health_Coverage=${HealthCoverage}    Type_Of_Employment=true        Employment=${Employment_Type}                        
    ${person1}=                 Create Dictionary       P1=${temp}       
    ${ST_Siebel}=               Create Dictionary       Persons=${person1}    Tax_Dep=false    Incarceratd=false    Famly_Hlth_Covr=No    Hlth_Covr_Jobs=No        
    ...                                                 AI_AN_Info=No         Authorized_Rep=No     Review_Declare_File=${ReviewDeclareFile}     
           
    [Return]                    ${ST_Siebel}
    
TC001_122
    [Documentation]    TC001_122_Retro verbiage_Date Input_Client Portal

    ${<90days}=          Get Past More than 90days
    ${TC001_122}=        Portal ST Profile for 90Days    ${<90days}
    [Return]    ${TC001_122}
    
TC002_122
    [Documentation]    TC002_122_Retro verbiage_Date Input more than 90 days_Worker Portal

    ${<90days}=          Get Past More than 90days
    ${TC002_122}=        Siebel ST Profile for 90Days    ${<90days}
    [Return]    ${TC002_122}
    
TC003_122
    [Documentation]    TC003_122_Retro verbiage_Date Input less than 90 days_Worker Portal
    
    ${>90days}=          Get Past Less than 90days
    ${TC003_122}=        Siebel ST Profile for 90Days    ${>90days}
    [Return]    ${TC003_122}               
    

    


    
    
  
    



    
    
       
    
    
           
    