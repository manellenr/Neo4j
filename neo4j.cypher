// Partie 1
// Création des nœuds 
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

// Création des relations
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

// Affichage des nœuds et leurs relations
MATCH (n)-[r]->(m)
RETURN n, r, m LIMIT 100;

// Suppression
MATCH (n) DETACH DELETE n;

// Partie 2
// Cas d'usage réel

// Création des nœuds
CREATE (cnf:CNF {name: "UPF"});

// Création des niveaux intermédiaires
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
CREATE (c7:Container {name: "UPF DB POD"}); // nouveau conteneur
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

// Création des relations
MATCH (cnf:CNF {name: "UPF"}), (lbGroup:Microservices {name: "UPF LB"})
CREATE (cnf)-[:CONTAINS]->(lbGroup);
MATCH (cnf:CNF {name: "UPF"}), (oamGroup:Microservices {name: "UPF OAM"})
CREATE (cnf)-[:CONTAINS]->(oamGroup);
MATCH (cnf:CNF {name: "UPF"}), (ms2:Microservices {name: "UPF DB"})
CREATE (cnf)-[:CONTAINS]->(ms2);
MATCH (cnf:CNF {name: "UPF"}), (mgGroup:Microservices {name: "UPF MG"})
CREATE (cnf)-[:CONTAINS]->(mgGroup);

// Relier les sous-niveaux
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

// Déploiement des microservices dans des conteneurs
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

// Hébergement des conteneurs sur les serveurs
MATCH (c1:Container {name: "UPF LB1 POD"}), (s4:PhysicalServer {name: "Server4"})
CREATE (c1)-[:HOSTED_ON]->(s4);
MATCH (c1:Container {name: "UPF LB1 POD"}), (s11:PhysicalServer {name: "Server11"})
CREATE (c1)-[:HOSTED_ON]->(s11);
MATCH (c2:Container {name: "UPF DB Proxy"}), (s9:PhysicalServer {name: "Server9"}), (s10:PhysicalServer {name: "Server10"})
CREATE (c2)-[:HOSTED_ON]->(s9),
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

// Déploiement direct des microservices OAM sur des serveurs
MATCH (ms7:Microservices {name: "UPF OAM1"}), (s14:PhysicalServer {name: "Server14"}), (s24:PhysicalServer {name: "Server24"})
CREATE (ms7)-[:DEPLOYED_ON]->(s14),
       (ms7)-[:DEPLOYED_ON]->(s24);
MATCH (ms8:Microservices {name: "UPF OAM2"}), (s15:PhysicalServer {name: "Server15"}), (s25:PhysicalServer {name: "Server25"})
CREATE (ms8)-[:DEPLOYED_ON]->(s15),
       (ms8)-[:DEPLOYED_ON]->(s25);

// Affichage des nœuds et leurs relations
MATCH (n)-[r]->(m)
RETURN n, r, m LIMIT 100;

// Suppression
MATCH (n) DETACH DELETE n;
