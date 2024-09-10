# Format release notes in Markdown
$releaseNotes = @"
# Release Notes

**Build Information:**
- **Build ID**: $buildId
- **Build Number**: $buildNumber
- **Requested By**: $buildRequestedFor
- **Start Time**: $buildStartTime

**Release Information:**
- **Release ID**: $releaseId
- **Release Name**: $releaseName
- **Requested By**: $releaseRequestedFor
- **Start Time**: $releaseStartTime

**Pull Request Information:**
- **PR Title**: $prTitle
- **Created By**: $prCreatedBy
- **Creation Date**: $prCreationDate
"@
