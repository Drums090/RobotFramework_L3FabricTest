*** Settings ***
Library  AristaLibrary
Library  Collections
Resource  ./Ping_Loopbacks.robot

*** Keywords ***
Initiate All Leaf Ping Tests
  [Documentation]  Running all Ping Tests on Leafs
  Ping Leaf Loopbacks