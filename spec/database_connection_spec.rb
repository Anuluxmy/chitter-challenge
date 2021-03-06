require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'chitterweb_test')

      DatabaseConnection.setup('chitterweb_test')
    end

    it 'this connection is persistent' do
      connection = DatabaseConnection.setup('chitterweb_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end
end
