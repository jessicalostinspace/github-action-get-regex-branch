const core = require('@actions/core');
const github = require('@actions/github');
const { exec } = require('child_process');

try {
  // `regex-string` input defined in action metadata file
  const regexString = core.getInput('regex-string');
  console.log(`Regex String: ${regexString}`);

  const command = 'bash cut-release-branch.sh ' + regexString;

  // Get all the branches with the regex prefix and return the last version
  const output = exec(command, [{ shell: "bash" }], (err, stdout, stderr) => {
    if (err) {
      console.log('\x1b[33m%s\x1b[0m', 'Could not find any branches because: ');
      console.log('\x1b[31m%s\x1b[0m', stderr);
      process.exit(1);

      return;
    }

    console.log('\x1b[32m%s\x1b[0m', `Found branch: ${stdout}`);
    const data = JSON.parse(stdout);
    if (data) {
      return data;
    }

    // core.setOutput("release-branch-name", release-branch-name);
    process.exit(0);
  });

  console.log("output: ", output)

  // console.log('lastReleaseBranchName: ', lastReleaseBranchName)

  //   const time = (new Date()).toTimeString();
  //   core.setOutput("time", time);

  // Get the JSON webhook payload for the event that triggered the workflow
  //   const payload = JSON.stringify(github.context.payload, undefined, 2)
  //   console.log(`The event payload: ${payload}`);
} catch (error) {
  core.setFailed(error.message);
}