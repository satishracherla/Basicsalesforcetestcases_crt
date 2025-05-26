*** Settings ***
Library SeleniumLibrary
*** Variables ***
${number} 100
*** Test Cases ***
TC1
 Open Browser https://www.tutorialspoint.com/ chrome
 Maximize Browser Window
 Close Browser
TC2
 ${a} Set Variable Hi
 Log ${a}
 ${b} Set Variable If ${number}>0 Yes No
 Log ${b}