const core = require('@actions/core');
const exec = require('@actions/exec');

const src = __dirname;
console.log("src: ", src)

try {
  // `regex-string` input defined in action metadata file
  const regexString = core.getInput('regex-string');
  const regexp = /^[A-Za-z0-9_-]*$/;

  if (regexp.test(regexString)) {
    getSemVerBranches(regexString);
  } else {
    const regexError = "Regex string must contain only numbers, strings, underscores, and dashes.";
    console.log('\x1b[33m%s\x1b[0m', regexError);
    core.setFailed(regexError);
  }
} catch (error) {
  core.setFailed(error.message);
}

async function getSemVerBranches(regexString) {
  // Get all the branches with the regex prefix and return the last version
  try{
    let output = '';
    let err = '';
    
    const options = {};
    options.listeners = {
      stdout: (data) => {
        output += data.toString();
      },
      stderr: (data) => {
        err += data.toString();
      }
    };

    await exec.exec(`${src}/get-semver-and-branch.sh`, [regexString], options);
    const { semanticVersion, branchName } = output;
    console.log("semanticVersion: ", semanticVersion)
    console.log("branchName", branchName)
    console.log("output: ", JSON.parse(output))
    if (output["semanticVersion"]) {
      console.log('\x1b[32m%s\x1b[0m', `Last Semantic Version Found: ${output["semanticVersion"]}`);
      core.setOutput("last-semver", output["semanticVersion"]);
    }
    if (output["branchName"]) {
      console.log('\x1b[32m%s\x1b[0m', `Last Branch with Semantic Version Found: ${output["branchName"]}`);
      core.setOutput("last-semver-branch", output["branchName"]);
    }
    if (err) {
      console.log('\x1b[33m%s\x1b[0m', 'Could not find any branches because: ');
      console.log('\x1b[31m%s\x1b[0m', err);
      process.exit(1);
    }
  } catch (err) {
    core.setFailed(err.message);
    process.exit(0);
  }
}