repeat_count = 3
group_count = 5

names = File.readlines('name.txt').map(&:strip)

name_count_state = {}
last_group = []
repeat_count.times do |i|
  tmp_names = names.dup
  p "第#{i + 1}次"
  if last_group.count > 0 && last_group.count < group_count
    while last_group.count < group_count
      candidate = tmp_names.shuffle.first
      next if last_group.include?(candidate)
      tmp_names -= [candidate]
      
      p "candidate: #{candidate}"
      last_group << candidate
      tmp_names -= [candidate]

      name_count_state[candidate] = name_count_state[candidate] ? name_count_state[candidate] + 1 : 1
    end
    puts "補齊: #{last_group}"
  end

  tmp_names.shuffle.each_slice(group_count).with_index do |group, index|
    puts "第#{index + 1}組: #{group}"
    group.each do |name|
      name_count_state[name] = name_count_state[name] ? name_count_state[name] + 1 : 1
    end
    last_group = group
  end

  # puts "name_count_state: #{name_count_state}, size: #{name_count_state.size}"
end

