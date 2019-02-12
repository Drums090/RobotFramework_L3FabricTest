*** Settings ***
Library  AristaLibrary
Library  Collections
Resource  ../../Common/Pings/Initiate_Ping.robot

*** Keywords ***
Ping Leaf Loopbacks
    :FOR  ${loopback}  IN  @{loopback_ping}
    \  Log  ${loopback}
    \  Run Keyword And Continue On Failure  Initiate Ping With Source  ${loopback}  'Loopback0'