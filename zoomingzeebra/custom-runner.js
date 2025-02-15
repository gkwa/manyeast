#!/usr/bin/env node

const { program } = require("playwright/lib/program")

// Here we can add our own commands before parsing if we want
// program.command('custom')
//   .description('custom command')
//   .action(() => {
//     console.log('custom command');
//   });

// Or just let the default commands run
program.parse(process.argv)
