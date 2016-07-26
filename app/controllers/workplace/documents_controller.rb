class Workplace::DocumentsController < Workplace::ApplicationController
  def index
    @documents = Document.order('date_on desc')
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
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    @document.update(params[:document])

    respond_with @document, location: -> { workplace_document_path @document }
  end

  def destroy
    Document.find(params[:id]).destroy

    redirect_to workplace_documents_path
  end

  def download
    @document = Document.find(params[:id])

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
end
