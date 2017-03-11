# PSTicTacToe.ps1
# Brent Erickson

Function ResetBoard { # Set playing board to default values
    $Board = "`r`n", "7", "|","8", "|", "9", "`r`n"
    $Board += "-", "-", "-", "-", "-", "`r`n"
    $Board += "4", "|", "5", "|", "6", "`r`n"
    $Board += "-", "-", "-", "-", "-", "`r`n"
    $Board += "1", "|", "2", "|", "3", "`r`n"
    Return $Board
}

Function CheckWin($Board, $Player) { # Look at the current plays on for if current player has won
    $Array = @()
    $Spot = 0
    $Win = $False
    foreach ($Item in $Board) { # Loop to find players mark
        If ($Item -eq $Player) { # If players mark is found make note of the location
            $Array += $Spot
        }
        $Spot++
    }
    
    # Check all possible winning combinations
    if (($Array -contains "1") -and ($Array -contains "15") -and ($Array -contains"29")) { $Win = $True }
    if (($Array -contains "25") -and ($Array -contains "15") -and ($Array -contains"5")) { $Win = $True }
    if (($Array -contains "1") -and ($Array -contains "13") -and ($Array -contains"25")) { $Win = $True }
    if (($Array -contains "3") -and ($Array -contains "15") -and ($Array -contains"25")) { $Win = $True }
    if (($Array -contains "5") -and ($Array -contains "17") -and ($Array -contains"29")) { $Win = $True }
    if (($Array -contains "1") -and ($Array -contains "3") -and ($Array -contains"5")) { $Win = $True }
    if (($Array -contains "13") -and ($Array -contains "15") -and ($Array -contains"17")) { $Win = $True }
    if (($Array -contains "25") -and ($Array -contains "27") -and ($Array -contains"29")) { $Win = $True }
    return $Win # Return bool
}

$Board = ResetBoard
$Turn = 0 # Counter used to determine whose turn it is
$Input = 99
While ($Turn -le 9)
{
    clear-host
    write-host "`r`nTic Tac Toe`r`n" $Board
    If([bool]!($Turn%2)) { # Check Which Players turn it is
        $Player = "X"
    }
    Else { 
        $Player = "O" 
    }
    $Input = Read-host -prompt "$Player Which Square"
    Switch ($Input) {
        1 {
            $Spot = 25 
            If ($Board[$Spot] -eq $Input) { # If the square is still its default value player can take it
                $Board[$Spot] = $Player
                $Turn++
            }
        }
        2 { 
            $Spot = 27
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            } 
        }
        3 { 
            $Spot = 29
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            }
        }
        4 { 
            $Spot = 13
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            } 
        }
        5 { 
            $Spot = 15
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            } 
        }
        6 { 
            $Spot = 17
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            }  
        }
        7 { 
            $Spot = 1
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            } 
        }
        8 { 
            $Spot = 3
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            } 
        }
        9 { 
            $Spot = 5
            If ($Board[$Spot] -eq $Input) {
                $Board[$Spot] = $Player
                $Turn++
            } 
        }
        0 { }
    }
    if ((CheckWin $Board $Player)-eq $True) { $Turn = 90 }
}
If ($Turn -eq 90) {
    write-host "$Player Wins!"
}
else {
    write-host "Cat's Game!"
}
read-host
$Board = $Null