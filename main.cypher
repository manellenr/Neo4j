/////////////////////////////////////////////////////////////////
////////////////////////// Part 1 /////////////////////////////
/////////////////////////////////////////////////////////////////

CREATE (app:Application {name: "App1"})
CREATE (cnf:CNF {name: "CNF1"})
CREATE (ms1:Microservices {name: "Microservice1"})
CREATE (ms2:Microservices {name: "Microservice2"})
CREATE (ms3:Microservices {name: "Microservice3"})
CREATE (c1:Container {name: "Container1"})
CREATE (c2:Container {name: "Container2"})
CREATE (c3:Container {name: "Container3"})
CREATE (ps1:PhysicalServer {name: "PhysicalServer1"})
CREATE (ps2:PhysicalServer {name: "PhysicalServer2"})
CREATE (leaf1:Leaf {name: "Leaf1"})
CREATE (leaf2:Leaf {name: "Leaf2"})
CREATE (spine:Spine {name: "Spine1"});

MATCH (app:Application {name: "App1"})
MATCH (cnf:CNF {name: "CNF1"})
CREATE (app)-[:CONNECTED_TO]->(cnf);

MATCH (cnf:CNF {name: "CNF1"})
WITH cnf

MATCH (ms1:Microservices {name: "Microservice1"})
CREATE (cnf)-[:CONTAINS]->(ms1)
WITH cnf
MATCH (ms2:Microservices {name: "Microservice2"})
CREATE (cnf)-[:CONTAINS]->(ms2)
WITH cnf
MATCH (ms3:Microservices {name: "Microservice3"})
CREATE (cnf)-[:CONTAINS]->(ms3);

MATCH (ms1:Microservices {name: "Microservice1"})
WITH ms1
MATCH (c1:Container {name: "Container1"})
CREATE (ms1)-[:DEPLOYS]->(c1);

MATCH (ms2:Microservices {name: "Microservice2"})
WITH ms2
MATCH (c2:Container {name: "Container2"})
CREATE (ms2)-[:DEPLOYS]->(c2);

MATCH (ms3:Microservices {name: "Microservice3"})
WITH ms3
MATCH (c3:Container {name: "Container3"})
CREATE (ms3)-[:DEPLOYS]->(c3);

MATCH (c1:Container {name: "Container1"})
WITH c1
MATCH (ps1:PhysicalServer {name: "PhysicalServer1"})
CREATE (c1)-[:HOSTED_ON]->(ps1);

MATCH (c2:Container {name: "Container2"})
WITH c2
MATCH (ps1:PhysicalServer {name: "PhysicalServer1"})
CREATE (c2)-[:HOSTED_ON]->(ps1);

MATCH (c3:Container {name: "Container3"})
WITH c3
MATCH (ps2:PhysicalServer {name: "PhysicalServer2"})
CREATE (c3)-[:HOSTED_ON]->(ps2);

MATCH (ps1:PhysicalServer {name: "PhysicalServer1"})
WITH ps1
MATCH (leaf1:Leaf {name: "Leaf1"})
CREATE (ps1)-[:CONNECTED_TO]->(leaf1);

MATCH (ps2:PhysicalServer {name: "PhysicalServer2"})
WITH ps2
MATCH (leaf2:Leaf {name: "Leaf2"})
CREATE (ps2)-[:CONNECTED_TO]->(leaf2);

MATCH (leaf1:Leaf {name: "Leaf1"})
WITH leaf1
MATCH (spine:Spine {name: "Spine1"})
CREATE (leaf1)-[:LINKS_TO]->(spine);

MATCH (leaf2:Leaf {name: "Leaf2"})
WITH leaf2
MATCH (spine:Spine {name: "Spine1"})
CREATE (leaf2)-[:LINKS_TO]->(spine);

MATCH (n)-[r]->(m)
RETURN n, r, m LIMIT 100;

MATCH (n) DETACH DELETE n;

/////////////////////////////////////////////////////////////////
////////////////////////// Part 2 /////////////////////////////
/////////////////////////////////////////////////////////////////

CREATE (cnf:CNF {name: "UPF"});

CREATE (lbGroup:Microservices {name: "UPF LB"});
CREATE (oamGroup:Microservices {name: "UPF OAM"});
CREATE (mgGroup:Microservices {name: "UPF MG"});

CREATE (ms1:Microservices {name: "UPF LB1"});
CREATE (ms5:Microservices {name: "UPF LB2"});
CREATE (ms7:Microservices {name: "UPF OAM1"});
CREATE (ms8:Microservices {name: "UPF OAM2"});
CREATE (ms2:Microservices {name: "UPF DB"});
CREATE (ms3:Microservices {name: "UPF MG1"});
CREATE (ms4:Microservices {name: "UPF MG2"});
CREATE (ms6:Microservices {name: "UPF MG3"});

CREATE (c1:Container {name: "UPF LB1 POD"});
CREATE (c5:Container {name: "UPF LB2 POD"});
CREATE (c2:Container {name: "UPF DB Proxy"});
CREATE (c7:Container {name: "UPF DB POD"});
CREATE (c3:Container {name: "UPF MG1 POD"});
CREATE (c4:Container {name: "UPF MG2 POD"});
CREATE (c6:Container {name: "UPF MG3 POD"});

CREATE (s4:PhysicalServer {name: "Server4"});
CREATE (s9:PhysicalServer {name: "Server9"});
CREATE (s10:PhysicalServer {name: "Server10"});
CREATE (s11:PhysicalServer {name: "Server11"});
CREATE (s12:PhysicalServer {name: "Server12"});
CREATE (s13:PhysicalServer {name: "Server13"});
CREATE (s16:PhysicalServer {name: "Server16"});
CREATE (s17:PhysicalServer {name: "Server17"});
CREATE (s22:PhysicalServer {name: "Server22"});
CREATE (s23:PhysicalServer {name: "Server23"});
CREATE (s26:PhysicalServer {name: "Server26"});
CREATE (s28:PhysicalServer {name: "Server28"});
CREATE (s14:PhysicalServer {name: "Server14"});
CREATE (s15:PhysicalServer {name: "Server15"});
CREATE (s24:PhysicalServer {name: "Server24"});
CREATE (s25:PhysicalServer {name: "Server25"});

MATCH (cnf:CNF {name: "UPF"}), (lbGroup:Microservices {name: "UPF LB"})
CREATE (cnf)-[:CONTAINS]->(lbGroup);
MATCH (cnf:CNF {name: "UPF"}), (oamGroup:Microservices {name: "UPF OAM"})
CREATE (cnf)-[:CONTAINS]->(oamGroup);
MATCH (cnf:CNF {name: "UPF"}), (ms2:Microservices {name: "UPF DB"})
CREATE (cnf)-[:CONTAINS]->(ms2);
MATCH (cnf:CNF {name: "UPF"}), (mgGroup:Microservices {name: "UPF MG"})
CREATE (cnf)-[:CONTAINS]->(mgGroup);

MATCH (lbGroup:Microservices {name: "UPF LB"})
MATCH (ms1:Microservices {name: "UPF LB1"})
MATCH (ms5:Microservices {name: "UPF LB2"})
CREATE (lbGroup)-[:CONTAINS]->(ms1),
       (lbGroup)-[:CONTAINS]->(ms5);

MATCH (oamGroup:Microservices {name: "UPF OAM"})
MATCH (ms7:Microservices {name: "UPF OAM1"})
MATCH (ms8:Microservices {name: "UPF OAM2"})
CREATE (oamGroup)-[:CONTAINS]->(ms7),
       (oamGroup)-[:CONTAINS]->(ms8);

MATCH (mgGroup:Microservices {name: "UPF MG"})
MATCH (ms3:Microservices {name: "UPF MG1"})
MATCH (ms4:Microservices {name: "UPF MG2"})
MATCH (ms6:Microservices {name: "UPF MG3"})
CREATE (mgGroup)-[:CONTAINS]->(ms3),
       (mgGroup)-[:CONTAINS]->(ms4),
       (mgGroup)-[:CONTAINS]->(ms6);

MATCH (ms1:Microservices {name: "UPF LB1"}), (c1:Container {name: "UPF LB1 POD"})
CREATE (ms1)-[:DEPLOYS]->(c1);
MATCH (ms5:Microservices {name: "UPF LB2"}), (c5:Container {name: "UPF LB2 POD"})
CREATE (ms5)-[:DEPLOYS]->(c5);
MATCH (ms2:Microservices {name: "UPF DB"}), (c2:Container {name: "UPF DB Proxy"}), (c7:Container {name: "UPF DB POD"})
CREATE (ms2)-[:DEPLOYS]->(c2),
       (ms2)-[:DEPLOYS]->(c7);
MATCH (ms3:Microservices {name: "UPF MG1"}), (c3:Container {name: "UPF MG1 POD"})
CREATE (ms3)-[:DEPLOYS]->(c3);
MATCH (ms4:Microservices {name: "UPF MG2"}), (c4:Container {name: "UPF MG2 POD"})
CREATE (ms4)-[:DEPLOYS]->(c4);
MATCH (ms6:Microservices {name: "UPF MG3"}), (c6:Container {name: "UPF MG3 POD"})
CREATE (ms6)-[:DEPLOYS]->(c6);

MATCH (c1:Container {name: "UPF LB1 POD"}), (s4:PhysicalServer {name: "Server4"})
CREATE (c1)-[:HOSTED_ON]->(s4);
MATCH (c1:Container {name: "UPF LB1 POD"}), (s11:PhysicalServer {name: "Server11"})
CREATE (c1)-[:HOSTED_ON]->(s11);
MATCH (c2:Container {name: "UPF DB Proxy"}), (s9:PhysicalServer {name: "Server9"}), (s10:PhysicalServer {name: "Server10"})
CREATE (c2)-[:HOSTED_ON]->(s9),You have exceeded the logical size limit of 400000 relationships in your database (attempt to add 332750 relationships would reach 665504 relationships). Please consider upgrading to the next tier.
       (c2)-[:HOSTED_ON]->(s10);
MATCH (c7:Container {name: "UPF DB POD"}), (s9:PhysicalServer {name: "Server9"}), (s10:PhysicalServer {name: "Server10"})
CREATE (c7)-[:HOSTED_ON]->(s9),
       (c7)-[:HOSTED_ON]->(s10);
MATCH (c3:Container {name: "UPF MG1 POD"}), (s12:PhysicalServer {name: "Server12"}), (s22:PhysicalServer {name: "Server22"})
CREATE (c3)-[:HOSTED_ON]->(s12),
       (c3)-[:HOSTED_ON]->(s22);
MATCH (c4:Container {name: "UPF MG2 POD"}), (s13:PhysicalServer {name: "Server13"}), (s23:PhysicalServer {name: "Server23"})
CREATE (c4)-[:HOSTED_ON]->(s13),
       (c4)-[:HOSTED_ON]->(s23);
MATCH (c5:Container {name: "UPF LB2 POD"}), (s16:PhysicalServer {name: "Server16"}), (s26:PhysicalServer {name: "Server26"})
CREATE (c5)-[:HOSTED_ON]->(s16),
       (c5)-[:HOSTED_ON]->(s26);
MATCH (c6:Container {name: "UPF MG3 POD"}), (s17:PhysicalServer {name: "Server17"}), (s28:PhysicalServer {name: "Server28"})
CREATE (c6)-[:HOSTED_ON]->(s17),
       (c6)-[:HOSTED_ON]->(s28);

MATCH (ms7:Microservices {name: "UPF OAM1"}), (s14:PhysicalServer {name: "Server14"}), (s24:PhysicalServer {name: "Server24"})
CREATE (ms7)-[:DEPLOYED_ON]->(s14),
       (ms7)-[:DEPLOYED_ON]->(s24);
MATCH (ms8:Microservices {name: "UPF OAM2"}), (s15:PhysicalServer {name: "Server15"}), (s25:PhysicalServer {name: "Server25"})
CREATE (ms8)-[:DEPLOYED_ON]->(s15),
       (ms8)-[:DEPLOYED_ON]->(s25);

MATCH (n)-[r]->(m)
RETURN n, r, m LIMIT 100;

MATCH (n) DETACH DELETE n;

/////////////////////////////////////////////////////////////////
////////////////////////// Part 3 /////////////////////////////
/////////////////////////////////////////////////////////////////

CREATE (cnf2:CNF {name: "SMF"});

CREATE (smf_lb:Microservices {name: "SMF LB"});
CREATE (smf_oam:Microservices {name: "SMF OAM"});
CREATE (smf_mg:Microservices {name: "SMF MG"});
CREATE (smf_db:Microservices {name: "SMF DB"});

CREATE (smf_mg1:Microservices {name: "SMF MG1"});
CREATE (smf_mg2:Microservices {name: "SMF MG2"});
CREATE (smf_mg3:Microservices {name: "SMF MG3"});
CREATE (smf_oam1:Microservices {name: "SMF OAM1"});
CREATE (smf_oam2:Microservices {name: "SMF OAM2"});
CREATE (smf_lb1:Microservices {name: "SMF LB1"});
CREATE (smf_lb2:Microservices {name: "SMF LB2"});

CREATE (smf_mg1_pod:Container {name: "SMF MG1 POD"});
CREATE (smf_mg2_pod:Container {name: "SMF MG2 POD"});
CREATE (smf_mg3_pod:Container {name: "SMF MG3 POD"});
CREATE (smf_db_proxy:Container {name: "SMF DB Proxy"});
CREATE (smf_oam1_proxy:Container {name: "SMF OAM1 Proxy"});
CREATE (smf_oam2_proxy:Container {name: "SMF OAM2 Proxy"});
CREATE (smf_lb1_pod:Container {name: "SMF LB1 POD"});
CREATE (smf_lb2_pod:Container {name: "SMF LB2 POD"});

CREATE (s4:PhysicalServer {name: "Server4"});
CREATE (s9:PhysicalServer {name: "Server9"});
CREATE (s10:PhysicalServer {name: "Server10"});
CREATE (s11:PhysicalServer {name: "Server11"});
CREATE (s12:PhysicalServer {name: "Server12"});
CREATE (s13:PhysicalServer {name: "Server13"});
CREATE (s14:PhysicalServer {name: "Server14"});
CREATE (s15:PhysicalServer {name: "Server15"});
CREATE (s16:PhysicalServer {name: "Server16"});
CREATE (s17:PhysicalServer {name: "Server17"});
CREATE (s22:PhysicalServer {name: "Server22"});
CREATE (s23:PhysicalServer {name: "Server23"});
CREATE (s24:PhysicalServer {name: "Server24"});
CREATE (s25:PhysicalServer {name: "Server25"});
CREATE (s26:PhysicalServer {name: "Server26"});
CREATE (s28:PhysicalServer {name: "Server28"});

MATCH (cnf:CNF {name: "SMF"}), 
      (oamGroup:Microservices {name: "SMF OAM"}), 
      (mgGroup:Microservices {name: "SMF MG"}), 
      (dbGroup:Microservices {name: "SMF DB"}), 
      (lbGroup:Microservices {name: "SMF LB"})
CREATE (cnf)-[:CONTAINS]->(oamGroup),
       (cnf)-[:CONTAINS]->(mgGroup),
       (cnf)-[:CONTAINS]->(dbGroup),
       (cnf)-[:CONTAINS]->(lbGroup);
       
MATCH (mgGroup:Microservices {name: "SMF MG"}), 
      (ms1:Microservices {name: "SMF MG1"}), 
      (ms2:Microservices {name: "SMF MG2"}), 
      (ms3:Microservices {name: "SMF MG3"})
CREATE (mgGroup)-[:CONTAINS]->(ms1),
       (mgGroup)-[:CONTAINS]->(ms2),
       (mgGroup)-[:CONTAINS]->(ms3);

MATCH (dbGroup:Microservices {name: "SMF DB"}), 
      (ms:Container {name: "SMF DB Proxy"})
CREATE (dbGroup)-[:CONTAINS]->(ms);

MATCH (oamGroup:Microservices {name: "SMF OAM"}), 
      (ms1:Microservices {name: "SMF OAM1"}), 
      (ms2:Microservices {name: "SMF OAM2"})
CREATE (oamGroup)-[:CONTAINS]->(ms1),
       (oamGroup)-[:CONTAINS]->(ms2);

MATCH (lbGroup:Microservices {name: "SMF LB"}), 
      (ms1:Microservices {name: "SMF LB1"}), 
      (ms2:Microservices {name: "SMF LB2"})
CREATE (lbGroup)-[:CONTAINS]->(ms1),
       (lbGroup)-[:CONTAINS]->(ms2);
            
CREATE (smf_db_pod:Container {name: "SMF DB POD"});

MATCH (pod1:Container {name: "SMF MG1 POD"}), (ms1:Microservices {name: "SMF MG1"})
CREATE (ms1)-[:HOSTS]->(pod1);

MATCH (pod2:Container {name: "SMF MG2 POD"}), (ms2:Microservices {name: "SMF MG2"})
CREATE (ms2)-[:HOSTS]->(pod2);

MATCH (pod3:Container {name: "SMF MG3 POD"}), (ms3:Microservices {name: "SMF MG3"})
CREATE (ms3)-[:HOSTS]->(pod3);

MATCH (pod4:Container {name: "SMF DB POD"}), (db:Microservices {name: "SMF DB"})
CREATE (db)-[:HOSTS]->(pod4);

MATCH (pod5:Container {name: "SMF LB1 POD"}), (ms4:Microservices {name: "SMF LB1"})
CREATE (ms4)-[:HOSTS]->(pod5);

MATCH (pod6:Container {name: "SMF LB2 POD"}), (ms5:Microservices {name: "SMF LB2"})
CREATE (ms5)-[:HOSTS]->(pod6);
       
MATCH (pod:Container {name: "SMF MG1 POD"}), (s1:PhysicalServer {name: "Server4"}), (s2:PhysicalServer {name: "Server11"})
CREATE (pod)-[:DEPLOYED_ON]->(s1),
       (pod)-[:DEPLOYED_ON]->(s2);

MATCH (pod:Container {name: "SMF MG2 POD"}), (s1:PhysicalServer {name: "Server16"}), (s2:PhysicalServer {name: "Server26"})
CREATE (pod)-[:DEPLOYED_ON]->(s1),
       (pod)-[:DEPLOYED_ON]->(s2);

MATCH (pod:Container {name: "SMF MG3 POD"}), (s1:PhysicalServer {name: "Server17"}), (s2:PhysicalServer {name: "Server28"})
CREATE (pod)-[:DEPLOYED_ON]->(s1),
       (pod)-[:DEPLOYED_ON]->(s2);

MATCH (pod:Container {name: "SMF DB Proxy"}), (s1:PhysicalServer {name: "Server9"}), (s2:PhysicalServer {name: "Server10"})
CREATE (pod)-[:DEPLOYED_ON]->(s1),
       (pod)-[:DEPLOYED_ON]->(s2);

MATCH (ms:Microservices {name: "SMF OAM1"}), (s1:PhysicalServer {name: "Server12"}), (s2:PhysicalServer {name: "Server22"})
CREATE (ms)-[:DEPLOYED_ON]->(s1),
       (ms)-[:DEPLOYED_ON]->(s2);

MATCH (ms:Microservices {name: "SMF OAM2"}), (s1:PhysicalServer {name: "Server13"}), (s2:PhysicalServer {name: "Server23"})
CREATE (ms)-[:DEPLOYED_ON]->(s1),
       (ms)-[:DEPLOYED_ON]->(s2);

MATCH (pod:Container {name: "SMF LB1 POD"}), (s1:PhysicalServer {name: "Server14"}), (s2:PhysicalServer {name: "Server24"})
CREATE (pod)-[:DEPLOYED_ON]->(s1),
       (pod)-[:DEPLOYED_ON]->(s2);

MATCH (pod:Container {name: "SMF LB2 POD"}), (s1:PhysicalServer {name: "Server15"}), (s2:PhysicalServer {name: "Server25"})
CREATE (pod)-[:DEPLOYED_ON]->(s1),
       (pod)-[:DEPLOYED_ON]->(s2);

MATCH (pod:Container {name: "SMF DB POD"}), (s1:PhysicalServer {name: "Server15"}), (s2:PhysicalServer {name: "Server25"})
CREATE (pod)-[:DEPLOYED_ON]->(s1),
       (pod)-[:DEPLOYED_ON]->(s2);

MATCH (n)-[r]->(m)
RETURN n, r, m LIMIT 100;

MATCH (n) DETACH DELETE n;

/////////////////////////////////////////////////////////////////
////////////////////////// Part 4 /////////////////////////////
/////////////////////////////////////////////////////////////////

CREATE (cnf1:CNF {name: "UPF"});
CREATE (cnf2:CNF {name: "SMF"});

CREATE (lbGroup:Microservices {name: "UPF LB"});
CREATE (oamGroup:Microservices {name: "UPF OAM"});
CREATE (mgGroup:Microservices {name: "UPF MG"});
CREATE (ms1:Microservices {name: "UPF LB1"});
CREATE (ms5:Microservices {name: "UPF LB2"});
CREATE (ms7:Microservices {name: "UPF OAM1"});
CREATE (ms8:Microservices {name: "UPF OAM2"});
CREATE (ms2:Microservices {name: "UPF DB"});
CREATE (ms3:Microservices {name: "UPF MG1"});
CREATE (ms4:Microservices {name: "UPF MG2"});
CREATE (ms6:Microservices {name: "UPF MG3"});

CREATE (c1:Container {name: "UPF LB1 POD"});
CREATE (c5:Container {name: "UPF LB2 POD"});
CREATE (c2:Container {name: "UPF DB Proxy"});
CREATE (c7:Container {name: "UPF DB POD"});
CREATE (c3:Container {name: "UPF MG1 POD"});
CREATE (c4:Container {name: "UPF MG2 POD"});
CREATE (c6:Container {name: "UPF MG3 POD"});

CREATE (smf_lb:Microservices {name: "SMF LB"});
CREATE (smf_oam:Microservices {name: "SMF OAM"});
CREATE (smf_mg:Microservices {name: "SMF MG"});
CREATE (smf_db:Microservices {name: "SMF DB"});

CREATE (smf_mg1:Microservices {name: "SMF MG1"});
CREATE (smf_mg2:Microservices {name: "SMF MG2"});
CREATE (smf_mg3:Microservices {name: "SMF MG3"});
CREATE (smf_oam1:Microservices {name: "SMF OAM1"});
CREATE (smf_oam2:Microservices {name: "SMF OAM2"});
CREATE (smf_lb1:Microservices {name: "SMF LB1"});
CREATE (smf_lb2:Microservices {name: "SMF LB2"});

CREATE (smf_mg1_pod:Container {name: "SMF MG1 POD"});
CREATE (smf_mg2_pod:Container {name: "SMF MG2 POD"});
CREATE (smf_mg3_pod:Container {name: "SMF MG3 POD"});
CREATE (smf_db_proxy:Container {name: "SMF DB Proxy"});
CREATE (smf_oam1_proxy:Container {name: "SMF OAM1 Proxy"});
CREATE (smf_oam2_proxy:Container {name: "SMF OAM2 Proxy"});
CREATE (smf_lb1_pod:Container {name: "SMF LB1 POD"});
CREATE (smf_lb2_pod:Container {name: "SMF LB2 POD"});

CREATE (s4:PhysicalServer {name: "Server4"});
CREATE (s9:PhysicalServer {name: "Server9"});
CREATE (s10:PhysicalServer {name: "Server10"});
CREATE (s11:PhysicalServer {name: "Server11"});
CREATE (s12:PhysicalServer {name: "Server12"});
CREATE (s13:PhysicalServer {name: "Server13"});
CREATE (s14:PhysicalServer {name: "Server14"});
CREATE (s15:PhysicalServer {name: "Server15"});
CREATE (s16:PhysicalServer {name: "Server16"});
CREATE (s17:PhysicalServer {name: "Server17"});
CREATE (s22:PhysicalServer {name: "Server22"});
CREATE (s23:PhysicalServer {name: "Server23"});
CREATE (s24:PhysicalServer {name: "Server24"});
CREATE (s25:PhysicalServer {name: "Server25"});
CREATE (s26:PhysicalServer {name: "Server26"});
CREATE (s28:PhysicalServer {name: "Server28"});

MATCH (cnf1:CNF {name: "UPF"})
MATCH (lbGroup:Microservices {name: "UPF LB"}), (oamGroup:Microservices {name: "UPF OAM"}), (mgGroup:Microservices {name: "UPF MG"}), (ms2:Microservices {name: "UPF DB"})
CREATE (cnf1)-[:CONTAINS]->(lbGroup),
       (cnf1)-[:CONTAINS]->(oamGroup),
       (cnf1)-[:CONTAINS]->(mgGroup),
       (cnf1)-[:CONTAINS]->(ms2);

MATCH (lbGroup), (ms1), (ms5)
CREATE (lbGroup)-[:CONTAINS]->(ms1),
       (lbGroup)-[:CONTAINS]->(ms5);

MATCH (oamGroup), (ms7), (ms8)
CREATE (oamGroup)-[:CONTAINS]->(ms7),
       (oamGroup)-[:CONTAINS]->(ms8);

MATCH (mgGroup), (ms3), (ms4), (ms6)
CREATE (mgGroup)-[:CONTAINS]->(ms3),
       (mgGroup)-[:CONTAINS]->(ms4),
       (mgGroup)-[:CONTAINS]->(ms6);

MATCH (ms1), (c1), (ms5), (c5), (ms2), (c2), (c7), (ms3), (c3), (ms4), (c4), (ms6), (c6)
CREATE (ms1)-[:DEPLOYS]->(c1),
       (ms5)-[:DEPLOYS]->(c5),
       (ms2)-[:DEPLOYS]->(c2),
       (ms2)-[:DEPLOYS]->(c7),
       (ms3)-[:DEPLOYS]->(c3),
       (ms4)-[:DEPLOYS]->(c4),
       (ms6)-[:DEPLOYS]->(c6);

MATCH (c1), (s4), (s11)
CREATE (c1)-[:HOSTED_ON]->(s4),
       (c1)-[:HOSTED_ON]->(s11);
MATCH (c2), (c7), (s9), (s10)
CREATE (c2)-[:HOSTED_ON]->(s9),
       (c2)-[:HOSTED_ON]->(s10),
       (c7)-[:HOSTED_ON]->(s9),
       (c7)-[:HOSTED_ON]->(s10);
MATCH (c3), (s12), (s22)
CREATE (c3)-[:HOSTED_ON]->(s12),
       (c3)-[:HOSTED_ON]->(s22);
MATCH (c4), (s13), (s23)
CREATE (c4)-[:HOSTED_ON]->(s13),
       (c4)-[:HOSTED_ON]->(s23);
MATCH (c5), (s16), (s26)
CREATE (c5)-[:HOSTED_ON]->(s16),
       (c5)-[:HOSTED_ON]->(s26);
MATCH (c6), (s17), (s28)
CREATE (c6)-[:HOSTED_ON]->(s17),
       (c6)-[:HOSTED_ON]->(s28);

MATCH (ms7), (s14), (s24)
CREATE (ms7)-[:DEPLOYED_ON]->(s14),
       (ms7)-[:DEPLOYED_ON]->(s24);
MATCH (ms8), (s15), (s25)
CREATE (ms8)-[:DEPLOYED_ON]->(s15),
       (ms8)-[:DEPLOYED_ON]->(s25);

MATCH (cnf2:CNF {name: "SMF"})
MATCH (smf_lb), (smf_oam), (smf_mg), (smf_db)
CREATE (cnf2)-[:CONTAINS]->(smf_lb),
       (cnf2)-[:CONTAINS]->(smf_oam),
       (cnf2)-[:CONTAINS]->(smf_mg),
       (cnf2)-[:CONTAINS]->(smf_db);

MATCH (smf_mg), (smf_mg1), (smf_mg2), (smf_mg3)
CREATE (smf_mg)-[:CONTAINS]->(smf_mg1),
       (smf_mg)-[:CONTAINS]->(smf_mg2),
       (smf_mg)-[:CONTAINS]->(smf_mg3);

MATCH (smf_mg1), (smf_mg1_pod)
CREATE (smf_mg1)-[:DEPLOYS]->(smf_mg1_pod);
MATCH (smf_mg1_pod), (s4), (s11)
CREATE (smf_mg1_pod)-[:HOSTED_ON]->(s4),
       (smf_mg1_pod)-[:HOSTED_ON]->(s11);

MATCH (smf_mg2), (smf_mg2_pod)
CREATE (smf_mg2)-[:DEPLOYS]->(smf_mg2_pod);
MATCH (smf_mg2_pod), (s16), (s26)
CREATE (smf_mg2_pod)-[:HOSTED_ON]->(s16),
       (smf_mg2_pod)-[:HOSTED_ON]->(s26);

MATCH (smf_mg3), (smf_mg3_pod)
CREATE (smf_mg3)-[:DEPLOYS]->(smf_mg3_pod);
MATCH (smf_mg3_pod), (s17), (s28)
CREATE (smf_mg3_pod)-[:HOSTED_ON]->(s17),
       (smf_mg3_pod)-[:HOSTED_ON]->(s28);

MATCH (smf_db), (smf_db_proxy)
CREATE (smf_db)-[:DEPLOYS]->(smf_db_proxy);
MATCH (smf_db_proxy), (s9), (s10)
CREATE (smf_db_proxy)-[:HOSTED_ON]->(s9),
       (smf_db_proxy)-[:HOSTED_ON]->(s10);

MATCH (smf_oam), (smf_oam1), (smf_oam2)
CREATE (smf_oam)-[:CONTAINS]->(smf_oam1),
       (smf_oam)-[:CONTAINS]->(smf_oam2);
MATCH (smf_oam1), (smf_oam1_proxy)
CREATE (smf_oam1)-[:DEPLOYS]->(smf_oam1_proxy);
MATCH (smf_oam1_proxy), (s12), (s22)
CREATE (smf_oam1_proxy)-[:HOSTED_ON]->(s12),
       (smf_oam1_proxy)-[:HOSTED_ON]->(s22);
MATCH (smf_oam2), (smf_oam2_proxy)
CREATE (smf_oam2)-[:DEPLOYS]->(smf_oam2_proxy);
MATCH (smf_oam2_proxy), (s13), (s23)
CREATE (smf_oam2_proxy)-[:HOSTED_ON]->(s13),
       (smf_oam2_proxy)-[:HOSTED_ON]->(s23);

MATCH (smf_lb), (smf_lb1), (smf_lb2)
CREATE (smf_lb)-[:CONTAINS]->(smf_lb1),
       (smf_lb)-[:CONTAINS]->(smf_lb2);
MATCH (smf_lb1), (smf_lb1_pod)
CREATE (smf_lb1)-[:DEPLOYS]->(smf_lb1_pod);
MATCH (smf_lb1_pod), (s14), (s24)
CREATE (smf_lb1_pod)-[:HOSTED_ON]->(s14),
       (smf_lb1_pod)-[:HOSTED_ON]->(s24);
MATCH (smf_lb2), (smf_lb2_pod)
CREATE (smf_lb2)-[:DEPLOYS]->(smf_lb2_pod);
MATCH (smf_lb2_pod), (s15), (s25)
CREATE (smf_lb2_pod)-[:HOSTED_ON]->(s15),
       (smf_lb2_pod)-[:HOSTED_ON]->(s25);

MATCH (n)-[r]->(m)
RETURN n, r, m LIMIT 100;

MATCH (n) DETACH DELETE n;
