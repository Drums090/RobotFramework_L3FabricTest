*** Settings ***
Library  AristaLibrary
Library  AristaLibrary.Expect
Library  Collections


*** Keywords ***
Validate Underlay Peerings
    [Documentation]  Validating Underlay Peerings on Switches
    [Arguments]  ${target_container}  ${switch}
    ${current_peers}=  Get Underlay Peers  ${switch}
    Log  ${current_peers}
    @{target_peers}=  Get From Dictionary  ${target_container}  underlay_peers
    run keyword and continue on failure  Initiate Underlay Validation  ${current_peers}  @{target_peers}
Get Underlay Peers
    [Arguments]  ${switch}
    ${cmd}=  Set Variable  show ip bgp summary
    Log  ${cmd}
    ${result}=  run keyword and continue on failure  Enable  ${cmd}
    Log  ${result[0]}
    ${result_dict}=   Get From Dictionary  ${result[0]['result']['vrfs']['default']}  peers
    Log  ${result_dict}
    [Return]  ${result_dict}
Initiate Underlay Validation
    [Arguments]  ${current_peers}    @{target_peers}
    @{established_peers}=  Create List
    Log  ${established_peers}
    :FOR  ${cPeer}  IN  @{current_peers}
    \  Log  ${cPeer}
    \  Log  Peer State is ${current_peers['${cPeer}']['peerState']}
    \  run keyword and continue on failure  Run Keyword If  '${cPeer}' in @{target_peers} and '${current_peers['${cPeer}']['peerState']}'=='Established'  Pass Underlay Test  ${cPeer}
    \  run keyword and continue on failure  Run Keyword If  '${cPeer}' in @{target_peers} and '${current_peers['${cPeer}']['peerState']}'=='Established'  append to list  ${established_peers}  ${cPeer}
    \  ${established_peers_length}=  get length  ${established_peers}
    \  Run Keyword If  ${established_peers_length} != 0  Log  ${established_peers}
    \  run keyword and continue on failure  Run Keyword If  '${cPeer}' not in @{target_peers}  Fail Underlay Test Additional Peer  ${cPeer}
    Log  ${established_peers}
    Log  ${target_peers}
    :FOR  ${listObject}  IN  @{target_peers}
    \  run keyword and continue on failure  Run Keyword If  '${listObject}' not in @{established_peers}  Fail Underlay Test Peer List is Incomplete  ${listObject}
Pass Underlay Test
    [Arguments]  ${peer}
    Log  ${peer} is Established
Fail Underlay Test Additional Peer
    [Arguments]  ${peer}
    fail  Unexpected Peering Present: ${peer}
Fail Underlay Test Peer List is Incomplete
    [Arguments]  ${peer}
    Log  ${peer} Not Adjacent
    fail  Peer List is Incomplete