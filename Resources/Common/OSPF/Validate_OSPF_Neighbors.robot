*** Settings ***
Library  AristaLibrary
Library  AristaLibrary.Expect
Library  Collections


*** Keywords ***
Validate OSPF Neighbors
    [Documentation]  Validating OSPF Neighbors on Switches
    [Arguments]  ${target_container}  ${switch}
    ${current_neighbors}=  Get Neighbors  ${switch}
    Log  ${current_neighbors}
    @{target_neighbors}=  Get From Dictionary  ${target_container}  ospf_neighbors
    run keyword and continue on failure  Initiate OSPF Validation  ${current_neighbors}  @{target_neighbors}
Get Neighbors
    [Arguments]  ${switch}
    ${cmd}=  Set Variable  show ip ospf neighbor
    Log  ${cmd}
    ${result}=  run keyword and continue on failure  Enable  ${cmd}
    Log  ${result[0]}
    ${result_dict}=   Get From Dictionary  ${result[0]['result']['vrfs']['default']['instList']['1']}  ospfNeighborEntries
    Log  ${result_dict}
    [Return]  ${result_dict}
Initiate OSPF Validation
    [Arguments]  ${current_neighbors}    @{target_neighbors}
    @{established_neighbors}=  Create List
    Log  ${established_neighbors}
    :FOR  ${cNeighbor}  IN  @{current_neighbors}
    \  Log  ${cNeighbor}
    \  run keyword and continue on failure  Run Keyword If  '${cNeighbor['routerId']}' in @{target_neighbors} and '${cNeighbor['adjacencyState']}'=='full'  Pass OSPF Test  ${cNeighbor['routerId']}
    \  run keyword and continue on failure  Run Keyword If  '${cNeighbor['routerId']}' in @{target_neighbors} and '${cNeighbor['adjacencyState']}'=='full'  append to list  ${established_neighbors}  ${cNeighbor['routerId']}
    \  ${established_neighbors_length}=  get length  ${established_neighbors}
    \  Run Keyword If  ${established_neighbors_length} != 0  Log  ${established_neighbors}
    \  run keyword and continue on failure  Run Keyword If  '${cNeighbor['routerId']}' not in @{target_neighbors}  Fail Test Additional Neighbor  ${cNeighbor['routerId']}
    Log  ${established_neighbors}
    Log  ${target_neighbors}
    :FOR  ${listObject}  IN  @{target_neighbors}
    \  run keyword and continue on failure  Run Keyword If  '${listObject}' not in @{established_neighbors}  Fail Test Neighbor List is Incomplete  ${listObject}
Neighbor List is Complete
    Log  Neighbor List is Complete
Pass OSPF Test
    [Arguments]  ${neighbor}
    Log  ${neighbor} adjacency is FULL
Fail Test Additional Neighbor
    [Arguments]  ${neighbor}
    fail  Unexpected Neighbor Present: ${neighbor}
Fail Test Neighbor List is Incomplete
    [Arguments]  ${neighbor}
    Log  ${neighbor} Not Adjacent
    fail  Neighbor List is Incomplete