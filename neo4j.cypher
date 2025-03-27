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

// Cas d'usage réel

