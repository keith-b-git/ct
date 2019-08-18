#!/usr/bin/perl


{
	name  => ClubTriumph,
	'Model::ClubTriumphDB' => {
	    schema_class => 'ClubTriumph::Schema',
	    
	    connect_info => {
	
	        dsn => 'dbi:mysql:clubtriu_mph',
	        user => 'clubtriu_mph',
	        password => '',
	        AutoCommit => q{1},
			RaiseError        => 1,
			mysql_enable_utf8mb4 => 1,
			on_connect_do     => [
				'SET NAMES utf8mb4',
			],
	    }
	},



    'Model::Telegram' => {

        token => 'xxxx', 

		chat_id => '-1001111' 
    },





	'Model::Order' => {
		storename => '222222222',
		username => '222222222',
		interface_url => 'https://test.ipg-online.com/connect/gateway/processing',
		shared_secret => "xxxxxxx"
	},



	'HTML::FormHandlerX::Field::noCAPTCHA' => {
        site_key=>'6LcJ1UcUAAAAAF95uvovlRfHh4CYZaH2T-sX8vxI', #localhost
        secret_key=>'6LcJ1UcUAAAAAORxXQjP0q1_5MzQb3eLN9VIL_c4', #localhost

        },


	'Mapping' => {
		openspace_key => 'xxxxxxxxxxxxxxxxxxxxxx'
	},
	
	'Controller::Root' => {
		require_ssl => 0
	},
	


	'Schema::Result::SMS' => {
		aql_username => 'xxxxxx',
		aql_passord => 'xxxxxx'
	},

}
