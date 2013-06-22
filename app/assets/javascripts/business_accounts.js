    $('#credit').click(function(){
      var token = function(res){
        var $input = $('<input type=hidden name=business_account[stripe_token] />').val(res.id);
        $('form').append($input).submit();
      };

      StripeCheckout.open({
        key:         '',
        amount:      60000,
        currency:    'usd',
        name:        'Music Melter',
        description: 'A bag of Pistachios',
        panelLabel:  'Business Registration',
        token:       token
      });

      return false;
    });

