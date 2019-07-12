function Get-LastFMScrobbledTracks {
    param(
        [Parameter(Mandatory = $true)]
        [string]$User,

        [Parameter(Mandatory = $false)]
        [string]$Period,

        [Parameter(Mandatory = $false)]
        [string]$Limit,

        [Parameter(Mandatory = $false)]
        [string]$APIkey

    )

    $page = 1
    $maxPage = 1000000
    $attempts = 0
    $data = @()

    while ($page -le $maxPage) {
        $url = "http://ws.audioscrobbler.com/2.0/?method=user.gettoptracks&user=$user&api_key=$lastfmKey&$(if($limit){"limit=$limit&"})page=$page&$(if($period){"period=$period&"})format=json"
        Try {
            $response = Invoke-RestMethod -Uri $url -UseBasicParsing -ContentType "application/json" -ErrorAction Stop
            $maxPage = $response.toptracks.'@attr'.totalPages
            $data += $response.toptracks.track
            Write-Host "Retrieved $($response.toptracks.track.count) tracks (of $($response.toptracks.'@attr'.total)). Now at $($data.count). Completed page $page of $maxPage."
    
            $page++
            $attempts = 0
        }
        Catch {
            $attempts++
            if ($attempts -lt 5) {
                Write-Verbose "Failed to retrieve Page $page (attempt $attempts of 5). Will try again. Exception: $($_.Exception.Message)"
            }
            else {
                Write-Verbose "Failed to retrieve Page $page (attempt $attempts of 5). Will not try again. Exception: $($_.Exception.Message)" -Verbose:$true
                Throw $_.Exception
            }
        }
    }

    return $data
}
