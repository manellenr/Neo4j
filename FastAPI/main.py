from fastapi import FastAPI
from models import GraphContainer

app = FastAPI()


@app.post("/upload-graph/")
async def upload_graph(graph_data: GraphContainer):
    # Ici, tu peux traiter, stocker ou renvoyer les données
    return {
        "message": "Graph received successfully",
        "iri": graph_data._iri,
        "nodes_count": len(next(iter(graph_data.additionalProp1.values()))._nodes),
        "relationships_count": len(next(iter(graph_data.additionalProp1.values()))._relationships)
    }
