const core = require('@actions/core');
const util = require('util');
const exec = util.promisify(require('child_process').exec);

try {
  // `regex-string` input defined in action metadata file
  const regexString = core.getInput('regex-string');
  const regexp = /^[A-Za-z0-9_-]*$/;
  if (regexp.test(regexString)) {
    const command = './ cut-release-branch.sh ' + regexString;
  
    const output = getSemVerBranches(command);
    output.then(function(result){
      if (result["semanticVersion"]) {
        console.log('\x1b[32m%s\x1b[0m', `Last Semantic Version Found: ${result["semanticVersion"]}`);
        core.setOutput("last-semver", result["semanticVersion"]);
      }
      if (result["branchName"]) {
        console.log('\x1b[32m%s\x1b[0m', `Last Branch with Semantic Version Found: ${result["branchName"]}`);
        core.setOutput("last-semver-branch", result["branchName"]);
      }
    });
  } else {
    const regexError = "Regex string must contain only numbers, strings, underscores, and dashes.";
    console.log('\x1b[33m%s\x1b[0m', regexError);
    core.setFailed(regexError);
  }

} catch (error) {
  core.setFailed(error.message);
}

async function getSemVerBranches(command) {
  // Get all the branches with the regex prefix and return the last version
  try{
    const { err, stdout, stderr } = await exec(command, [{ shell: "bash" }]);

    if (err) {
      console.log('\x1b[33m%s\x1b[0m', 'Could not find any branches because: ');
      console.log('\x1b[31m%s\x1b[0m', stderr);
      process.exit(1);
  
      return;
    }
  
    const data = JSON.parse(stdout);
    if (data) {
      return data;
    }
  } catch (err) {
    console.log(err);
    process.exit(0);
  }
}