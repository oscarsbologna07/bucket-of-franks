source =['0-1',
 '0-10',
 '0-17',
 '0-18',
 '0-19',
 '0-20',
 '0-4',
 '0-5',
 '0-9',
 '1-14',
 '10-19',
 '100+',
 '11-20',
 '13-18',
 '15-24',
 '18-24',
 '18-29',
 '18-35',
 '18-49',
 '18-59',
 '19-24',
 '19-30',
 '19-64',
 '20-24',
 '20-29',
 '20-44',
 '21-30',
 '25-29',
 '25-34',
 '25-44',
 '25-49',
 '30-34',
 '30-39',
 '31-40',
 '35-39',
 '35-44',
 '36-49',
 '40-44',
 '40-49',
 '41-50',
 '45-49',
 '45-54',
 '45-64',
 '5-12',
 '5-14',
 '5-17',
 '50+',
 '50-54',
 '50-59',
 '50-64',
 '51-60',
 '55-59',
 '55-64',
 '6-19',
 '60+',
 '60-64',
 '60-69',
 '61-70',
 '64+',
 '65+',
 '65-69',
 '65-74',
 '65-84',
 '70+',
 '70-74',
 '70-79',
 '71-80',
 '75-79',
 '75-84',
 '80+',
 '80-89',
 '81+',
 '85+',
 '90-99',
 'Missing',
 'Unknown',
 'pending']

def invalid_integer?(integer)
  integer.match? /\D/ or
  integer.match? /\d*\+/
end

range_list = source.map do |value|
  value_tuple = value.split("-")

  valid_integer_ranges = value_tuple.map { _1 if !invalid_integer?(_1) }

  valid_integer_ranges.compact.map { _1.to_i }
end.reject { _1.empty? }

grouped_range_list = range_list.group_by { _1.first }
sorted_range_list = grouped_range_list.sort_by { _1.first }

result = sorted_range_list.map do |key, value|
  [key, value.map { _1.last }.max]
end

require "csv"

CSV.open("age_buckets.csv", "wb") do |csv|
  result.each do
    csv << [_1, _2]
  end
end

pp result
