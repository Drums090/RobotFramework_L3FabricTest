*** Settings ***
Library  AristaLibrary
Library  Collections

*** Keywords ***
Initiate Ping With Source
    [Arguments]  ${ip}  ${source}
    ${output}=  Enable  ping ${ip} source ${source}
    ${result}=  Get From Dictionary  ${output[0]}    result
    Log  ${result}
    ${match}    ${group1}=  Should Match Regexp  ${result['messages'][0]}    (\\d+)% packet loss
    Should Be Equal As Integers  ${group1}  0  msg="Packets lost percent not zero!!!"
Initiate Ping Without Source
    [Arguments]  ${ip}
    ${output}=  Enable  ping ${ip}
    ${result}=  Get From Dictionary  ${output[0]}    result
    Log  ${result}
    ${match}    ${group1}=  Should Match Regexp  ${result['messages'][0]}    (\\d+)% packet loss
    Should Be Equal As Integers  ${group1}  0  msg="Packets lost percent not zero!!!"