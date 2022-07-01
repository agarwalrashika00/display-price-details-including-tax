class Tax
    YES_REGEXP = /y|yes/i.freeze
    def sales_tax(sales_tax_exempted, price)
      if YES_REGEXP.match? sales_tax_exempted
        0
      else
        price * 0.1
      end
    end
  
    def import_duty(imported, price)
      if YES_REGEXP.match? imported
        0.05 * price
      else
        0
      end
    end
  end
  
  # products class to store a list of all products added
  class Products
    attr_reader :list
    def initialize
      @list = []
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
  class Product < Products
    attr_reader :product, :price, :sales_tax, :import_duty
    def initialize(product, price, sales_tax, import_duty)
      @product = product
      @price = price
      @sales_tax = sales_tax
      @import_duty = import_duty
    end
  
    def self.add_new_product(product, imported, sales_tax_exempted, price, all_products)
      sales_tax = Tax.new.sales_tax(sales_tax_exempted, price)
      import_duty = Tax.new.import_duty(imported, price)
      all_products.list << new(product, price, sales_tax, import_duty)
    end
  end
  
  # class InputDetails to input and store details from user
  class InputDetails
    def get_product_details
      add_item = true
      all_products = Products.new
      while add_item
        puts 'Name of the product: '
        product = gets.chomp
        puts 'Imported?: '
        imported = gets.chomp
        puts 'Exempted from sales tax? '
        sales_tax_exempted = gets.chomp
        puts 'Price: '
        price = gets.chomp.to_f
        Product.add_new_product(product, imported, sales_tax_exempted, price, all_products)
  
        puts 'Do you want to add more items to your list(y/n): '
        add_item = gets.chomp == 'y'
      end
      all_products
    end
  end
  
  all_products = InputDetails.new.get_product_details
  all_products.show_list