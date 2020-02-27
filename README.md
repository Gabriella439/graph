# `graph`

This package provides [Dhall](https://dhall-lang.org/) support for directed graphs
with labeled nodes

This graph representation is "well-typed" meaning that you cannot have "broken"
edges that point to invalid nodes.  Or in other words an invalid graph is a type
error.

See the [`./package.dhall`](./package.dhall) file for example use of this
package.
