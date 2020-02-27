-- Get the label for the current node of a Graph
let Graph = ./Graph.dhall

let label
    : ∀(Label : Type) → Graph Label → Label
    =   λ(Label : Type)
      → λ(graph : Graph Label)
      → graph
          Label
          (   λ(Node : Type)
            → λ(current : Node)
            → λ(step : Node → { label : Label, neighbors : List Node })
            → (step current).label
          )

in  label
