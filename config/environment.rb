# Load the rails application
require File.expand_path('../application', __FILE__)

# Emergent Time configuration
Time::DATE_FORMATS[:emt_date] = "%d %b %Y"

# Initialize the rails application
EmergentTime::Application.initialize!
