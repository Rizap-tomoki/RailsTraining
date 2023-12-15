require 'csv'

desc 'CSVファイルから個人情報をインポートする'
task users: :environment do
  file_path = 'lib/tasks/personal_infomation.csv'

  User.transaction do
    CSV.foreach(file_path, headers: true) do |row|
    
    convert_gender_to_enum = { '男' => 'male', '女' => 'female'}
      sex = convert_gender_to_enum[row['seibetu']]
      user = User.create!(
        name: row['namae'],
        hiragana_nama: row['rubi'],
        sex: sex,
        tel: row['denwa'],
        mobile: row['keitai'],
        mail: row['mairu'],
        postcode: row['yuubinbango'],
        address1: row['jusho1'],
        address2: row['jusho2'],
        address3: row['jusho3'],
        address4: row['jusho4'],
        address5: row['jusho5'],
        birthday: row['tanjobi']
      )
      if user.invalid?
        puts "CSVのインポートに失敗しました: #{user.errors.full_messages.join(', ')}"
      end
    end
  end
  puts "CSVのインポートが成功しました！"
end