const build_list = require('./build_list/index');

const args = process.argv[2];
switch(args){
    case 'build_list':
        build_list.main({
            jenkinsUser: process.env['JENKINS_USER'],
            jenkinsToken: process.env['JENKINS_TOKEN'],
        });

}


