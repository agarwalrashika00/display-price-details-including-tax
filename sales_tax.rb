  # products class to store a list of all products added
  class Cart
    attr_reader :list
    def initialize
      @list = []
    end

    def add_product(product)
      list << product
    end
  
    def show_list
      grand_total = 0
      puts 'PRODUCT'.ljust(15) + '|' + 'PRICE'.ljust(7) + '|' + 'SALES TAX'.ljust(11) + '|' + 'IMPORT DUTY'.ljust(12) + '|TOTAL PRICE'
      list.each do |item|
        total_price = item.price + item.sales_tax + item.import_duty
        puts "#{item.product.ljust(15)}|#{item.price.to_s.ljust(7)}|#{item.sales_tax.to_s.ljust(11)}|#{item.import_duty.to_s.ljust(12)}|#{total_price}"
        grand_total += total_price
      end
      puts "GRAND TOTAL = #{grand_total}".rjust(54)
    end
  end
  
  # product class to handle individual product
  class Product
    YES_REGEXP = /y|yes/i.freeze
    attr_reader :product, :price, :sales_tax, :import_duty
    def initialize(product, price, sales_tax_exempted, imported)
      @product = product
      @price = price
      @sales_tax = calc_sales_tax(sales_tax_exempted, price)
      @import_duty = calc_import_duty(imported, price)
    end
  
    def calc_sales_tax(sales_tax_exempted, price)
      (YES_REGEXP.match? sales_tax_exempted) ? 0 : price * 0.1
    end

    def calc_import_duty(imported, price)
      (YES_REGEXP.match? imported) ? 0.05 * price : 0
    end
  end
  
  # class InputDetails to input and store details from user
  class InputDetails
    def get_product_details
      add_item = true
      product_list = Cart.new
      while add_item
        puts 'Name of the product: '
        product = gets.chomp
        puts 'Imported?: '
        imported = gets.chomp
        puts 'Exempted from sales tax? '
        sales_tax_exempted = gets.chomp
        puts 'Price: '
        price = gets.chomp.to_f
        product_list.add_product (Product.new(product, price, sales_tax_exempted, imported))

        puts 'Do you want to add more items to your list(y/n): '
        add_item = gets.chomp == 'y'
      end
      product_list
    end
  end
  
  product_list = InputDetails.new.get_product_details
  product_list.show_list