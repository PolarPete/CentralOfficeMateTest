*** Settings ***
Resource            ../Central/OFW_Login_Page.resource
Test Setup          OFW_Login_Page.Default Test Setup
Test Teardown       OFW_Login_Page.Default Test Teardown


*** Test Cases ***
[MPLO001] Login With Wrong Email And Wrong Password
    [Documentation]   Login With Wrong Email And Wrong Password
    [Tags]    Login
    Login With Wrong Email And Wrong Password     vvvv_5429@gmail.com    Ab12345678