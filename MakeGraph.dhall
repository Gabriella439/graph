{-  Use `MakeGraph` to build a `Graph` by providing the following three
    arguments:

    * First, a `Node` type (typically an enum) used to represent vertices

      Each alternative of the `Node` enum represents a different vertex of the
      `Graph`

    * Second, the "current" `Node` of the graph

      This starting point is necessary in order to navigate the `Graph`

    * Third, a "step" function whose input is a `Node` and whose output is
      that node's `label` and its `neighbors`
-}
let Graph = ./Graph.dhall

let MakeGraph
    :   ∀(Label : Type)
      → ∀(Node : Type)
      → ∀(current : Node)
      → ∀(current : Node → { label : Label, neighbors : List Node })
      → Graph Label
    =   λ(Label : Type)
      → λ(Node : Type)
      → λ(current : Node)
      → λ(step : Node → { label : Label, neighbors : List Node })
      → λ(Graph : Type)
      → λ ( MakeGraph
          :   ∀(Node : Type)
            → Node
            → (Node → { label : Label, neighbors : List Node })
            → Graph
          )
      → MakeGraph Node current step

in  MakeGraph
