class HashMap
  attr_accessor :buckets, :head, :loadFactor

  def initialize
    @buckets = Array.new(16)
    @loadFactor = 0.75
  end

  def hash(key)
    hash_code = 0
    prime_number = 5
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % 16
  end

  def set(key, value)
    h = { key => value }
    if !buckets[hash(key)].nil?
      if buckets[hash(key)].keys == h.keys
        buckets[hash(key)] = h
        self
      else
        buckets[hash(key)].store(key, value)
        self
      end
    else
      buckets[hash(key)] = h
      self
    end
  end

  def get(key, tempHash = {})
    if buckets[hash(key)].nil?
      nil
    elsif buckets[hash(key)].key?("#{key}")
      tempHash = buckets[hash(key)]
      for element in tempHash
        return element[1] if element[0] == key
      end
    else
      buckets[hash(key)]
    end
  end

  def has(key)
    if buckets[hash(key)].nil?
      false
    elsif buckets[hash(key)].key?("#{key}")
      true
    end
  end

  def remove(key, tempHash = {})
    if buckets[hash(key)].nil?
      nil
    elsif buckets[hash(key)].key?("#{key}")
      len = buckets[hash(key)].size
      if len > 1
        tempHash = buckets[hash(key)]
        for element in tempHash
          if element[0] == key
            tempHash.delete(element[0])
            return self
          end
        end
      else
        buckets.delete_at(hash(key))
        self
      end
    end
  end

  def length(temp = 0)
    arr = buckets
    for element in arr
      if element.class == Hash
        temp = element.length + temp
      elsif !element.nil?
        temp += 1
      end
    end
    temp
  end

  def clear
    self.buckets = Array.new(16)
    self
  end

  def keys(tempArr = [])
    arr = buckets
    for element in arr
      tempArr.push(element.keys) unless element.nil?
    end
    tempArr.flatten
  end

  def values(tempArr = [])
    arr = buckets
    for element in arr
      tempArr.push(element.values) unless element.nil?
    end
    tempArr.flatten
  end

  def entries(tempHash = {})
    arr = buckets
    for element in arr
      next if element.nil?

      len = element.length
      if len > 1
        for i in 0..len - 1
          tempHash.store(element.keys[i], element.values[i])
        end
      else
        tempHash.store(element.keys, element.values)
      end
    end
    tempHash
  end

end

h = HashMap.new
h.set('andi', 'my value')
h.set('dani', 'my 2ndvalue')
h.set('nithin', 'my 3rdvalue')
h.set('nihtin', 'my 4rdvalue')
h.set('andi', 'my 5thvalue')
h.set('nihnit', 'my 7th value')
h.set('nhniit', 'my 8th value')
h.get('nhniit')
h.has('andi')
h.remove('andi')
h.set('andi', 'my 5thvalue')
h.length
# p h.clear()
h.keys
h.values
p h.entries
