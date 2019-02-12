*** Settings ***
Library  AristaLibrary
Library  Collections
Resource  ../../Common/Pings/Initiate_Ping.robot

*** Keywords ***
Ping Spine Loopbacks
    :FOR  ${loopback}  IN  @{loopback_ping}
    \  Log  ${loopback}
    ${source}=  Set Variable  Loopback0
    \  Run Keyword And Continue On Failure  Initiate Ping With Source  ${loopback}  ${source}