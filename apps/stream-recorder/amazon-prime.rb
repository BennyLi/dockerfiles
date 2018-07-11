#! /usr/bin/env ruby

require 'watir'
require 'webdrivers'

browser = Watir::Browser.new :chrome, options: {args: [
  '--no-sandbox',
  '--disable-dev-shm-usage',
  '--windows-size=1024,768'
]}

# Agent Carter S2E10
# https://www.amazon.de/gp/video/detail/B06WGQJ1M5/
#
# Amazon Login
# Prime Verwaltungsseite
# https://www.amazon.de/gp/primecentral
# -> Redirect
# https://www.amazon.de/ap/signin?_encoding=UTF8
#     &openid.assoc_handle=deflex
#     &openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select
#     &openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select
#     &openid.mode=checkid_setup
#     &openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0
#     &openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0
#     &openid.pape.max_auth_age=900
#     &openid.return_to=https%3A%2F%2Fwww.amazon.de%2Fgp%2Fprimecentral%3Fie%3DUTF8%26%252AVersion%252A%3D1%26%252Aentries%252A%3D0
def get_docker_secret(filepath)
  data = ""
  file = File.open(filepath, "r")
  file.each_line do |line|
    data += line
  end
  return data
end
  
browser.goto 'https://www.amazon.de/gp/primecentral'

# Check login field for mail
# ... and submit mail
browser.text_field(name: 'email').wait_until_present
browser.text_field(name: 'email').set get_docker_secret("/home/dev/amazon_user")
browser.button(type: 'submit').click


# Check password field
# ... and submit password
browser.text_field(name: 'password').wait_until_present
browser.text_field(name: 'password').set get_docker_secret("/home/dev/amazon_password")
browser.button(type: 'submit').click

browser.goto 'https://www.amazon.de/gp/video/detail/B075XBZKFX/ref=atv_dp_pb_core?autoplay=1&t=0'

browser.div(class: 'loadingSpinner').wait_until_present
browser.div(class: 'loadingSpinner').wait_while_present

# Go fullscreen
puts "Go fullscreen"
browser.send_keys 'f'

# TODO Check if advertising is played

# Stop playback to first start recorder
puts "Check if autoplay did start the video"
if browser.div(class: 'pausedOverlay').div(class: 'pausedIcon').exists?
  puts "Stop the video so we can first start the recording"
  browser.send_keys :space
end

# TODO start recording
puts "Recording stream"
ffmpeg_pid = spawn("ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 -f pulse -ac 2 -i default /home/dev/recordings/output.mkv")

sleep 60

Process.kill ffmpeg_pid
