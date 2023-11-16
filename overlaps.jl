using StructuredLight,Plots,LaTeXStrings, HDF5

default()
default(label=false,
fontfamily="Computer Modern",
dpi=1000,
grid=false,
framestyle = :box, 
markersize = 5, 
tickfontsize=15, 
labelfontsize=20,
legendfontsize=14,
width=4,
size=(700,400),
bottom_margin = -10Plots.mm,
left_margin = 3.5Plots.mm,)

function R(p₁,p₂,p₃,p₄,l₁,l₂,l₃,l₄)
    rs = LinRange(-5,5,1024)
    ψ₁ = lg(rs,rs,p=p₁,l=l₁) .* lg(rs,rs,p=p₂,l=l₂)
    ψ₂ = lg(rs,rs,p=p₃,l=l₃) .* lg(rs,rs,p=p₄,l=l₄)
    abs(overlap(ψ₂,ψ₁,rs,rs))
end
##
l = 1
l₂ = 3
l₁ = 2l - l₂
ps = 0:5
R0 = R(0,0,0,0,l,l,l,l)
Rs = [R(p₁,p₂,0,0,l₁,l₂,l,l)/R0 for p₁ ∈ ps, p₂ ∈ ps]
sort(vec(Rs))
heatmap(ps,ps,Rs,colormap=:thermal,aspect_ratio=:equal,size=(600,600),clims=(0,1),
title=L"\left| R^{%$l₁ %$l₂ 11}_{p_1p_200}/ R^{1111}_{0000}\right|",
xlabel=L"p_1",ylabel=L"p_2")
Rs
file = h5open("l2=$l₂.h5","w")
file["data"] = Rs
close(file)