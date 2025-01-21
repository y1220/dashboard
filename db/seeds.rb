# # # db/seeds.rb

# # # Clear existing data
# # puts "Clearing existing data..."
# # RetentionRate.delete_all
# # Communication.delete_all
# # Patient.delete_all
# # PersonalityType.delete_all

# # # Create personality types
# # puts "Creating personality types..."
# # personality_types = {
# #   analytical: PersonalityType.create!(name: 'Analytical'),
# #   empathetic: PersonalityType.create!(name: 'Empathetic'),
# #   direct: PersonalityType.create!(name: 'Direct')
# # }

# # # Helper method to generate realistic timestamps
# # def random_time(from: 6.months.ago, to: Time.current)
# #   Time.at(from + rand * (to.to_f - from.to_f))
# # end

# # # Helper method to generate realistic email
# # def generate_email(name)
# #   domain = ['gmail.com', 'yahoo.com', 'outlook.com', 'example.com'].sample
# #   "#{name.downcase.gsub(/\s+/, '.')}_#{rand(100..999)}@#{domain}"
# # end

# # # Helper method to generate realistic names
# # def generate_name
# #   first_names = ['James', 'Mary', 'John', 'Patricia', 'Robert', 'Jennifer', 'Michael', 'Linda', 'William', 'Elizabeth',
# #                  'David', 'Barbara', 'Richard', 'Susan', 'Joseph', 'Jessica', 'Thomas', 'Sarah', 'Charles', 'Karen']
# #   last_names = ['Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez',
# #                 'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin']
# #   "#{first_names.sample} #{last_names.sample}"
# # end

# # # Create patients
# # puts "Creating patients..."
# # 300.times do |i|
# #   name = generate_name
# #   personality = personality_types.values.sample

# #   Patient.create!(
# #     name: name,
# #     email: generate_email(name),
# #     personality_type: personality,
# #     created_at: random_time(from: 1.year.ago)
# #   )
# # end

# # # Communication content templates
# # email_templates = [
# #   "Following up on your recent appointment...",
# #   "Important information about your upcoming visit...",
# #   "Your test results are ready...",
# #   "Appointment confirmation for {date}...",
# #   "Quick question about your recent visit...",
# #   "Updates to your treatment plan...",
# #   "Reminder about your medication schedule...",
# #   "Thank you for your recent feedback..."
# # ]

# # # Create communications
# # puts "Creating communications..."
# # Patient.find_each do |patient|
# #   # Generate between 5-15 communications per patient
# #   rand(5..15).times do
# #     created_at = random_time(from: patient.created_at)

# #     # Determine sentiment based on personality type
# #     sentiment_weights = case patient.personality_type.name
# #                        when 'Analytical'
# #                          { positive: 0.6, neutral: 0.3, negative: 0.1 }
# #                        when 'Empathetic'
# #                          { positive: 0.7, neutral: 0.2, negative: 0.1 }
# #                        when 'Direct'
# #                          { positive: 0.5, neutral: 0.3, negative: 0.2 }
# #                        end

# #     sentiment = sentiment_weights.max_by { |_, weight| rand ** (1.0 / weight) }.first

# #     # Determine channel based on personality type
# #     channel_weights = case patient.personality_type.name
# #                      when 'Analytical'
# #                        { email: 0.6, sms: 0.2, phone: 0.2 }
# #                      when 'Empathetic'
# #                        { email: 0.2, sms: 0.3, phone: 0.5 }
# #                      when 'Direct'
# #                        { email: 0.3, sms: 0.4, phone: 0.3 }
# #                      end

# #     channel = channel_weights.max_by { |_, weight| rand ** (1.0 / weight) }.first

# #     # Generate realistic response time based on channel and personality
# #     base_response_time = case channel
# #                         when :email then rand(1..8)
# #                         when :sms then rand(0.5..4)
# #                         when :phone then rand(0.1..1)
# #                         end

# #     # Adjust response time based on personality type
# #     personality_modifier = case patient.personality_type.name
# #                          when 'Analytical' then 1.2
# #                          when 'Empathetic' then 0.8
# #                          when 'Direct' then 0.7
# #                          end

# #     response_time = base_response_time * personality_modifier

# #     Communication.create!(
# #       patient: patient,
# #       content: email_templates.sample.gsub('{date}', (created_at + rand(1..30).days).strftime('%B %d')),
# #       channel: channel,
# #       sentiment: sentiment,
# #       response_time: response_time,
# #       created_at: created_at
# #     )
# #   end
# # end

# # # Create retention rates
# # puts "Creating retention rates..."
# # personality_types.each do |type, personality_type|
# #   # Different base retention curves for each personality type
# #   base_retention = case type
# #                   when :analytical
# #                     [100, 85, 78, 72, 68, 65]
# #                   when :empathetic
# #                     [100, 90, 85, 82, 80, 78]
# #                   when :direct
# #                     [100, 82, 75, 70, 65, 60]
# #                   end

# #   # Add some random variation to make it more realistic
# #   6.times do |month|
# #     variation = rand(-2.0..2.0)
# #     rate = base_retention[month] + variation

# #     RetentionRate.create!(
# #       personality_type: personality_type,
# #       month: month + 1,
# #       rate: rate
# #     )
# #   end
# # end

# # # Create some summary statistics
# # puts "\nSeed Data Summary:"
# # puts "------------------------"
# # puts "Total Patients: #{Patient.count}"
# # puts "Total Communications: #{Communication.count}"
# # puts "Average Response Time: #{Communication.average(:response_time).round(2)} hours"
# # puts "Communications by Channel:"
# # Communication.group(:channel).count.each do |channel, count|
# #   puts "  #{channel}: #{count}"
# # end
# # puts "Communications by Sentiment:"
# # Communication.group(:sentiment).count.each do |sentiment, count|
# #   puts "  #{sentiment}: #{count}"
# # end
# # puts "Patients by Personality Type:"
# # PersonalityType.all.each do |type|
# #   puts "  #{type.name}: #{type.patients.count}"
# # end
# # puts "\nSeeding completed successfully!"

# # require 'faker'

# # # Define possible genders
# # genders = ['Male', 'Female', 'Other']

# # # Update existing patients with random gender and birthday
# # Patient.find_each do |patient|
# #   patient.update(
# #     gender: genders.sample,
# #     birthday: Faker::Date.between(from: 70.years.ago, to: 50.years.ago)
# #   )
# # end

# # puts "Updated #{Patient.count} patients with random gender and birthday."
# # db/seeds.rb

# # db/seeds.rb

# # Clear existing data
# puts "Clearing existing data..."
# QuestionOption.delete_all
# Question.delete_all
# Questionnaire.delete_all

# # Create questionnaire
# puts "Creating questionnaire..."
# questionnaire = Questionnaire.create!(title: 'PILOT_Survey_Personas')

# # Define questions
# questions = [
#   {
#     record_id: '[record_id_4506d8]',
#     field_key: 'record_id',
#     field_label: 'Record ID',
#     field_type: 'text',
#     options: nil,
#     required: false
#   },
#   {
#     record_id: '[gender_3eb096]',
#     field_key: 'gender',
#     field_label: 'Genere',
#     field_type: 'dropdown',
#     options: '1: Maschio, 2: Femmina, 3: Altro, 4: Preferisco non specificarlo',
#     required: true
#   },
#   {
#     record_id: '[age_b7e6d4]',
#     field_key: 'age',
#     field_label: 'Quanti anni hai?',
#     field_type: 'text',
#     options: nil,
#     required: true
#   },
#   {
#     record_id: '[titstud_ea8670]',
#     field_key: 'education_level',
#     field_label: 'Titolo di studio',
#     field_type: 'dropdown',
#     options: '5: Diploma scuola elementare, 8: Diploma scuola media inferiore, 13: Diploma scuola media superiore, 18: Laurea vecchio ordinamento/Laurea Magistrale, 16: Laurea Triennale, 22: Specializzazione, 21: Dottorato di ricerca',
#     required: true
#   },
#   {
#     record_id: '[marital_status_8e152d]',
#     field_key: 'marital_status',
#     field_label: 'Indica il tuo stato civile',
#     field_type: 'dropdown',
#     options: '1: Coniugato/Convivente, 2: Celibe/Nubile, 3: Divorziato/Separato, 4: Vedovo/Vedova',
#     required: true
#   },
#   {
#     record_id: '[vivi_fa115f]',
#     field_key: 'living_arrangement',
#     field_label: 'Con chi vivi?',
#     field_type: 'checkbox',
#     options: '1: Coniuge/Convivente, 2: Figlio/Figlia, 3: Genitori, 4: Altro familiare, 5: Badante, 6: Altra persona non familiare, 7: Da solo',
#     required: true
#   },
#   {
#     record_id: '[son_f815da]',
#     field_key: 'children_count',
#     field_label: 'Quanti figli hai?',
#     field_type: 'dropdown',
#     options: '0, 1, 2, 3 o più',
#     required: true
#   }
# ]

# # Create questions and question options
# puts "Creating questions and question options..."
# questions.each do |question|
#   created_question = Question.create!(
#     questionnaire: questionnaire,
#     record_id: question[:record_id],
#     field_key: question[:field_key],
#     field_label: question[:field_label],
#     field_type: question[:field_type],
#     required: question[:required]
#   )

#   if question[:options].present?
#     options = question[:options].split(',').map(&:strip)
#     options.each do |option|
#       field_value, content = option.split(':').map(&:strip)
#       QuestionOption.create!(
#         question: created_question,
#         field_value: field_value,
#         content: content
#       )
#     end
#   end
# end

# puts "Seeding completed successfully!"
# db/seeds.rb

# Clear existing answers if needed
puts "Clearing existing answers..."
Answer.destroy_all

def weighted_random(weights)
  total = weights.sum
  point = rand(total)

  weights.each_with_index do |weight, index|
    return index + 1 if point < weight
    point -= weight
  end
end

# Cache questions and their options to avoid multiple DB queries
puts "Caching questions and options..."
question_cache = {}
option_cache = {}

Question.includes(:question_options).find_each do |question|
  question_cache[question.record_id] = question

  # Cache options by field_value for each question
  if question.question_options.any?
    option_cache[question.record_id] = question.question_options.index_by(&:field_value)
  end
end

puts "Starting to create answers..."
total_patients = Patient.count
current_patient = 0

# Create answers for each patient
ActiveRecord::Base.transaction do
  Patient.find_each do |patient|
    current_patient += 1
    print "\rProcessing patient #{current_patient}/#{total_patients}"

    # Generate core demographic data first
    age = rand(50..70)
    gender = rand(1..3)

    answers = {}

    # Process each question in order
    question_cache.each do |record_id, question|
      answer = Answer.new(
        question_id: question.id,
        patient_id: patient.id
      )

      case question.field_key
      when 'record_id'
        answer.text_value = "P#{patient.id}"

      when 'gender'
        answer.option_id = rand(1..4)

      when 'age'
        answer.numerical_value = Time.current.year - patient.birthday.year

      when 'education_level'
        answer.option_id = [5, 8, 13, 16, 18, 21, 22].sample

      when 'marital_status'
        answer.option_id = rand(1..6)

      when 'living_arrangement'
        answer.option_id = rand(1..7)

      when 'children_count'
        answer.option_id = rand(0..3)

      end

      answer.save!
    end
  end
end

puts "\nCompleted creating answers!"
