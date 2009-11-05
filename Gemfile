bundle_path "gems"
disable_system_gems

merb_gems_version = "~>1.1"
dm_gems_version   = "~>0.10.1"
do_gems_version   = "~>0.10.0"

gem "repertoire_core", "~>0.3.3"
gem "repertoire-assets", "~>0.1.1"

gem "jquery"

gem "merb-core", merb_gems_version
gem "merb-action-args", merb_gems_version
gem "merb-assets", merb_gems_version
gem("merb-cache", merb_gems_version) do
  Merb::Cache.setup do
    register(Merb::Cache::FileStore) unless Merb.cache
  end
end
gem "merb-helpers", merb_gems_version
gem "merb-mailer", merb_gems_version
gem "merb-slices", merb_gems_version
gem "merb-auth-core", merb_gems_version
gem "merb-auth-more", merb_gems_version
gem "merb-auth-slice-password", merb_gems_version
gem "merb-param-protection", merb_gems_version
gem "merb-exceptions", merb_gems_version

gem "data_objects", do_gems_version
gem "do_postgres", do_gems_version

gem "dm-core", dm_gems_version
gem "dm-aggregates", dm_gems_version
gem "dm-migrations", dm_gems_version
gem "dm-timestamps", dm_gems_version
gem "dm-types", dm_gems_version
gem "dm-validations", dm_gems_version
gem "dm-serializer", dm_gems_version

gem "merb_datamapper", merb_gems_version

gem "RedCloth"
gem "json"

gem "mongrel"