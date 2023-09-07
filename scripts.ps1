# write-output Apigee Artifacts
$token = $env:TOKEN
$org = $env:ORG
$git_token = $env:GIT_TOKEN

 

$baseURL = "https://apigee.googleapis.com/v1/organizations/"
$headers = @{Authorization = "Bearer $token"}

 

# # Set your GitHub repository information
# $repositoryOwner = "rajeshjanapati@gmail.com"
# $repositoryName = "apigee-encrypt-keys"
# $branchName = "encrypt/keys"  # Change this to the branch you want to access
# $githubToken = "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"

 

 

# Define your GitHub username, repository names, branch name, and file path
$githubUsername = "rajeshjanapati"
$sourceRepo = "apigee-encrypt-keys"
$branchName = "encrypt/keys"
$filePath = "jsonfiles/base64_encoded_app.json"

 

 

# Define the GitHub API URL for fetching the file content from a specific branch
$apiUrl = "https://api.github.com/repos/"+$githubUsername+"/"+$sourceRepo+"/contents/"+$filePath+"?ref="+$branchName

 

Write-Host $apiUrl

 

# Set the request headers with your PAT
$headers = @{
    Authorization = "Bearer $git_token"
}

 

# Make a GET request to fetch the file content
$fileContent = Invoke-RestMethod $apiUrl -Headers $headers

 

# Parse and display the file content (in this case, it's assumed to be JSON)
$jsonContent = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($fileContent.content))
Write-Host "JSON File Content:"
Write-Host $jsonContent

 

# Parse the JSON content into a PowerShell object
$jsonObject = $jsonContent | ConvertFrom-Json

 

# Decode consumerKey and consumerSecret
$consumerKey = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($jsonObject.credentials[0].consumerKey))
$consumerSecret = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($jsonObject.credentials[0].consumerSecret))

 

# Display the decoded values
Write-Host "Decoded Consumer Key: $consumerKey"
Write-Host "Decoded Consumer Secret: $consumerSecret"

 
