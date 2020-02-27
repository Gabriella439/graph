let Graph =
      ./Graph.dhall sha256:a2817fe32b7d12ec06d207606b7b5cf1e93674c6da36131a5fc76fa397369f53

let MakeGraph =
      ./MakeGraph.dhall sha256:eb845fb4d2de1500930c84634475baca11b9c2a4d06ba508f2a2879541c75d44

let label =
      ./label.dhall sha256:364f67f1394a3f4d59b934eacd0d5991ac90a1b6d879f1c35fa8ca4e42e30827

let neighbors =
      ./neighbors.dhall sha256:ebad84c0bef8ebdde5a12d3e7fc505c2be388dc324f26ee95331faf990e63ce4

let {-  For convenience, this package is a function from the graph's label type to
        all of the `Graph` operations, so that you only need to specify the
        label type once
    -}
    package =
        λ(Label : Type)
      → { Graph = Graph Label
        , MakeGraph = MakeGraph Label
        , label = label Label
        , neighbors = neighbors Label
        }

let -- Example use of this package using `Text` labels
    graph =
      package Text

let {-  Example graph with the following vertices and edges between them:

            Vertex0 ↔ Vertex1
               ↓
            Vertex2
               ↺

        The starting vertex is Vertex0
    -}
    exampleGraph
    : graph.Graph
    = let Vertex = < Vertex0 | Vertex1 | Vertex2 >

      let step =
              λ(vertex : Vertex)
            → merge
                { Vertex0 =
                    { label = "0"
                    , neighbors = [ Vertex.Vertex1, Vertex.Vertex2 ]
                    }
                , Vertex1 = { label = "1", neighbors = [ Vertex.Vertex0 ] }
                , Vertex2 = { label = "2", neighbors = [ Vertex.Vertex2 ] }
                }
                vertex

      in  graph.MakeGraph Vertex Vertex.Vertex0 step

let test0 = assert : graph.label exampleGraph ≡ "0"

let List/map =
      https://prelude.dhall-lang.org/v14.0.0/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let test1 =
        assert
      :   List/map graph.Graph Text graph.label (graph.neighbors exampleGraph)
        ≡ [ "1", "2" ]

in  package
