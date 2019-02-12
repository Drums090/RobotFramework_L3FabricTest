underlay = 'BGP'
loopback_ping_leafs = ['1.1.1.101', '1.1.1.102', '1.1.1.201', '1.1.1.202', '1.1.1.203', '1.1.1.204', '2.2.2.1', '2.2.2.2']
loopback_ping_spines = ['1.1.1.201', '1.1.1.202', '1.1.1.203', '1.1.1.204', '2.2.2.1', '2.2.2.2']
spines = { 'DCA-Spine1': {
                'management_ip': '10.255.255.101',
                'loopback': '1.1.1.101',
                'p2p_ping': ['10.101.201.1', '10.101.202.1', '10.101.203.1', '10.101.204.1'],
                'ospf_neighbors': ['1.1.1.201', '1.1.1.202', '1.1.1.203', '1.1.1.204'],
                'evpn_peers': ['1.1.1.201', '1.1.1.202', '1.1.1.203', '1.1.1.204'],
                'underlay_peers': ['10.101.201.1', '10.101.202.1', '10.101.203.1', '10.101.204.1']

                         },
           'DCA-Spine2': {
                'management_ip': '10.255.255.102',
                'loopback': '1.1.1.102',
                'p2p_ping': ['10.102.201.1', '10.102.202.1', '10.102.203.1', '10.102.204.1'],
                'ospf_neighbors': ['1.1.1.201', '1.1.1.202', '1.1.1.203', '1.1.1.204'],
                'evpn_peers': ['1.1.1.201', '1.1.1.202', '1.1.1.203', '1.1.1.204'],
                'underlay_peers': ['10.102.201.1', '10.102.202.1', '10.102.203.1', '10.102.204.1']
                         }
         }

leafs = {  'DCA-Leaf1': {
                'management_ip': '10.255.255.201',
                'loopback': '1.1.1.201',
                'ospf_neighbors': ['1.1.1.101', '1.1.1.102', '1.1.1.202'],
                'evpn_peers': ['1.1.1.101', '1.1.1.102'],
                'underlay_peers': ['10.101.201.0', '10.102.201.0', '192.168.255.255']
                         },
           'DCA-Leaf2': {
                'management_ip': '10.255.255.202',
                'loopback': '1.1.1.202',
                'ospf_neighbors': ['1.1.1.101', '1.1.1.102', '1.1.1.201'],
                'evpn_peers': ['1.1.1.101', '1.1.1.102'],
                'underlay_peers': ['10.101.202.0', '10.102.202.0', '192.168.255.254']
                         },
           'DCA-BL1': {
                'management_ip': '10.255.255.203',
                'loopback': '1.1.1.203',
                'ospf_neighbors': ['1.1.1.101', '1.1.1.102', '1.1.1.204'],
                'evpn_peers': ['1.1.1.101', '1.1.1.102'],
                'underlay_peers': ['10.101.203.0', '10.102.203.0', '192.168.255.255']
                         },
           'DCA-BL2': {
                'management_ip': '10.255.255.204',
                'loopback': '1.1.1.204',
                'ospf_neighbors': ['1.1.1.101', '1.1.1.102', '1.1.1.203'],
                'evpn_peers': ['1.1.1.101', '1.1.1.102'],
                'underlay_peers': ['10.101.204.0', '10.102.204.0', '192.168.255.254']
                         }
         }