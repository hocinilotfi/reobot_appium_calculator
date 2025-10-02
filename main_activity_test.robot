*** Settings ***
Documentation    Simple example using AppiumLibrary
Library    AppiumLibrary
Library    .venv/lib/python3.13/site-packages/robot/libraries/String.py
# test clean up
Test Setup    Open calculator app
Test Teardown    Close Application

# UiAutomator2Options options;
# String deviceName = "emulator-5554";
# String appPackage = "com.miui.calculator";
# String appActivity = "com.miui.calculator.cal.CalculatorActivity";
# String platformName = "Android";
# String platformVersion = "14";
# String automationName = "UiAutomator2";

*** Variables ***
${ANDROID_AUTOMATION_NAME}    UIAutomator2
# ${ANDROID_APP}                ${CURDIR}/demoapp/ApiDemos-debug.apk
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_PLATFORM_VERSION}   14
${ANDROID_DEVICE_NAME}       emulator-5554
${ANDROID_APP_PACKAGE}       com.miui.calculator
${ANDROID_APP_ACTIVITY}      com.miui.calculator.cal.CalculatorActivity
${REMOTE_URL}                http://localhost:4723
${IMPLICIT_WAIT}             5s

# *** Test Cases ***
*** Keywords ***
Open Calculator App
    [Documentation]    Open Calculator App and perform a simple addition
    Open Application  ${REMOTE_URL}  automationName=${ANDROID_AUTOMATION_NAME}
      ...  platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}
      ...  appPackage=${ANDROID_APP_PACKAGE}  appActivity=${ANDROID_APP_ACTIVITY}
      ...  deviceName=${ANDROID_DEVICE_NAME}  newCommandTimeout=600
    
*** Test Cases ***
Simple Addition
    [Documentation]    Perform a simple addition operation in the calculator app

    Wait Until Element Is Visible    id=android:id/button1    ${IMPLICIT_WAIT}
    Click Element    id=android:id/button1
    Wait Until Element Is Visible    id=com.miui.calculator:id/digit_5    ${IMPLICIT_WAIT}
    Click Element    id=com.miui.calculator:id/digit_5
    Click Element    id=com.miui.calculator:id/op_add
    Click Element    id=com.miui.calculator:id/digit_3
    Click Element    id=com.miui.calculator:id/btn_equal_s
    ${result}=    Get Text    id=com.miui.calculator:id/result
    # trim result = 8 to just get the number = and 8
    @{words} =  Split String    ${result} 
    Should Be Equal As Strings    ${words}[1]   8
    Log To Console    "test1"