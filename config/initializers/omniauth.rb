# OmniAuth.config.logger = Rails.logger
#
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '450566391973687', '617b6e8f90fc9f21a9a55a65a5dc8634'
end
# key 450566391973687
# secret 617b6e8f90fc9f21a9a55a65a5dc8634
