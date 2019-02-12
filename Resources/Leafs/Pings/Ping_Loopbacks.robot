*** Settings ***
Library  AristaLibrary
Library  Collections
Resource  ../../Common/Pings/Initiate_Ping.robot

*** Keywords ***
Ping Leaf Loopbacks
    :FOR  ${loopback}  IN  @{loopback_ping_leafs}
    \  Log  ${loopback}
    \  ${source}=  Set Variable  Loopback0
    \  Run Keyword And Continue On Failure  Initiate Ping With Source  ${loopback}  ${source}