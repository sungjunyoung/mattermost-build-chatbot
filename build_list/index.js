function main(args) {
    const request = require('request-promise');

    const requestPromise = request.get('http://52.78.114.28:8080/api/json?tree=jobs' +
        '[name,builds[number,actions[parameters[name,value]]]]&' +
        'exclude=hudson/job/build/action/parameter' +
        '[value!=%275447e2f43ea44eb4168d6b32e1a7487a3fdf237f%27]'
        , {
            'auth': {
                'user': args.jenkinsUser,
                'pass': args.jenkinsToken
            }
        });

    return requestPromise
        .then(function (res) {
            let text = "---\n" +
                "#### 현재 test job 의 빌드 리스트\n" +
                "| number        | class        | actions   |\n" +
                "|:--------------|:-------------|:----------|\n";
            res = JSON.parse(res);
            let buildList = res.jobs[0].builds;
            for (let i in buildList) {
                let build = buildList[i];
                text += "|" + build.number + "|" + build._class + "|" + JSON.stringify(build.actions) + "|\n"
            }
            text += "---\n";

            console.log(text);

            return {
                response_type: 'in_channel',
                text: text
            }
        })
        .catch(err => ({
            response_type: 'in_channel',
            text: "error ocurred"
        }))


}

module.exports.main = main;