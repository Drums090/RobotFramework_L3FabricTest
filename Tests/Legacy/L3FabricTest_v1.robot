# -*- coding: robot -*-
# :setf robot
# :set noexpandtab
*** Settings ***
Library  AristaLibrary
Library  Collections
Suite Setup  Connect To Switches
Suite Teardown  Clear All Connections
Variables  ../Data/Vars/vars.py



*** Variables ***
${TRANSPORT}  https
${PORT}  443
${USERNAME}  admin
${PASSWORD}  arista

@{SPINE1}  10.255.255.101  DCA-Spine1
@{SPINE2}  10.255.255.102  DCA-Spine2
@{SPINE_LIST}=  ${SPINE1}  ${SPINE2}
@{SPINE1_TEST_IPS}=  10.101.201.1  10.101.202.1  10.101.203.1  10.101.204.1
@{SPINE2_TEST_IPS}=  10.102.201.1  10.102.202.1  10.102.203.1  10.102.204.1


*** Test Cases ***
Loop Through SPINES
   :FOR  ${spine_pair}  IN  @{SPINE_LIST}
   \  Run Keyword and Continue on Failure  Run Keyword If  '${spine_pair[0]}'=='10.255.255.101'  Ping Test  ${spine_pair}  ${SPINE1_TEST_IPS}
   \  Run Keyword and Continue on Failure  Run Keyword If  '${spine_pair[0]}'=='10.255.255.102'  Ping Test  ${spine_pair}  ${SPINE2_TEST_IPS}



*** Keywords ***
Connect To Switches
    [Documentation]  Establish connection to a switch which gets used by test cases.
    Log  List value is ${SPINE_LIST}
    :FOR  ${spine_pair}  IN  @{SPINE_LIST}
    \  Run Keyword and Continue on Failure  Connect To    host=${spine_pair[0]}    transport=${TRANSPORT}    username=${USERNAME}   password=${PASSWORD}    port=${PORT}  alias=${spine_pair[1]}

Ping Test
  [Arguments]  ${spine_pair}  ${PING_LIST}
  Change To Switch  ${spine_pair[1]} 
  :FOR  ${ip}  IN  @{PING_LIST} 
  \  ${output}=  Enable  ping ${ip}
  \  ${result}=  Get From Dictionary  ${output[0]}    result
  \  Log  ${result}
  \  ${match}    ${group1}=  Should Match Regexp  ${result['messages'][0]}    (\\d+)% packet loss
  \  Should Be Equal As Integers  ${group1}  0  msg="Packets lost percent not zero!!!" 
