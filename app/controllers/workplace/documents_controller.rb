module Workplace
  class DocumentsController < Workplace::ApplicationController
    before_filter :find_document, except: [:index, :new, :create]

    def index
      @documents = if params[:utf8]
                     Document.where('title ilike ?', %(%#{params[:search].try(:[], :q)}%))
                   else
                     Document.ordered
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
      docs = Document.where('title ilike ?', "%#{params[:term]}%").where.not(id: params[:current])
      json = docs.map { |doc| { id: doc.id, label: doc.title, value: doc.title } }

      render json: json.to_json
    end

    private

    def find_document
      @document = Document.find(params[:id])
    end
  end
end
