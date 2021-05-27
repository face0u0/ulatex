## latex-workshopとの統合
`settings.json`に以下を追記
```
{
    "latex-workshop.docker.enabled": true,
    "latex-workshop.docker.image.latex": "face0u0/ulatex",
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
             "-e",
             "$latex     = 'platex -halt-on-error -interaction=nonstopmode %O %S'",
             "-e",
             "$dvipdf    = 'dvipdfmx %O -o %D %S'",
             "%DOC%"
            ]
        }
    ]
}
```