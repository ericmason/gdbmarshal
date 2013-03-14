require 'gdbm'

class GDBMarshal < GDBM
  def [](key)
    unmarshal(super(key))
  end

  def []=(key, val)
    super(key, marshal(val))
  end

  # def first
  #   unmarshal(super)
  # end

  def each
    super do |vals|
      yield [vals[0], unmarshal(vals[1])]
    end
  end

  def each_value
    super do |val|
      yield unmarshal(val)
    end
  end

  def fetch(*args)
    unmarshal(super(*args))
  end

  def has_value?(v)
    super(marshal(v))
  end

  def invert
    raise "Not implemented"
  end

  def key(value)
    super(marshal(value))
  end

  def reject(&block)
    Hash[super(&block).map {|k, v| [k, unmarshal(v)]}]
  end

  def delete_if
    super do |key, value|
      yield(key, unmarshal(value))
    end
  end

  def replace(other)
    self.clear
    other.each_pair do |key, value|
      self[key] = value
    end
  end

  def select
    super do |key, value| 
      yield key, unmarshal(value)
    end
  end

  def shift
    key, value = super
    [key, unmarshal(value)]
  end

  def store(key, value)
    super(key, marshal(value))
  end

  def to_a
    super.map {|key, value| [key, unmarshal(value)]}  
  end

  def to_hash
    Hash[self.to_a]
  end

  def update(other)
    other.each_pair do |key, value|
      self[key] = value
    end
  end

  def has_value?(v)
    super(marshal(value))
  end

  def values
    super.map {|v| unmarshal(v)}
  end

  def values_at(*keys)
    super(*keys).map {|v| unmarshal(v)}
  end

  private
  def marshal(val)
    Marshal.dump(val)
  end

  def unmarshal(val)
    val.nil? ? nil : Marshal.load(val) 
  end
end