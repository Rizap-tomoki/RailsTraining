require 'csv'

desc 'CSVファイルから個人情報をインポートする'
task :users, [:file_path] => :environment do |task, args|
  file_path = args.file_path
  convert_sex_to_enum = { '男' => 'male', '女' => 'female'}
  begin
    User.transaction do
      CSV.foreach(file_path, headers: true) do |row|
        User.create!(
          name: row['namae'],
          hiragana_nama: row['rubi'],
          sex: convert_sex_to_enum[row['seibetu']],
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
        ), validate: false
      end
      puts "CSVのインポートが成功しました！"
    end
  rescue => e
    puts "CSVの出力に失敗しました: #{e.message}"
  end
end