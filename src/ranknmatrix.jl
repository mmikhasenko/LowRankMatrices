

struct FixedRankMatrix{N,T} <: AbstractMatrix{T}
    hs::SVector{N,Vector{T}}
end

const Rank1Matrix{T} = FixedRankMatrix{1,T}
const Rank2Matrix{T} = FixedRankMatrix{2,T}
const Rank3Matrix{T} = FixedRankMatrix{3,T}

Rank1Matrix(v::Vector{T}) where T = FixedRankMatrix{1,T}(SVector{1}([v]))
Rank2Matrix(v::Vector{T}, w::Vector{T}) where T = FixedRankMatrix{2,T}(SVector{2}(v,w))
Rank3Matrix(v::Vector{T}, w::Vector{T}, u::Vector{T}) where T = FixedRankMatrix{3,T}(SVector{3}(v,w,u))

import Base: size, getindex, setindex!
function size(m::FixedRankMatrix, d::Integer)
    if d<1
        throw(ArgumentError("dimension must be ≥ 1, got $d"))
    end
    return d<=2 ? length(m.hs[1]) : 1
end

size(m::FixedRankMatrix) = (length(m.hs[1]), length(m.hs[1]))

@inline function getindex(m::FixedRankMatrix, i::Int, j::Int)
    @boundscheck checkbounds(m, i, j)
    return sum(h[i]*h[j] for h in m.hs)
end
setindex!(m::FixedRankMatrix, v, i::Int, j::Int) = error("cannot set entries, not implimented")

import Base: *, +
*(m1::FixedRankMatrix, m2::FixedRankMatrix) = sum(h1 * h2' .* (h1'*h2)  for h1 in m1.hs, h2 in m2.hs)
+(m1::FixedRankMatrix, m2::FixedRankMatrix) = FixedRankMatrix(SVector(m1.hs...,m2.hs...))

*(m::FixedRankMatrix, c::AbstractVector) = sum(h * (h'*c)  for h in m.hs)
# *(c::AbstractVector, m::FixedRankMatrix) = sum((c * h) * h'  for h in m.hs)

*(m::FixedRankMatrix, c::AbstractMatrix) = sum(h * (h'*c)  for h in m.hs)
# *(c::AbstractMatrix, m::FixedRankMatrix) = sum((c * h) * h'  for h in m.hs)
