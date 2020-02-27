{- This is the type of a directed graph with labeled nodes

   This graph representation is "well-typed" meaning that you cannot have
   "broken" edges that point to invalid nodes.  Or in other words an invalid
   graph is a type error.

   You don't need to build nor consume values of this type directly.  Instead:

   * Use the `MakeGraph` utility to create a `Graph`
   * Use the `current` and `neighbors` function to query/consume a `Graph`

   The documentation for those utilities provides additional explanations and
   examples.

   People familiar with Haskell can think of this as a Dhall encoding of the
   following Haskell type:

       {-# LANGUAGE ExistentialQuantification #-}

       data Graph label =
           forall node . Graph { label :: label, neighbors :: [node] }
-}
let Graph
    : Type → Type
    =   λ(Label : Type)
      →   ∀(Graph : Type)
        → ∀ ( MakeGraph
            :   ∀(Node : Type)
              → Node
              → (Node → { label : Label, neighbors : List Node })
              → Graph
            )
        → Graph

in  Graph
