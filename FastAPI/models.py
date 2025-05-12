from typing import List, Dict, Optional
from pydantic import BaseModel


class Node(BaseModel):
    id: str
    label: str
    properties: Dict[str, str]


class Relationship(BaseModel):
    from_: str 
    to: str
    type: str

    class Config:
        fields = {
            'from_': 'from' 
        }


class Graph(BaseModel):
    _nodes: List[Node]
    _relationships: List[Relationship]


class GraphContainer(BaseModel):
    _iri: str
    additionalProp1: Dict[str, Graph]
