module Workplace
  class DocumentsController < Workplace::ApplicationController
    before_filter :find_document, except: [:index, :new, :create, :tags_list, :participants_list, :related_documents]
    helper_method :search_params

    def index
      @documents = if params[:search]
                     DocumentsSearcher.new(params[:search].merge(page: params[:page], per_page: per_page)).search
                   else
                     Document.preload(:map_layers, :tags).ordered.page(page).per(per_page)
                   end
    end

    def show
      @document = Document.find(params[:id])
    end

    def new
      @document = Document.new
    end

    def create
      @document = Document.create(params[:document])

      respond_with @document, location: -> { workplace_document_path(@document) }
    end

    def edit
    end

    def update
      @document.update(params[:document])

      respond_with @document, location: -> { workplace_document_path @document }
    end

    def destroy
      @document.destroy

      redirect_to workplace_documents_path
    end

    def download
      send_file @document.file.path,
                filename: @document.file_file_name,
                type: @document.file_content_type,
                disposition: 'attachment'
    end

    %w(tags participants).each do |method_name|
      define_method %(#{method_name}_list) do
        tag_list = Document
                   .tag_counts_on(method_name.to_sym)
                   .map(&:name)
                   .sort
                   .select { |s| s.match(/#{Regexp.quote(params[:term])}/i) }

        render(text: tag_list.to_json) && return
      end
    end

    def related_documents
      docs = Document
             .where("title ilike ? or number ilike ? or to_char(date_on, 'DD.MM.YYYY') ilike ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%")
             .where.not(id: params[:current])
      json = docs.map { |doc| { id: doc.id, label: doc.full_title, value: doc.title } }

      render json: json.to_json
    end

    def search_params
      Hashie::Mash.new params[:search]
    end

    private

    def find_document
      @document = Document.find(params[:id])
    end

    def page
      params[:page] || 1
    end

    def per_page
      35
    end
  end
end
