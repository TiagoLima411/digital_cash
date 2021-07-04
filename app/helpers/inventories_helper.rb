module InventoriesHelper
  def kinds
    return { "Entrada" => 'income', "Saída" => 'outgoing'}
  end
end
