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

  def tags_list
    tag_list = ActsAsTaggableOn::Tag.all.map(&:to_s).sort.select { |s| s.match(/#{Regexp.quote(params[:term])}/i) }

    render text: tag_list.to_json and return
  end
end
