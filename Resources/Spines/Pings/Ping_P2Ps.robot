*** Settings ***
Library  AristaLibrary
Library  Collections
Resource  ../../Common/Pings/Initiate_Ping.robot

*** Keywords ***
Ping Spine P2Ps
    [Arguments]  ${target_dictionary}
    @{p2ps}=  Get From Dictionary  ${target_dictionary}  p2p_ping
    Log  ${target_dictionary}
    Log  ${p2ps}
    :FOR  ${ip}  IN  @{p2ps}
    \  Run Keyword And Continue On Failure  Initiate Ping Without Source  ${ip}