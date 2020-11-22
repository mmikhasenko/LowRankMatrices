using LowRankMatrices
using LinearAlgebra
using StaticArrays
using Test

m4 = FixedRankMatrix(SVector(rand(4), rand(4), rand(4), rand(4)))
m1 = Rank1Matrix(rand(4))
m2 = Rank2Matrix(rand(4), rand(4))
m3 = Rank3Matrix(rand(4), rand(4), rand(4))

@test size(m3) == (size(m3,1), size(m3,2))
@test_throws ArgumentError size(m3,0)
@test size(m3,3) == size(m3,4) == 1

@test size(m1) == size(m2) == size(m3) == size(m4) == (4,4)
@test abs(det(m1)) < 1e-10
@test abs(det(m2)) < 1e-10
@test abs(det(m3)) < 1e-10
@test det(m4) != 0

@test_throws ErrorException m1[3] = 1.1

@test rank(m1) == rank(Matrix(m1)) == 1
@test rank(m2) == rank(Matrix(m2)) == 2
@test rank(m3) == rank(Matrix(m3)) == 3
@test rank(m4) == rank(Matrix(m4)) == 4

m12 = m1+m2
@test typeof(m12) <: Rank3Matrix

m1x3 = m1*m3
@test rank(m1x3) == min(rank(m1), rank(m3))

m2xr = m2*rand(4,4)
@test rank(m2xr) == min(rank(m2), 4)

rc = rand(4)
v2 = m2*rc
x2 = Matrix(m2)*rc
@test prod(v2 .≈ x2)

v2 = rc'*m2
x2 = rc'*Matrix(m2)
@test prod(v2 .≈ x2)
