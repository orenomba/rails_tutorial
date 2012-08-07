#http://d.hatena.ne.jp/fujisan3776/20110701/1309478262

class ActiveModelBase
  include ActiveModel::Validations
  include ActiveModel::Conversion

  def persisted? ; false ; end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) rescue nil
    end
  end
end