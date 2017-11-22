const function_name = process.argv[2];

const test = require('./' + function_name + '/index');
console.log(test.main());


