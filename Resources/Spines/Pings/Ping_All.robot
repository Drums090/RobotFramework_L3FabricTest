*** Settings ***
Library  AristaLibrary
Library  Collections
Resource  Ping_P2Ps.robot
Resource  ./Ping_Loopbacks.robot

*** Keywords ***
Initiate All Spine Ping Tests
  [Documentation]  Running all Ping Tests on Spines
  [Arguments]  ${target_dictionary}
  Ping Spine P2Ps  ${target_dictionary}
  Ping Spine Loopbacks