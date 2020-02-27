{- This is the type of a directed graph with labeled vertices

   This graph representation is "well-typed" meaning that you cannot have
   "broken" edges that point to invalid vertices.  Or in other words an invalid
   graph is a type error.

   You don't need to build nor consume values of this type directly.  Instead:

   * Use the `MakeGraph` utility to create a `Graph`
   * Use the `current` and `neighbors` function to query/consume a `Graph`

   The documentation for those utilities provides additional explanations and
   examples.
-}
let Graph
    : Type → Type
    =   λ(Label : Type)
      →   ∀(Graph : Type)
        → ∀ ( MakeGraph
            :   ∀(Vertex : Type)
              → Vertex
              → (Vertex → { label : Label, neighbors : List Vertex })
              → Graph
            )
        → Graph

in  Graph
