# Fixed Rank Matrices

A minimal implementation of the matrices with low rank
```julia
m1 = Rank1Matrix(rand(4))
m2 = Rank2Matrix(rand(4), rand(4))
m3 = Rank3Matrix(rand(4), rand(4), rand(4))

m12 = m1+m2
@assert typeof(m12) <: Rank3Matrix
```

The basic structure is `FixedRankMatrix{N,T}`
```julia
struct FixedRankMatrix{N,T} <: AbstractMatrix{T}
    hs::SVector{N,Vector{T}}
end
```

## Related packages
The `Fixed-rank matrices` is introduced in [`Manifolds.jl`](https://juliahub.com/docs/Manifolds/H884l/0.4.0/manifolds/fixedrankmatrices.html#).
I did not figure out details yet.
