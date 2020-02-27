-- Get all neighbors of the current vertex
let List/map =
      https://prelude.dhall-lang.org/v14.0.0/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let Graph = ./Graph.dhall

let neighbors
    : ∀(Label : Type) → Graph Label → List (Graph Label)
    =   λ(Label : Type)
      → λ(graph : Graph Label)
      → graph
          (List (Graph Label))
          (   λ(Vertex : Type)
            → λ(current : Vertex)
            → λ(step : Vertex → { label : Label, neighbors : List Vertex })
            → let neighborVertexs
                  : List Vertex
                  = (step current).neighbors

              let vertexToGraph
                  : Vertex → Graph Label
                  =   λ(vertex : Vertex)
                    → λ(Graph : Type)
                    → λ ( MakeGraph
                        :   ∀(Vertex : Type)
                          → ∀(current : Vertex)
                          → ∀ ( step
                              :   Vertex
                                → { label : Label, neighbors : List Vertex }
                              )
                          → Graph
                        )
                    → MakeGraph Vertex vertex step

              in  List/map Vertex (Graph Label) vertexToGraph neighborVertexs
          )

in  neighbors
