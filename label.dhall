-- Get the label for the current vertex of a Graph
let Graph = ./Graph.dhall

let label
    : ∀(Label : Type) → Graph Label → Label
    =   λ(Label : Type)
      → λ(graph : Graph Label)
      → graph
          Label
          (   λ(Vertex : Type)
            → λ(current : Vertex)
            → λ(step : Vertex → { label : Label, neighbors : List Vertex })
            → (step current).label
          )

in  label
