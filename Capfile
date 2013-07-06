load 'deploy'
require "supply_drop"

# =======================================
# deployment helpers
def datacenter_tasks(datacenter, servers)
  task datacenter do
    role :server, *servers
  end

  servers.each do |server|
    task server do
      role :server, server
    end
  end
end

# =======================================
# QA servers
datacenter_tasks :qa, [
  "000.111.0.1"
]

# =======================================
# Production servers
datacenter_tasks :production, []

# =======================================
# supply_drop and capistrano configuration
set :user, 'root'
set :puppet_parameters, './manifests/default.pp'
