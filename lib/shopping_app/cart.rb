require_relative "item_manager"
require_relative "item"

class Cart
  include Ownable
  include ItemManager

  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    @items
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out
    total_amount = 0
    #カートの中身の合計金額を保持するための変数、初期値０
    @items.each do |item|
    # @items はカートの中にあるアイテムの配列、each メソッドは、配列の各アイテムに対してブロック内の処理を繰り返し
    # |item| は、ブロック変数として、現在処理中のアイテムを表示
    self_owner_wallet = self.owner.wallet
    item_owner_wallet = item.owner.wallet

    if item_owner_wallet.deposit(item.price)
      self_owner_wallet.withdraw(item.price)
      item.owner = self.owner
    else
      puts "Insufficient funds for #{item.name}"
    end
  end
 total_amount 
 @items = []
 # 
end

  # ## 要件
  #   - カートの中身（Cart#items）のすべてのアイテムの購入金額が、カートのオーナーのウォレットからアイテムのオーナーのウォレットに移されること。
  #   - カートの中身（Cart#items）のすべてのアイテムのオーナー権限が、カートのオーナーに移されること。
  #   - カートの中身（Cart#items）が空になること。

  # ## ヒント
  #   - カートのオーナーのウォレット ==> self.owner.wallet
  #   - アイテムのオーナーのウォレット ==> item.owner.wallet
  #   - お金が移されるということ ==> (？)のウォレットからその分を引き出して、(？)のウォレットにその分を入金するということ
  #   - アイテムのオーナー権限がカートのオーナーに移されること ==> オーナーの書き換え(item.owner = ?)
end
