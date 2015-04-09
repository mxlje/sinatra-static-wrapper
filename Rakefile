require 'unirest'
require 'json'
require 'colorize'

MSG_PUSHING     = "Triggering new deployment".light_black

STATUS_OK       = "[  OK  ]".green
STATUS_WAIT     = "[ WAIT ]".yellow
STATUS_FAIL     = "[ FAIL ]".red

TAB             = "\t\t"
BS              = "\r"

VDT_AUTH_TOKEN  = ENV['VDT_AUTH_TOKEN']
VDT_AUTH_SECRET = ENV['VDT_AUTH_SECRET']
VDT_APP_ID      = ENV['VDT_APP_ID']

desc "Return true"
task :default do
  puts "Success!".green
end

desc "Deploy to viaduct"
task :deploy do
  unless VDT_AUTH_TOKEN && VDT_AUTH_SECRET && VDT_APP_ID
    abort('Error: Set Viaduct credentials.'.red)
  end

  print MSG_PUSHING + TAB + STATUS_WAIT + BS

  response = Unirest.post(
    'https://api.viaduct.io/api/v1/deployments/start',
    headers: {
      'X-Auth-Token'  => VDT_AUTH_TOKEN,
      'X-Auth-Secret' => VDT_AUTH_SECRET,
    },
    parameters: "params={\"application\":\"#{VDT_APP_ID}\"}"
  )

  case response.body['status']
  when "success"
    print MSG_PUSHING + TAB + STATUS_OK + "\n\n"
    puts "Deployment #{response.body.fetch('data')['number']} started successfully."

  else
    print MSG_PUSHING + TAB + STATUS_FAIL + "\n\n"
    abort("Error: #{response.body['status']} : #{response.body.fetch('data')['message']}".red)
  end
end
