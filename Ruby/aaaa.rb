# ユーザーのデータを作成する
users = []
users << { first_name: 'Alice', last_name: 'Ruby', age: 20 }
users << { first_name: 'Bob', last_name: 'Python', age: 30 }

# ユーザーのデータを表示する
users.each do |user|
  puts "氏名: #{user[:first_name]} #{user[:last_name]}、年齢: #{user[:age]}"
end
#=> 氏名: Alice Ruby、年齢: 20
#   氏名: Bob Python、年齢: 30

# ----------------------------------------

# ユーザーのデータを作成する
users = []
users << { first_name: 'Alice', last_name: 'Ruby', age: 20 }
users << { first_name: 'Bob', last_name: 'Python', age: 30 }

# 氏名を作成するメソッド
def full_name(user)
  "#{user[:first_name]} #{user[:last_name]}"
end

# ユーザーのデータを表示する
users.each do |user|
  puts "氏名: #{full_name(user)}、年齢: #{user[:age]}"
end
#=> 氏名: Alice Ruby、年齢: 20
#   氏名: Bob Python、年齢: 30

# ----------------------------------------

users[0][:first_name] #=> "Alice"

# ハッシュだとタイプミスしてもnilが返るだけなので不具合に気づきにくい
users[0][:first_mame] #=> nil

# ----------------------------------------

# 勝手に新しいキーを追加
users[0][:country] = 'japan'
# 勝手にfirst_nameを変更
users[0][:first_name] = 'Carol'
# ハッシュの中身が変更される
users[0] #=> {:first_name=>"Carol", :last_name=>"Ruby", :age=>20, :country=>"japan"}

# ----------------------------------------

# Userクラスを定義する
class User
  attr_reader :first_name, :last_name, :age

  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end
end

# ユーザーのデータを作成する
users = []
users << User.new('Alice', 'Ruby', 20)
users << User.new('Bob', 'Python', 30)

# 氏名を作成するメソッド
def full_name(user)
  "#{user.first_name} #{user.last_name}"
end

# ユーザーのデータを表示する
users.each do |user|
  puts "氏名: #{full_name(user)}、年齢: #{user.age}"
end
#=> 氏名: Alice Ruby、年齢: 20
#   氏名: Bob Python、年齢: 30

# ----------------------------------------

users[0].first_name #=> "Alice"

users[0].first_mame
#=> undefined method `first_mame' for #<User:0x000000015583fa80 ...> (NoMethodError)

# ----------------------------------------

# 勝手に属性を追加できない
users[0].country = 'japan'
#=> undefined method `country=' for #<User:0x000000015583fa80 ...> (NoMethodError)

# 勝手にfirst_nameを変更できない
users[0].first_name = 'Carol'
#=> undefined method `first_name=' for #<User:0x000000015583fa80 ...> (NoMethodError)

# ----------------------------------------

# Userクラスを定義する
class User
  attr_reader :first_name, :last_name, :age

  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  # 氏名を作成するメソッド
  def full_name
    "#{first_name} #{last_name}"
  end
end

# ユーザーのデータを作成する
users = []
users << User.new('Alice', 'Ruby', 20)
users << User.new('Bob', 'Python', 30)

# ユーザーのデータを表示する
users.each do |user|
  puts "氏名: #{user.full_name}、年齢: #{user.age}"
end
#=> 氏名: Alice Ruby、年齢: 20
#   氏名: Bob Python、年齢: 30


# 「Alice Rubyさん、20歳」というユーザーのオブジェクトを作成する
alice = User.new('Alice', 'Ruby', 20)
# 「Bob Pythonさん、30歳」というユーザーのオブジェクトを作成する
bob = User.new('Bob', 'Python', 30)

# どちらもfull_nameメソッドを持つが、保持しているデータが異なるので戻り値は異なる
alice.full_name
#-> "Alice Ruby"

bob.full_name
#-> "Bob Python"

# ----------------------------------------

user = User.new('Alice', 'Ruby', 20)
user.first_name

# ----------------------------------------

user = User.new('Alice', 'Ruby', 20)
user.first_name

# ----------------------------------------

class User
  # first_nameの読み書きを許可する
  attr_accessor :first_name
  # 省略
end
user = User.new('Alice', 'Ruby', 20)
user.first_name #=> "Alice"
# first_nameを変更する
user.first_name = 'ありす'
user.first_name #=> "ありす"