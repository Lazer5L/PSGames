# PSTicTacToe.ps1
# Brent Erickson

$Square = @(25,27,29,13,15,17,1,3,5)

Function ResetBoard { # Set playing board to default values
    $Board = "`r`n", "7", "|","8", "|", "9", "`r`n"
    $Board += "-", "-", "-", "-", "-", "`r`n"
    $Board += "4", "|", "5", "|", "6", "`r`n"
    $Board += "-", "-", "-", "-", "-", "`r`n"
    $Board += "1", "|", "2", "|", "3", "`r`n"
    Return $Board
}

Function CheckWin($Board, $Player) { # Check if current player has won
    $Array = @()
    #$Spot = 0 # Counter used for location in Board array
    $Win = $False
    foreach ($Item in $Square) { # Loop to find players mark
        If ($Board[$Item] -eq $Player) { # If players mark is found make note of the location
            $Array += $Item
        }
    }
    
    # Check all possible winning combinations
    if (($Array -contains "1") -and ($Array -contains "15") -and ($Array -contains"29")) { $Win = $True }
    if (($Array -contains "25") -and ($Array -contains "15") -and ($Array -contains"5")) { $Win = $True }
    if (($Array -contains "1") -and ($Array -contains "13") -and ($Array -contains"25")) { $Win = $True }
    if (($Array -contains "3") -and ($Array -contains "15") -and ($Array -contains"27")) { $Win = $True }
    if (($Array -contains "5") -and ($Array -contains "17") -and ($Array -contains"29")) { $Win = $True }
    if (($Array -contains "1") -and ($Array -contains "3") -and ($Array -contains"5")) { $Win = $True }
    if (($Array -contains "13") -and ($Array -contains "15") -and ($Array -contains"17")) { $Win = $True }
    if (($Array -contains "25") -and ($Array -contains "27") -and ($Array -contains"29")) { $Win = $True }
    return $Win # Return bool
}

$Board = ResetBoard
$Turn = 0 # Counter used to determine whose turn it is
While ($Turn -le 8)
{
    #clear-host
    write-host "`r`nTic Tac Toe`r`n" $Board
    If([bool]!($Turn%2)) { # Check Which Players turn it is
        $Player = "X"
    }
    Else { 
        $Player = "O" 
    }
    [int]$Input = Read-host -prompt "$Player Which Square"
    If ($Board[$Square[($Input - 1)]] -eq $Input) { # Compare Square array to Board using input as the position locator
        $Board[$Square[($Input - 1)]] = $Player # Set that square as the players mark
        $Turn++
    }

    if ((CheckWin $Board $Player)-eq $True) { $Turn = 90 } # If Returns true Player won by three in a row
}
If ($Turn -eq 90) { # Check if you win by Three in a row or if cats game
    write-host "$Player Wins!"
}
else {
    write-host "Cat's Game!"
}
read-host
$Board = $Null