const core = require('@actions/core');
const github = require('@actions/github');
const util = require('util');
const exec = util.promisify(require('child_process').exec);

try {
  // `regex-string` input defined in action metadata file
  const regexString = core.getInput('regex-string');
  console.log(`Regex String: ${regexString}`);

  const command = 'bash cut-release-branch.sh ' + regexString;

  const output = getSemVerBranches(command);
  output.then(function(result){
    console.log("result: ", result)
    if (result["semanticVersion"]) {
      core.setOutput("last-semver", result["semanticVersion"]);
    }
    if (result["branchName"]) {
      core.setOutput("last-semver-branch", result["branchName"]);
    }
  });

  // Get the JSON webhook payload for the event that triggered the workflow
  //   const payload = JSON.stringify(github.context.payload, undefined, 2)
  //   console.log(`The event payload: ${payload}`);
} catch (error) {
  core.setFailed(error.message);
}

async function getSemVerBranches(command) {
  // Get all the branches with the regex prefix and return the last version
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
  console.log('\x1b[32m%s\x1b[0m', `Result: ${data}`);

  // core.setOutput("release-branch-name", release-branch-name);
  process.exit(0);
}