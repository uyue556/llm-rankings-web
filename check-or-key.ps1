param([Parameter(Mandatory=$true)][string]$Key)
$url = "https://openrouter.ai/api/v1/benchmarks?source=artificial-analysis&max_results=1"
try {
  $r = Invoke-RestMethod -Uri $url -Headers @{ Authorization = "Bearer $Key" } -TimeoutSec 15
  "=== PASS: benchmarks OK ==="
  "rows returned: $($r.data.Count)"
  "sample: $($r.data[0].display_name) intel=$($r.data[0].intelligence_index)"
} catch {
  $resp = $_.Exception.Response
  if ($resp) {
    $code = [int]$resp.StatusCode
    $stream = $resp.GetResponseStream(); $stream.Position = 0
    $body = (New-Object IO.StreamReader($stream)).ReadToEnd()
    "=== FAIL: HTTP $code ==="
    $body
    if ($code -eq 401) { ">> key is invalid/deleted. Create a new one at https://openrouter.ai/settings/keys" }
    elseif ($code -eq 429) { ">> rate limited. Wait for the minute window or daily window to reset (500/day per account)." }
    elseif ($code -eq 403) { ">> forbidden: check guardrails/data-region settings or account status." }
  } else { "network error: $($_.Exception.Message)" }
}
