# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
RetentionRate.delete_all
Communication.delete_all
Patient.delete_all
PersonalityType.delete_all

# Create personality types
puts "Creating personality types..."
personality_types = {
  analytical: PersonalityType.create!(name: 'Analytical'),
  empathetic: PersonalityType.create!(name: 'Empathetic'),
  direct: PersonalityType.create!(name: 'Direct')
}

# Helper method to generate realistic timestamps
def random_time(from: 6.months.ago, to: Time.current)
  Time.at(from + rand * (to.to_f - from.to_f))
end

# Helper method to generate realistic email
def generate_email(name)
  domain = ['gmail.com', 'yahoo.com', 'outlook.com', 'example.com'].sample
  "#{name.downcase.gsub(/\s+/, '.')}_#{rand(100..999)}@#{domain}"
end

# Helper method to generate realistic names
def generate_name
  first_names = ['James', 'Mary', 'John', 'Patricia', 'Robert', 'Jennifer', 'Michael', 'Linda', 'William', 'Elizabeth',
                 'David', 'Barbara', 'Richard', 'Susan', 'Joseph', 'Jessica', 'Thomas', 'Sarah', 'Charles', 'Karen']
  last_names = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez',
                'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin']
  "#{first_names.sample} #{last_names.sample}"
end

# Create patients
puts "Creating patients..."
300.times do |i|
  name = generate_name
  personality = personality_types.values.sample

  Patient.create!(
    name: name,
    email: generate_email(name),
    personality_type: personality,
    created_at: random_time(from: 1.year.ago)
  )
end

# Communication content templates
email_templates = [
  "Following up on your recent appointment...",
  "Important information about your upcoming visit...",
  "Your test results are ready...",
  "Appointment confirmation for {date}...",
  "Quick question about your recent visit...",
  "Updates to your treatment plan...",
  "Reminder about your medication schedule...",
  "Thank you for your recent feedback..."
]

# Create communications
puts "Creating communications..."
Patient.find_each do |patient|
  # Generate between 5-15 communications per patient
  rand(5..15).times do
    created_at = random_time(from: patient.created_at)

    # Determine sentiment based on personality type
    sentiment_weights = case patient.personality_type.name
                       when 'Analytical'
                         { positive: 0.6, neutral: 0.3, negative: 0.1 }
                       when 'Empathetic'
                         { positive: 0.7, neutral: 0.2, negative: 0.1 }
                       when 'Direct'
                         { positive: 0.5, neutral: 0.3, negative: 0.2 }
                       end

    sentiment = sentiment_weights.max_by { |_, weight| rand ** (1.0 / weight) }.first

    # Determine channel based on personality type
    channel_weights = case patient.personality_type.name
                     when 'Analytical'
                       { email: 0.6, sms: 0.2, phone: 0.2 }
                     when 'Empathetic'
                       { email: 0.2, sms: 0.3, phone: 0.5 }
                     when 'Direct'
                       { email: 0.3, sms: 0.4, phone: 0.3 }
                     end

    channel = channel_weights.max_by { |_, weight| rand ** (1.0 / weight) }.first

    # Generate realistic response time based on channel and personality
    base_response_time = case channel
                        when :email then rand(1..8)
                        when :sms then rand(0.5..4)
                        when :phone then rand(0.1..1)
                        end

    # Adjust response time based on personality type
    personality_modifier = case patient.personality_type.name
                         when 'Analytical' then 1.2
                         when 'Empathetic' then 0.8
                         when 'Direct' then 0.7
                         end

    response_time = base_response_time * personality_modifier

    Communication.create!(
      patient: patient,
      content: email_templates.sample.gsub('{date}', (created_at + rand(1..30).days).strftime('%B %d')),
      channel: channel,
      sentiment: sentiment,
      response_time: response_time,
      created_at: created_at
    )
  end
end

# Create retention rates
puts "Creating retention rates..."
personality_types.each do |type, personality_type|
  # Different base retention curves for each personality type
  base_retention = case type
                  when :analytical
                    [100, 85, 78, 72, 68, 65]
                  when :empathetic
                    [100, 90, 85, 82, 80, 78]
                  when :direct
                    [100, 82, 75, 70, 65, 60]
                  end

  # Add some random variation to make it more realistic
  6.times do |month|
    variation = rand(-2.0..2.0)
    rate = base_retention[month] + variation

    RetentionRate.create!(
      personality_type: personality_type,
      month: month + 1,
      rate: rate
    )
  end
end

# Create some summary statistics
puts "\nSeed Data Summary:"
puts "------------------------"
puts "Total Patients: #{Patient.count}"
puts "Total Communications: #{Communication.count}"
puts "Average Response Time: #{Communication.average(:response_time).round(2)} hours"
puts "Communications by Channel:"
Communication.group(:channel).count.each do |channel, count|
  puts "  #{channel}: #{count}"
end
puts "Communications by Sentiment:"
Communication.group(:sentiment).count.each do |sentiment, count|
  puts "  #{sentiment}: #{count}"
end
puts "Patients by Personality Type:"
PersonalityType.all.each do |type|
  puts "  #{type.name}: #{type.patients.count}"
end
puts "\nSeeding completed successfully!"

require 'faker'

# Define possible genders
genders = ['Male', 'Female', 'Other']

# Update existing patients with random gender and birthday
Patient.find_each do |patient|
  patient.update(
    gender: genders.sample,
    birthday: Faker::Date.between(from: 70.years.ago, to: 50.years.ago)
  )
end

puts "Updated #{Patient.count} patients with random gender and birthday."
