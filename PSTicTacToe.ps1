# PSTicTacToe.ps1
# Brent Erickson

$Square = @(0,25,27,29,13,15,17,1,3,5) # Location of all playing squares in the board array

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
    $Win = $False
    foreach ($Item in $Square) { # Loop to find players mark
        If ($Board[$Item] -eq $Player) { # If players mark is found make note of the location
            $Array += $Item
        }
    }
    
    # Check all possible winning combinations
    if (($Array -contains "1") -and ($Array -contains "15") -and ($Array -contains"29")) { $Win = $True } # Backslash Logic
    if (($Array -contains "25") -and ($Array -contains "15") -and ($Array -contains"5")) { $Win = $True } # Forwardslash logic
    if (($Array -contains "1") -and ($Array -contains "13") -and ($Array -contains"25")) { $Win = $True } # First Column Logic
    if (($Array -contains "3") -and ($Array -contains "15") -and ($Array -contains"27")) { $Win = $True } # Second Column Logic
    if (($Array -contains "5") -and ($Array -contains "17") -and ($Array -contains"29")) { $Win = $True } # Third Column Logic
    if (($Array -contains "1") -and ($Array -contains "3") -and ($Array -contains"5")) { $Win = $True } # First Row Logic
    if (($Array -contains "13") -and ($Array -contains "15") -and ($Array -contains"17")) { $Win = $True } # Second Row Logic
    if (($Array -contains "25") -and ($Array -contains "27") -and ($Array -contains"29")) { $Win = $True } # Third Row Logic
    return $Win # Return bool
}

Function ComputerMove($Move) {
    If ($Turn -eq 0) { # If first move
        [int]$Move = 5 # Set Middle square 
    }
    Else { # If not first move
        $Array = @()
        foreach ($Item in $Square) { # Loop to find players mark
            If ($Board[$Item] -ne [int]) { # If players mark is found make note of the location
                $Array += $Item
            }
        }
        # Backslash Logic
        if (($Array -contains $Square[9]) -and ($Array -contains $Square[5]) -and ($Array -notcontains $Square[1])) { $Move = 1 }
        if (($Array -contains $Square[9]) -and ($Array -notcontains $Square[5]) -and ($Array -contains $Square[1])) { $Move = 5 }
        if (($Array -notcontains $Square[9]) -and ($Array -contains $Square[5]) -and ($Array -contains $Square[1])) { $Move = 9 }

        # Forwardslash logic
        if (($Array -contains $Square[3]) -and ($Array -contains $Square[5]) -and ($Array -notcontains $Square[7])) { $Move = 7 }
        if (($Array -contains $Square[3]) -and ($Array -notcontains $Square[5]) -and ($Array -contains $Square[7])) { $Move = 5 }
        if (($Array -notcontains $Square[3]) -and ($Array -contains $Square[5]) -and ($Array -contains $Square[7])) { $Move = 3 }

        # First Column Logic
        if (($Array -contains $Square[7]) -and ($Array -contains $Square[4]) -and ($Array -notcontains $Square[1])) { $Move = 1 }
        if (($Array -contains $Square[7]) -and ($Array -notcontains $Square[4]) -and ($Array -contains $Square[1])) { $Move = 4 }
        if (($Array -notcontains $Square[7]) -and ($Array -contains $Square[4]) -and ($Array -contains $Square[1])) { $Move = 7 }

        # Second Column Logic
        if (($Array -contains $Square[8]) -and ($Array -contains $Square[5]) -and ($Array -notcontains $Square[2])) { $Move = 2 }
        if (($Array -contains $Square[8]) -and ($Array -notcontains $Square[5]) -and ($Array -contains $Square[2])) { $Move = 5 }
        if (($Array -notcontains $Square[8]) -and ($Array -contains $Square[5]) -and ($Array -contains $Square[2])) { $Move = 8 }

        # Third Column Logic
        if (($Array -contains $Square[9]) -and ($Array -contains $Square[6]) -and ($Array -notcontains $Square[3])) { $Move = 3 }
        if (($Array -contains $Square[9]) -and ($Array -notcontains $Square[6]) -and ($Array -contains $Square[3])) { $Move = 6 }
        if (($Array -notcontains $Square[9]) -and ($Array -contains $Square[6]) -and ($Array -contains $Square[3])) { $Move = 9 }

        # First Row Logic
        if (($Array -contains $Square[7]) -and ($Array -contains $Square[8]) -and ($Array -notcontains $Square[9])) { $Move = 9 }
        if (($Array -contains $Square[7]) -and ($Array -notcontains $Square[8]) -and ($Array -contains $Square[9])) { $Move = 8 }
        if (($Array -notcontains $Square[7]) -and ($Array -contains $Square[8]) -and ($Array -contains $Square[9])) { $Move = 7 }

        # Second Row Logic
        if (($Array -contains $Square[4]) -and ($Array -contains $Square[5]) -and ($Array -notcontains $Square[6])) { $Move = 6 }
        if (($Array -contains $Square[4]) -and ($Array -notcontains $Square[5]) -and ($Array -contains $Square[6])) { $Move = 5 }
        if (($Array -notcontains $Square[4]) -and ($Array -contains $Square[5]) -and ($Array -contains $Square[6])) { $Move = 4 }

        # Third Row Logic
        if (($Array -contains $Square[1]) -and ($Array -contains $Square[2]) -and ($Array -notcontains $Square[3])) { $Move = 3 }
        if (($Array -contains $Square[1]) -and ($Array -notcontains $Square[2]) -and ($Array -contains $Square[3])) { $Move = 2 }
        if (($Array -notcontains $Square[1]) -and ($Array -contains $Square[2]) -and ($Array -contains $Square[3])) { $Move = 1 }
        
        # If $Move is in $Array set random number
        If ($Array -contains $Square[($Move)]) {
            $Move = (Get-Random -Minimum 1 -Maximum 9)
        }
    }
    return [int]$Move
}

$Board = ResetBoard
$Turn = 0 # Counter used to determine whose turn it is
While ($Turn -le 8)  # Allows play until board is full
{
    clear-host
    write-host "`r`nTic Tac Toe`r`n" $Board
    If([bool]!($Turn%2)) { # Check Which Players turn it is
        $Player = "X"
    }
    Else { 
        $Player = "O" 
    }

    if ($Player -eq "O") {
        $Input = Read-host -prompt "$Player Which Square"
    }
    else {
        $Input = (ComputerMove $Input)
    }

    If ($Board[$Square[$Input]] -eq $Input) { # Compare Square array to Board using input as the position locator
        $Board[$Square[$Input]] = $Player # Set that square as the players mark
        $Turn++
    }

    if ((CheckWin $Board $Player)-eq $True) { $Turn = 100 } # If Returns true Player won by three in a row
}
If ($Turn -eq 100) { # Check if you win by Three in a row or if cats game
    write-host "$Player Wins!"
}
else { # If not three in a role play ended in a tie
    write-host "Cat's Game!"
}
read-host
$Board = $Null