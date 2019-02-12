*** Settings ***
Library  AristaLibrary
Library  Collections
Variables  ../../Data/Vars/vars.py



*** Variables ***
${TRANSPORT}  https
${PORT}  443
${USERNAME}  admin
${PASSWORD}  arista


*** Keywords ***
Connect To Switches
    [Documentation]  Establish connection to a switch which gets used by test cases.
    Log  List value is ${spines}
    :FOR  ${spine}  IN  @{spines}
    \  Log  ${spine}
    \  ${target_dictionary}=  Get From Dictionary  ${spines}  ${spine}
    \  Log  ${target_dictionary}
    \  ${host}=  Get From Dictionary  ${target_dictionary}  management_ip
    \  Log  ${host}
    \  Run Keyword and Continue on Failure  Connect To  host=${host}  transport=${TRANSPORT}  username=${USERNAME}  password=${PASSWORD}  port=${PORT}  alias=${spine}

    :FOR  ${leaf}  IN  @{leafs}
    \  Log  ${leaf}
    \  ${target_dictionary}=  Get From Dictionary  ${leafs}  ${leaf}
    \  Log  ${target_dictionary}
    \  ${host}=  Get From Dictionary  ${target_dictionary}  management_ip
    \  Log  ${host}
    \  Run Keyword and Continue on Failure  Connect To  host=${host}  transport=${TRANSPORT}  username=${USERNAME}  password=${PASSWORD}  port=${PORT}  alias=${leaf}