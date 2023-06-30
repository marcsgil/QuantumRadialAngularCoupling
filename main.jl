using DifferentialEquations,Plots,Statistics

function f!(du,u,p,t)
    λ,g = p
    du[1] = -u[1] + u[2] * (λ - u[1]^2)
    du[2] = -u[2] + u[1] * (λ - u[2]^2)
end

function g!(du,u,p,t)
    λ,g = p
    du[1] = g * √(λ - u[1]^2)
    du[2] = g * √(λ - u[2]^2)
end

p = (0.5,1)
u₀ = complex(rand(2)) * p[1]
prob = SDEProblem(f!, g!, u₀, (0.0, 1.0),p)
ensembleprob = EnsembleProblem(prob)

sol = solve(ensembleprob, EnsembleThreads(), trajectories = 1000)

size(sol)

X = [sum(view(sol,1,n,:)) / size(sol,3) for n in 1:130]
Y = [sum(view(sol,2,n,:)) / size(sol,3) for n in 1:130]

plot(X)

m = [sum(view(sol,i,j,:)) for i in 1:size(sol,1), j in 1:size(sol,2)]

timeseries_steps_mean(sol)

using DifferentialEquations.EnsembleAnalysis
summ = EnsembleSummary(real.(sol), 0:0.01:1)
plot(summ, labels = "Middle 95%")
summ = EnsembleSummary(sol, 0:0.01:1; quantiles = [0.25, 0.75])
plot!(summ, labels = "Middle 50%", legend = true)