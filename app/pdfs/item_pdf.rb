class ItemPdf < Prawn::Document
  def initialize(item)
    super()
    @item = item
    text "Item #{@item.id} Book Tag"
  end
end
