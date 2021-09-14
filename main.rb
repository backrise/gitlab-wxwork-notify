require 'gitlab'
require 'clockwork'

def gitlab_notify
  projects = Gitlab.projects.auto_paginate

  puts projects.map(&:to_hash).to_json
end

Clockwork.tap do |c|
  c.handler do |job|
    gitlab_notify
  end
  c.every(1.day, 'daily', at: '19:00')
end
