*** Settings ***
Library  AristaLibrary
Library  AristaLibrary.Expect
Library  Collections


*** Keywords ***
Validate EVPN Peerings
    [Documentation]  Validating EVPN Peerings on Switches
    [Arguments]  ${target_container}  ${switch}
    ${current_peers}=  Get Peers  ${switch}
    Log  ${current_peers}
    @{target_peers}=  Get From Dictionary  ${target_container}  evpn_peers
    run keyword and continue on failure  Initiate EVPN Validation  ${current_peers}  @{target_peers}
Get Peers
    [Arguments]  ${switch}
    ${cmd}=  Set Variable  show bgp evpn summary
    Log  ${cmd}
    ${result}=  run keyword and continue on failure  Enable  ${cmd}
    Log  ${result[0]}
    ${result_dict}=   Get From Dictionary  ${result[0]['result']}  peers
    Log  ${result_dict}
    [Return]  ${result_dict}
Initiate EVPN Validation
    [Arguments]  ${current_peers}    @{target_peers}
    @{established_peers}=  Create List
    Log  ${established_peers}
    :FOR  ${cPeer}  IN  @{current_peers}
    \  Log  ${cPeer}
    \  Log  Peer State is ${current_peers['${cPeer}']['peerState']}
    \  run keyword and continue on failure  Run Keyword If  '${cPeer}' in @{target_peers} and '${current_peers['${cPeer}']['peerState']}'=='Established'  Pass EVPN Test  ${cPeer}
    \  run keyword and continue on failure  Run Keyword If  '${cPeer}' in @{target_peers} and '${current_peers['${cPeer}']['peerState']}'=='Established'  append to list  ${established_peers}  ${cPeer}
    \  ${established_peers_length}=  get length  ${established_peers}
    \  Run Keyword If  ${established_peers_length} != 0  Log  ${established_peers}
    \  run keyword and continue on failure  Run Keyword If  '${cPeer}' not in @{target_peers}  Fail Test Additional Peer  ${cPeer}
    Log  ${established_peers}
    Log  ${target_peers}
    :FOR  ${listObject}  IN  @{target_peers}
    \  run keyword and continue on failure  Run Keyword If  '${listObject}' not in @{established_peers}  Fail Test Peer List is Incomplete  ${listObject}
Peer List is Complete
    Log  Peer List is Complete
Pass EVPN Test
    [Arguments]  ${peer}
    Log  ${peer} is Established
Fail Test Additional Peer
    [Arguments]  ${peer}
    fail  Unexpected Peering Present: ${peer}
Fail Test Peer List is Incomplete
    [Arguments]  ${peer}
    Log  ${peer} Not Adjacent
    fail  Peer List is Incomplete