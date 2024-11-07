$FileDialog = [System.Windows.Forms.OpenFileDialog]::new()
$FileDialog.Filter = "BMP images (*.bmp)|*.bmp"
$FileDialog.Title = "Choose bitmap image:"
$MatchTable = " ", "░", "▒", "▓", "█"

"Color Scanner"

$MatchedColor = (Read-Host "Give hex color to be matched (e.g. fffef4)")
$MatchedColor = (
[convert]::ToByte(-join$MatchedColor[0..1],16),
[convert]::ToByte(-join$MatchedColor[2..3],16),
[convert]::ToByte(-join$MatchedColor[4..5],16)
)

if ($FileDialog.ShowDialog() -eq "OK") {
    $Image = [System.Drawing.Bitmap]::new($FileDialog.FileName)
}

for ($y = 0; $y -lt $Image.Height; $y++) {
    for ($x = 0; $x -lt $Image.Width; $x++) {
        $Color = $Image.GetPixel($x, $y)
        $Difference = [byte](($Color.R -bxor $MatchedColor[0] + $Color.G -bxor $MatchedColor[1] + $Color.B -bxor $MatchedColor[2] ) / 3 / 51)
        Write-Host $MatchTable[(4 - $Difference)] -NoNewline
    }
    ""
}