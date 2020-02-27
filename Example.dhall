let List/map =
      https://prelude.dhall-lang.org/v14.0.0/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let Graph
    : Type
    =   ∀(Graph : Type)
      → ∀ ( MakeGraph
          :   ∀(Node : Type)
            → Node
            → (Node → { label : Text, neighbors : List Node })
            → Graph
          )
      → Graph

let MakeGraph
    :   ∀(Node : Type)
      → Node
      → (Node → { label : Text, neighbors : List Node })
      → Graph
    =   λ(Node : Type)
      → λ(current : Node)
      → λ(step : Node → { label : Text, neighbors : List Node })
      → λ(Graph : Type)
      → λ ( MakeGraph
          :   ∀(Node : Type)
            → Node
            → (Node → { label : Text, neighbors : List Node })
            → Graph
          )
      → MakeGraph Node current step

let -- Get `Text` label for the current node of a Graph
    label
    : Graph → Text
    =   λ(graph : Graph)
      → graph
          Text
          (   λ(Node : Type)
            → λ(current : Node)
            → λ(step : Node → { label : Text, neighbors : List Node })
            → (step current).label
          )

let -- Get all neighbors of the current node
    neighbors
    : Graph → List Graph
    =   λ(graph : Graph)
      → graph
          (List Graph)
          (   λ(Node : Type)
            → λ(current : Node)
            → λ(step : Node → { label : Text, neighbors : List Node })
            → let neighborNodes
                  : List Node
                  = (step current).neighbors

              let nodeToGraph
                  : Node → Graph
                  =   λ(node : Node)
                    → λ(Graph : Type)
                    → λ ( MakeGraph
                        :   ∀(Node : Type)
                          → ∀(current : Node)
                          → ∀ ( step
                              : Node → { label : Text, neighbors : List Node }
                              )
                          → Graph
                        )
                    → MakeGraph Node node step

              in  List/map Node Graph nodeToGraph neighborNodes
          )

let {- Example node type for a graph with three nodes

       For your Wiki, replace this with a type with one alternative per document
    -}
    Node =
      < Node0 | Node1 | Node2 >

let {- Example graph with the following nodes and edges between them:

                   Node0 ↔ Node1
                     ↓
                   Node2
                     ↺

       The starting node is Node0
    -}
    exampleA
    : Graph
    = let step =
              λ(node : Node)
            → merge
                { Node0 = { label = "0", neighbors = [ Node.Node1, Node.Node2 ] }
                , Node1 = { label = "1", neighbors = [ Node.Node0 ] }
                , Node2 = { label = "2", neighbors = [ Node.Node2 ] }
                }
                node

      in  MakeGraph Node Node.Node0 step

in  List/map Graph Text label (neighbors exampleA)
