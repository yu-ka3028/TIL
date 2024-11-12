# Userクラスの定義
class User
end

# OrderItemクラスの定義
class OrderItem
end



User.new

# ----------------------------------------

class User
  def initialize
    puts 'Initialized.'
  end
end
User.new
#=> Initialized.

# ----------------------------------------

user = User.new
user.initialize
#=> private method `initialize' called for #<User:0x000000015583fa80 ...> (NoMethodError)

# ----------------------------------------

class User
  def initialize(name, age)
    puts "name: #{name}, age: #{age}"
  end
end
User.new #=> wrong number of arguments (given 0, expected 2) (ArgumentError)
User.new('Alice', 20) #=> name: Alice, age: 20



class User
  # インスタンスメソッドの定義
  def hello
    "Hello!"
  end
end

user = User.new
# インスタンスメソッドの呼び出し
user.hello #=> "Hello!"


class User
  def initialize(name)
    # インスタンス作成時に渡された名前をインスタンス変数に保存する
    @name = name
  end

  def hello
    # インスタンス変数に保存されている名前を表示する
    "Hello, I am #{@name}."
  end
end
user = User.new('Alice')
user.hello #=> "Hello, I am Alice."

# ----------------------------------------

class User
  # 省略

  def hello
    # shuffled_nameはローカル変数
    shuffled_name = @name.chars.shuffle.join
    "Hello, I am #{shuffled_name}."
  end
end
user = User.new('Alice')
user.hello #=> "Hello, I am cieAl."

# ----------------------------------------

class User
  # 省略

  def hello
    # わざとローカル変数への代入をコメントアウトする
    # shuffled_name = @name.chars.shuffle.join
    "Hello, I am #{shuffled_name}."
  end
end
user = User.new('Alice')
# いきなりshuffled_nameを参照したのでエラーになる
user.hello
#=> undefined local variable or method `shuffled_name' for #<User:0x000000014718d4e8 ...> (NameError)

# ----------------------------------------

class User
  def initialize(name)
    # わざとインスタンス変数への代入をコメントアウトする
    # @name = name
  end

  def hello
    "Hello, I am #{@name}."
  end
end
user = User.new('Alice')
# @nameを参照するとnilになる（つまり名前の部分に何も出ない）
user.hello #=> "Hello, I am ."

# ----------------------------------------

class User
  def initialize(name)
    @name = name
  end

  def hello
    # 間違って@nameを@mameと書いてしまった！（@mameはnilになる）
    "Hello, I am #{@mame}."
  end
end
user = User.new('Alice')
# タイプミスに気づいていないと、名前が出ないことにビックリするはず
user.hello #=> "Hello, I am ."

# ----------------------------------------

class User
  def initialize(name)
    @name = name
  end

  # @nameを外部から参照するためのメソッド
  def name
    @name
  end
end
user = User.new('Alice')
# nameメソッドを経由して@nameの内容を取得する
user.name #=> "Alice"

# ----------------------------------------

class User
  def initialize(name)
    @name = name
  end

  # @nameを外部から参照するためのメソッド
  # ゲッターメソッド
  def name
    @name
  end

  # @nameを外部から変更するためのメソッド
  # セッターメソッド
  def name=(value)
    @name = value
  end
end
user = User.new('Alice')
# 変数に代入しているように見えるが、実際はname=メソッドを呼びだしている
user.name = 'Bob'
user.name #=> "Bob"

# ----------------------------------------

class User
  # @nameを読み書きするメソッドが自動的に定義される
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  # nameメソッドやname=メソッドを明示的に定義する必要がない
end
user = User.new('Alice')
# @nameを変更する
user.name = 'Bob'
# @nameを参照する
user.name #=> "Bob"

# ----------------------------------------

class User
  # 読み取り用のメソッドだけを定義する
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
user = User.new('Alice')
# @nameの参照はできる
user.name #=> "Alice"

# @nameを変更しようとするとエラーになる
user.name = 'Bob'
#=> undefined method `name=' for #<User:0x0000000158bc7b50 ...> (NoMethodError)

# ----------------------------------------

class User
  # 書き込み用のメソッドだけを定義する
  attr_writer :name

  def initialize(name)
    @name = name
  end
end
user = User.new('Alice')
# @nameは変更できる
user.name = 'Bob'

# @nameの参照はできない
user.name
#=> undefined method `name' for #<User:0x0000000143ad1c60 ...> (NoMethodError)

# ----------------------------------------

class User
  # @nameと@ageへのアクセサメソッドを定義する
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end
user = User.new('Alice', 20)
user.name #=> "Alice"
user.age = 30

# class User
#   calss << self
#     def A
#     end
#     def B
#     end
#   end
# end

class User
  def A
    @user = user
  end
  def self.B
  end
  def C
    people = 'Nagaji'
  end
  A.user
  
end




User.hello #=> "Hello!"


class User
  def initialize(name)
    @name = name
  end

  # これはインスタンスメソッド
  def hello
    # @nameの値はインスタンスによって異なる
    "Hello, I am #{@name}."
  end
end
alice = User.new('Alice')
# インスタンスメソッドはインスタンス（オブジェクト）に対して呼び出す
alice.hello #=> "Hello, I am Alice."

bob = User.new('Bob')
# インスタンスによって内部のデータが異なるので、helloメソッドの結果も異なる
bob.hello   #=> "Hello, I am Bob."

# ----------------------------------------

class User
  def initialize(name)
    @name = name
  end

  # self.を付けるとクラスメソッドになる
  def self.create_users(names)
    # mapメソッドを忘れた人は「4.4.1 map/collect」の項を参照
    names.map do |name|
      User.new(name)
    end
  end

  # これはインスタンスメソッド
  def hello
    "Hello, I am #{@name}."
  end
end

names = ['Alice', 'Bob', 'Carol']
# クラスメソッドの呼び出し
users = User.create_users(names)
users.each do |user|
  # インスタンスメソッドの呼び出し
  puts user.hello
end
#=> Hello, I am Alice.
#   Hello, I am Bob.
#   Hello, I am Carol.


class Product
  # デフォルトの価格を定数として宣言する
  DEFAULT_PRICE = 0

  attr_reader :name, :price

  # 第2引数priceのデフォルト値を定数DEFAULT_PRICE（つまり0）とする
  def initialize(name, price = DEFAULT_PRICE)
    @name = name
    @price = price
  end
end

product = Product.new('A free movie')
product.price #=> 0

# ----------------------------------------

# 定数名の例
DEFAULT_PRICE = 0
UNITS = { m: 1.0, ft: 3.28, in: 39.37 }

# ----------------------------------------

class Product
  DEFAULT_PRICE = 0

  def self.default_price
    # クラスメソッドから定数を参照する
    DEFAULT_PRICE
  end

  def default_price
    # インスタンスメソッドから定数を参照する
    DEFAULT_PRICE
  end
end

Product.default_price #=> 0

product = Product.new
product.default_price #=> 0