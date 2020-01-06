
# Get Last Semantic Version and Semantic Version Branch Name Javascript Action

This action gets the last semantic version and semantic version branch in a repository that matches a prefix provided by the user.

## Inputs

### `regex-string`

**Required** A desired string to match against all the branches in the repository. Default `''`.

## Outputs

### `last-semver`

The last semantic version found from branches that contain the regex-string input.

### `last-semver-branch`

The branch in which the last semantic version was pulled from.

## Example usage

    uses: actions/github-action-get-regex-branch@v1
    with:
      regex-string: 'release-v'
  
