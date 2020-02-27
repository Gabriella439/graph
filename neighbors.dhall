-- Get all neighbors of the current node
let List/map =
      https://prelude.dhall-lang.org/v14.0.0/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let Graph = ./Graph.dhall

let neighbors
    : ∀(Label : Type) → Graph Label → List (Graph Label)
    =   λ(Label : Type) → λ(graph : Graph Label)
      → graph
          (List (Graph Label))
          (   λ(Node : Type)
            → λ(current : Node)
            → λ(step : Node → { label : Label, neighbors : List Node })
            → let neighborNodes
                  : List Node
                  = (step current).neighbors

              let nodeToGraph
                  : Node → Graph Label
                  =   λ(node : Node)
                    → λ(Graph : Type)
                    → λ ( MakeGraph
                        :   ∀(Node : Type)
                          → ∀(current : Node)
                          → ∀ ( step
                              : Node → { label : Label, neighbors : List Node }
                              )
                          → Graph
                        )
                    → MakeGraph Node node step

              in  List/map Node (Graph Label) nodeToGraph neighborNodes
          )

in  neighbors
