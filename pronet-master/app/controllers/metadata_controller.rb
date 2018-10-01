# This holds just one routes located at /metadata for creating the XML 
# required for SAML.

class MetadataController < ApplicationController
  def index
    meta = OneLogin::RubySaml::Metadata.new
    saml_settings.idp_entity_id = "https://#{host}/metadata"
    render xml: meta.generate(saml_settings, true)
  end
end