require 'unirest'
require 'json'

class C
  class << self
    def green(s)
      "\e[36m#{s}\e[0m"
    end

    def orange(s)
      "\e[33m#{s}\e[0m"
    end

    def red(s)
      "\e[31m#{s}\e[0m"
    end

    def gray(s)
      "\e[90m#{s}\e[0m"
    end

  end
end

desc "Deploy"
task :default do
  puts C.green("Success!")
end


MSG_PUSHING     = C.gray      "Triggering new deployment"

STATUS_OK       = C.green     "[  OK  ]"
STATUS_WAIT     = C.orange    "[ WAIT ]"
STATUS_FAIL     = C.red       "[ FAIL ]"

TAB             = "\t\t"
BS              = "\r"

VDT_AUTH_TOKEN = ENV['VDT_AUTH_TOKEN']
VDT_AUTH_SECRET = ENV['VDT_AUTH_SECRET']
VDT_APP_ID = ENV['VDT_APP_ID']

desc "Deploy to viaduct"
task :deploy do
  unless VDT_AUTH_TOKEN && VDT_AUTH_SECRET && VDT_APP_ID
    abort(C.red('Error: Set Viaduct credentials.'))
  end

  print MSG_PUSHING + TAB + STATUS_WAIT + BS

  response = Unirest.post(
    'https://api.viaduct.io/api/v1/deployments/start',
    headers: {
      'X-Auth-Token'  => VDT_AUTH_TOKEN,
      'X-Auth-Secret' => VDT_AUTH_SECRET,
    },
    parameters: "params={\"application\":\"#{VDT_APP_ID \"}"
  )

  case response.body['status']
  when "success"
    print MSG_PUSHING + TAB + STATUS_OK + "\n\n"
    puts "Deployment #{response.body.fetch('data')['number']} started successfully."

  else
    print MSG_PUSHING + TAB + STATUS_FAIL + "\n\n"

    abort(
      C.red(
        'Error: ' + response.body['status'] + ': ' +
        response.body.fetch('data')['message']
      )
    )
  end
end
