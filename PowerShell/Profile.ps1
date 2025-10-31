$env:EDITOR = "nvim"
$env:YAZI_FILE_ONE = "$($env:ProgramFiles)\Git\usr\bin\file.exe"

Set-PSReadLineOption -HistorySaveStyle SaveNothing

Remove-Item Alias:ls -Force

function ls {
    eza --icons -F -H --group-directories-first --git -1 @args
}

function ll {
    eza --icons -F -H --group-directories-first --git -1 -alF @args
}

function RoClean {
    if ((Test-Path package.json) -and (Test-Path *.project.json) -and (Test-Path out)) {
        Remove-Item -Recurse -Force .\out
    }
}

function RoBuild {
    if ((Test-Path package.json) -and (Test-Path *.project.json)) {
        pnpm rbxtsc
    }
}

function RoWatch {
    if ((Test-Path package.json) -and (Test-Path *.project.json)) {
        RoClean
        pnpm rbxtsc -w
    }
}

function IOS {
    if ((Test-Path package.json) -and (Test-Path *.project.json)) {
        pnpm io-serve
    }
}

function RoServe {
    if (Test-Path *.project.json) {
        rojo serve
    }
}

Invoke-Expression (& starship init powershell)
Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
