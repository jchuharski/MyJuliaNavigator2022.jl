using MyJuliaPackage
using Documenter

DocMeta.setdocmeta!(MyJuliaPackage, :DocTestSetup, :(using MyJuliaPackage); recursive=true)

makedocs(;
    modules=[MyJuliaPackage],
    authors="jchuharski <76936794+jchuharski@users.noreply.github.com> and contributors",
    repo="https://github.com/jchuharski/MyJuliaPackage.jl/blob/{commit}{path}#{line}",
    sitename="MyJuliaPackage.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jchuharski.github.io/MyJuliaPackage.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=["Home" => "index.md"],
)

deploydocs(; repo="github.com/jchuharski/MyJuliaPackage.jl", devbranch="main")
