1.🔹 System.DefaultWorkingDirectory --> The main working folder where the agent runs tasks by default.
What it contains:
    Source code
    Build outputs
    Downloaded artifacts (in many cases)
Typical path (Microsoft-hosted agent): /home/vsts/work/1/s
2.----------------
$(Build.DefinitionName) → The name (alias) of the pipeline / build definition.
This identifies which pipeline triggered the build.
3.--------------
$(Build.SourcesDirectory)→ The folder where the repository source code is checked out.
This is where your Git repo lives during the build.
4.---------------
$(Build.ArtifactStagingDirectory) : A temporary folder where you place files before publishing artifacts.
path : /home/vsts/work/1/a
- task: CopyFiles@2
  inputs:
  SourceFolder: '$(Build.SourcesDirectory)'
  Contents: '**/*.zip'
  TargetFolder: '$(Build.ArtifactStagingDirectory)'

This is the packing area for build artifacts.
5.--------------
Build.BuildId : A unique numeric ID for each build run.
Every pipeline run gets a unique Build ID.
======================How these fit together (simple flow)============
Agent starts
↓
System.DefaultWorkingDirectory
↓
Build.SourcesDirectory (repo cloned)
↓
Build.ArtifactStagingDirectory (files prepared)
↓
Artifacts published with Build.BuildId
==============================================================================
| Variable                         | Purpose                        |
| -------------------------------- | ------------------------------ |
| `System.DefaultWorkingDirectory` | Agent’s default working folder |
| `Build.DefinitionName`           | Pipeline name                  |
| `Build.SourcesDirectory`         | Source code location           |
| `Build.ArtifactStagingDirectory` | Artifact preparation folder    |
| `Build.BuildId`                  | Unique build run ID            |
