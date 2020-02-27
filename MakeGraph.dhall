{-  Use `MakeGraph` to build a `Graph` by providing the following three
    arguments:

    * First, a `Vertex` type (typically an enum) used to represent vertices

      Each alternative of the `Vertex` enum represents a different vertex of the
      `Graph`

    * Second, the "current" `Vertex` of the graph

      This starting point is necessary in order to navigate the `Graph`

    * Third, a "step" function whose input is a `Vertex` and whose output is
      that vertex's `label` and its `neighbors`
-}
let Graph = ./Graph.dhall

let MakeGraph
    :   ∀(Label : Type)
      → ∀(Vertex : Type)
      → ∀(current : Vertex)
      → ∀(current : Vertex → { label : Label, neighbors : List Vertex })
      → Graph Label
    =   λ(Label : Type)
      → λ(Vertex : Type)
      → λ(current : Vertex)
      → λ(step : Vertex → { label : Label, neighbors : List Vertex })
      → λ(Graph : Type)
      → λ ( MakeGraph
          :   ∀(Vertex : Type)
            → Vertex
            → (Vertex → { label : Label, neighbors : List Vertex })
            → Graph
          )
      → MakeGraph Vertex current step

in  MakeGraph
