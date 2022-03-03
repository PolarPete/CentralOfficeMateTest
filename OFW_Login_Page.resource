*** Settings ***
Library    PuppeteerLibrary
Library    DatabaseLibrary
Library    Process
Library    Dialogs
Library    BuiltIn
Library    Collections
Library    DateTime
Library    String
Library    DatabaseLibrary
Library    RequestsLibrary


*** Variables ***

# LoginBox
${MP_Login_Btn}           xpath=//a[.='LOG IN']
${MP_LoginBox_lbl_Login}           xpath=//h1[@class='_1LSq-'][text()="Log in."]

${MP_LoginBox_lbl_Email}      xpath=//label[.='Email*']
${MP_LoginBox_txt_Email}      xpath=//input[@id='txt-loginForm-email']
${MP_LoginBox_lbl_Password}       xpath=//label[.='Password*']
${MP_LoginBox_txt_Password}       xpath=//input[@id='txt-loginForm-password']
${MP_LoginBox_btn_ShowPassword}       xpath=//img[@alt='Show Password']


${MP_LoginBox_lbl_RememberLogin}        xpath=//label[@id='lab-loginForm-remember']
${MP_LoginBox_chk_ShowPassword}        xpath=//div[@class='_3VHnW']
${MP_LoginBox_btn_ForgotPassword}        xpath=//a[@id='lnk-LoginPage-ForgotPassword']
${MP_LoginBox_btn_SubmitLogin}        xpath=//button[@id='btn-LoginFormSection-submitButton']
${MP_LoginBox_lbl_or}        xpath=//p[@class='_18n4L'][text()="or"]  
${MP_LoginBox_btn_FBlogin}        xpath=//button[@id='bt-LoginPage-FBLogin']
${MP_LoginBox_lbl_TermsAndConditon}        xpath=//label[@class='ClickingText__EnhanceLabel-sc-zv18xm-0 korssl']
${MP_LoginBox_lbl_NotaMemberYet}        xpath=//div[@class='_3rBYL'][text()="Not a member yet ?"]
${MP_LoginBox_lbl_Login-Register}        xpath=//a[@id='lnk-LoginPage-Register']

#LoginBox_APi
${Login_API}      https://www.officemate.co.th/api/login

#PopUP
${MP_btn_Close_Popup_Banner}           xpath=//*[@id="wrap-close-button-1454703945249"]


*** Keywords ***
Default Test Setup
    &{options}    create dictionary    headless=${False}    ignore_https_errors=${True}
    PuppeteerLibrary.Open Browser    https://www.officemate.co.th/en     options=&{options}    alias=OfficeMateEn_1
    Close the Popup window before login page

Default Test Teardown
    PuppeteerLibrary.Capture Page Screenshot
    Close All Browser


Select login button on Headbar
   Wait Until Element Is Visible   ${MP_Login_Btn} 
   Click Element       ${MP_Login_Btn} 



Wait for login box loaded
    [Documentation]  wait for login box
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_Login}          
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_Email}      
    Wait Until Element Is Visible     ${MP_LoginBox_txt_Email}      
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_Password}       
    Wait Until Element Is Visible     ${MP_LoginBox_txt_Password}       
    Wait Until Element Is Visible     ${MP_LoginBox_btn_ShowPassword}       
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_RememberLogin}        
    Wait Until Element Is Visible     ${MP_LoginBox_chk_ShowPassword}       
    Wait Until Element Is Visible     ${MP_LoginBox_btn_ForgotPassword}        
    Wait Until Element Is Visible     ${MP_LoginBox_btn_SubmitLogin}        
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_or}       
    Wait Until Element Is Visible     ${MP_LoginBox_btn_FBlogin}        
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_TermsAndConditon}        
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_NotaMemberYet}       
    Wait Until Element Is Visible     ${MP_LoginBox_lbl_Login-Register} 
    Capture Page Screenshot


Login With Wrong Email And Wrong Password
    [Documentation]   Login With Wrong Email And Wrong Password
    [Arguments]    ${Email}=vvvv_5429@gmail.com    ${Password}=Ab12345678
    Run keyword and Ignore Error     Close the Popup window before login page
    Select login button on Headbar    
    Wait for login box loaded
    Clear Element Text   ${MP_LoginBox_txt_Email} 
    Clear Element Text   ${MP_LoginBox_txt_Password} 
    Input Text    ${MP_LoginBox_txt_Email}       ${Email}
    Input Password  ${MP_LoginBox_txt_Password}     ${Password}
    Run Async Keywords  Click Element    ${MP_LoginBox_btn_SubmitLogin} 
    ...  AND  Wait For Request Url  ${Login_API}  POST
    ...  AND  Wait For Response Url  ${Login_API}  401
    sleep   4s


Close the Popup window before login page
    [Documentation]  ปิดหน้า popup ก่อนที่จะเข้าหน้า login
    ${is_login_page_visible}   Run Keyword And Return Status    Wait Until Element Is Visible    ${MP_btn_Close_Popup_Banner}   100s
    Run Keyword If  "${is_login_page_visible}"=="True"   Click Element   ${MP_btn_Close_Popup_Banner}  
