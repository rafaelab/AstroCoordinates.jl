using Documenter
using AstroCoordinates


DocMeta.setdocmeta!(AstroCoordinates, :DocTestSetup, :(using AstroCoordinates))


makedocs(
	sitename = "AstroCoordinates.jl",
	format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
	modules = [AstroCoordinates],
	workdir = joinpath(@__DIR__, ".."),
	pages = [
		"Home" => "index.md",
	]
)

deploydocs(repo = "github.com/rafaelab/AstroCoordinates.jl.git", versions = nothing)