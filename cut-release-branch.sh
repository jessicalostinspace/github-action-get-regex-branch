#!/bin/bash
set -e

regexString=$1

base64 -D <<<"ICAgX19fXyAgICBfICAgXyAgX19fX18gICAgX19fX18gICAgICAgICAgICAgICBfICAgXyAgICAgX19fXyAgICAgICAgIF9fX18gICAgVSBfX19fXyB1ICBfICAgICBVIF9fX19fIHUgICAgXyAgICAgIF9fX18gICBVIF9fX19fIHUKVSAvIl9fX3xVIHwifHV8IHx8XyAiIF98ICB8XyAiIF98ICAgICBfX18gICAgIHwgXCB8InwgVSAvIl9fX3x1ICAgIFUgfCAgXyJcIHUgXHwgX19fInwvIHwifCAgICBcfCBfX18ifC9VICAvIlwgIHUgLyBfXyJ8IHVcfCBfX18ifC8KXHwgfCB1ICAgXHwgfFx8IHwgIHwgfCAgICAgIHwgfCAgICAgIHxfIl98ICAgPHwgIFx8IHw+XHwgfCAgXyAvICAgICBcfCB8XykgfC8gIHwgIF98IiBVIHwgfCB1ICAgfCAgX3wiICAgXC8gXyBcLyA8XF9fXyBcLyAgfCAgX3wiCiB8IHwvX18gICB8IHxffCB8IC98IHxcICAgIC98IHxcICAgICAgfCB8ICAgIFV8IHxcICB8dSB8IHxffCB8ICAgICAgIHwgIF8gPCAgICB8IHxfX18gIFx8IHwvX18gIHwgfF9fXyAgIC8gX19fIFwgIHVfX18pIHwgIHwgfF9fXwogIFxfX19ffCA8PFxfX18vIHUgfF98VSAgIHUgfF98VSAgICBVL3wgfFx1ICAgfF98IFxffCAgIFxfX19ffCAgICAgICB8X3wgXF9cICAgfF9fX19ffCAgfF9fX19ffCB8X19fX198IC9fLyAgIFxfXCB8X19fXy8+PiB8X19fX198CiBfLy8gXFwgKF9fKSApKCAgXy8vIFxcXyAgXy8vIFxcXy4tLF98X19ffF8sLS58fCAgIFxcLC0uXykofF8gICAgICAgIC8vICAgXFxfICA8PCAgID4+ICAvLyAgXFwgIDw8ICAgPj4gIFxcICAgID4+ICApKCAgKF9fKTw8ICAgPj4KKF9fKShfXykgICAgKF9fKShfXykgKF9fKShfXykgKF9fKVxfKS0nICctKF8vIChfIikgIChfLyhfXylfXykgICAgICAoX18pICAoX18pKF9fKSAoX18pKF8iKSgiXykoX18pIChfXykoX18pICAoX18pKF9fKSAgICAoX18pIChfXyk="
echo

git for-each-ref --sort=-committerdate refs/heads/$regexString

# git checkout -b "release-$version"
# git push --set-upstream origin "release-$version"
# echo "Created 'release-$version' branch and pushed to remote"