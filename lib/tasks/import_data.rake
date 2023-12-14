require 'csv'

desc 'CSVファイルから個人情報をインポートする'
task :users => :environment do
  file_path = 'lib/tasks/personal_infomation.csv'

  User.transaction do
    CSV.foreach(file_path, headers: true) do |row|
      user = User.create!(
        name: row['namae'],
        hiragana_nama: row['rubi'],
        sex: row['seibetu'],
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

      unless user.valid?
        puts "CSVの出力に失敗しました: #{user.errors.full_messages.join(', ')}"
        raise ActiveRecord::Rollback
      end
    end
    puts "CSVのインポートが成功しました！"
  end
end