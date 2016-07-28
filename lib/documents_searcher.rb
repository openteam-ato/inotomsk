class DocumentsSearcher
  attr_accessor :search_params

  def initialize(params)
    @search_params = Hashie::Mash.new params
  end

  def search
    documents = Document.preload(:map_layers, :tags).page(search_params.page).per(search_params.per_page)
    documents = documents.where("title ilike '%#{search_params.q}%'") if search_params.q.present?
    documents = documents.tagged_with(search_params.tags, any: true) if search_params.try(:tags).try(:delete_if, &:blank?).present?
    documents = documents.tagged_with(search_params.participants, any: true) if search_params.try(:participants).try(:delete_if, &:blank?).present?
    documents = documents
                .joins(:document_map_layers)
                .where('document_map_layers.map_layer_id in (?)', search_params.map_layers) if search_params.try(:map_layers).try(:delete_if, &:blank?).present?
    documents = documents.ordered

    documents
  end
end
