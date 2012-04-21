# This file loads the config.yml file
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]