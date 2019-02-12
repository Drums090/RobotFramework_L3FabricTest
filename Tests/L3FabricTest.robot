*** Settings ***
Resource  ../Resources/Common/Common.robot
Resource  ../Resources/Spines/Pings/Ping_All.robot
Resource  ../Resources/Common/OSPF/Validate_OSPF_Neighbors.robot
Resource  ../Resources/Common/BGP/Validate_EVPN_Peerings.robot
Resource  ../Resources/Common/BGP/Validate_Underlay_Peerings.robot
Resource  ../Resources/Leafs/Pings/Ping_All.robot

Suite Setup  Connect to Switches
Suite Teardown  Clear all Connections

*** Test Cases ***
Spine Ping Tests
    [Documentation]  Validate Spines are able to ping p2p and loopbacks
    [Tags]  SPINE_PING
    :FOR  ${spine}  IN  @{spines}
    \  Change To Switch  ${spine}
    \  ${switch_info}=  Get Switch
    \  Log  ${switch_info}
    \  Log  ${spine}
    \  ${target_dictionary}=  Get From Dictionary  ${spines}  ${spine}
    \  Initiate All Spine Ping Tests  ${target_dictionary}
Spine Validate Underlay
    [Documentation]  Validate Underlay for Spines based on variables
    [Tags]  Underlay
    :FOR  ${spine}  IN  @{spines}
    \  Change To Switch  ${spine}
    \  ${switch_info}=  Get Switch
    \  Log  ${switch_info}
    \  Log  ${spine}
    \  ${target_dictionary}=  Get From Dictionary  ${spines}  ${spine}
    \  Run Keyword If  '${underlay}' == 'OSPF'  Run Keyword and Continue on Failure  Validate OSPF Neighbors  ${target_dictionary}  ${spine}
    \  Run Keyword If  '${underlay}' == 'BGP'  Run Keyword and Continue on Failure  Validate Underlay Peerings  ${target_dictionary}  ${spine}
Spine EVPN Peering Validation
    [Documentation]  Validate EVPN Peerings for Spines
    [Tags]  SPINE_EVPN
    :FOR  ${spine}  IN  @{spines}
    \  Change To Switch  ${spine}
    \  ${switch_info}=  Get Switch
    \  Log  ${switch_info}
    \  Log  ${spine}
    \  ${target_dictionary}=  Get From Dictionary  ${spines}  ${spine}
    \  Validate EVPN Peerings  ${target_dictionary}  ${spine}
Leaf Ping Tests
    [Documentation]  Validate Leafs are able to ping loopbacks
    [Tags]  LEAF_PING
    :FOR  ${leaf}  IN  @{leafs}
    \  Change To Switch  ${leaf}
    \  ${switch_info}=  Get Switch
    \  Log  ${switch_info}
    \  Log  ${leaf}
    \  ${target_dictionary}=  Get From Dictionary  ${leafs}  ${leaf}
    \  Initiate All Leaf Ping Tests  ${target_dictionary}
Leaf OSPF Neighbor Validation
    [Documentation]  Validate OSPF Neighbors for Leafs
    [Tags]  LEAF_OSPF
    :FOR  ${leaf}  IN  @{leafs}
    \  Change To Switch  ${leaf}
    \  ${switch_info}=  Get Switch
    \  Log  ${switch_info}
    \  Log  ${leaf}
    \  ${target_dictionary}=  Get From Dictionary  ${leafs}  ${leaf}
    \  Validate OSPF Neighbors  ${target_dictionary}  ${leaf}
Leaf EVPN Peering Validation
    [Documentation]  Validate EVPN Peerings for Leafs
    [Tags]  LEAF_EVPN
    :FOR  ${leaf}  IN  @{leafs}
    \  Change To Switch  ${leaf}
    \  ${switch_info}=  Get Switch
    \  Log  ${switch_info}
    \  Log  ${leaf}
    \  ${target_dictionary}=  Get From Dictionary  ${leafs}  ${leaf}
    \  Validate EVPN Peerings  ${target_dictionary}  ${leaf}
