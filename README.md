# Get-LastFMScrobbledTracks
Quick Powershell function to retrieve all scrobbled tracks from Last.FM. Returns all scrobbled tracks in specified time period (or ever, if no time period specified) as an array.

Available parameters:
- User (required) - the username of the person whose history you want to retrieve
- Period (optional) - the timespan for which you want to retrieve the track listing ('overall', '7day', '1month', '3month', '6month', '12month'); default is 'overall'
- Limit (optional) - the number of tracks to retrieve per page; default is 50, max is 1000
- APIkey (optional) - a Last.FM API key, if desired (not required)

Ex. Get-LastFMScrobbledTracks -User sup3rmark -Limit 500

Reference: https://www.last.fm/api/show/user.getTopTracks
