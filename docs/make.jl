using MyJuliaNavigator2022
using Documenter

DocMeta.setdocmeta!(MyJuliaNavigator2022, :DocTestSetup, :(using MyJuliaPackage); recursive=true)

makedocs(;
    modules=[MyJuliaNavigator2022],
    authors="jchuharski <76936794+jchuharski@users.noreply.github.com> and contributors",
    repo="https://github.com/jchuharski/MyJuliaNavigator2022.jl/blob/{commit}{path}#{line}",
    sitename="MyJuliaNavigator2022.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jchuharski.github.io/MyJuliaNavigator2022.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=["Home" => "index.md", "Algorithm Docs" => "Algorithm.md"],
)

deploydocs(; repo="github.com/jchuharski/MyJuliaNavigator2022.jl", devbranch="main")
