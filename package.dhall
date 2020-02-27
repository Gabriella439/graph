{-  For convenience, this package is a function from the graph's label type to
    all of the `Graph` operations, so that you only need to specify the
    label type once
-}
let package =
        λ(Label : Type)
      → { Graph = ./Graph.dhall Label
        , MakeGraph = ./MakeGraph.dhall Label
        , label = ./label.dhall Label
        , neighbors = ./neighbors.dhall Label
        }

let -- Example use of this package using `Text` labels
    graph =
      package Text

let {- Example graph with the following nodes and edges between them:

           Node0 ↔ Node1
             ↓
           Node2
             ↺
    -}
    exampleGraph
    : graph.Graph
    = let Node = < Node0 | Node1 | Node2 >

      let step =
              λ(node : Node)
            → merge
                { Node0 =
                    { label = "0", neighbors = [ Node.Node1, Node.Node2 ] }
                , Node1 = { label = "1", neighbors = [ Node.Node0 ] }
                , Node2 = { label = "2", neighbors = [ Node.Node2 ] }
                }
                node

      in  graph.MakeGraph Node Node.Node0 step

let test0 = assert : graph.label exampleGraph ≡ "0"

let List/map =
      https://prelude.dhall-lang.org/v14.0.0/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let test1 =
        assert
      :   List/map graph.Graph Text graph.label (graph.neighbors exampleGraph)
        ≡ [ "1", "2" ]

in  package
