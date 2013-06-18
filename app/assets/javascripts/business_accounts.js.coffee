# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# jQuery ->
#     account.setupForm()

# account =
#     setupForm: ->
#         form = $('#new_business_account');
#         $('#new_business_account').submit ->
#             account.processForm()
#             false

#     processForm: ->
#         form = $('#new_business_account')
#         required_field_names = ['name_first', 'name_last', 'business',
#                             'email', 'phone', 'address','zip','city','state','type']
            
#         required_fields = (form.elements[name] for name in required_field_names)

#         errors = []
#         for field in required_fields
#           if field.value == ''
#             errors.push field_name

#         console.log(form)
#         alert ('existing processForm')



jQuery ->
    subscription.setupForm()
    $('#show_coupon').click ->
        $('#coupon').toggle()
subscription =
    setupForm: ->
        $('#new_business_account').submit ->
            $('input[type=submit]').attr('disabled', true)
            if $('#card_number').length == 0
                $('#new_business_account')[0].submit()
            subscription.processCard()
            return false;

    processCard: ->
        card =
            number: $('#card_number').val()
            cv: $('#card_code').val()
            expMonth: $('#card_month').val()
            expYear: $('#card_year').val()
        Stripe.createToken(card, subscription.handleStripeResponse)

    handleStripeResponse: (status, response) ->
        $form = $('#new_business_account')

        if status == 200
            $('#payment_stripe_token').val(response.id)
            $('#new_payment')[0].submit()
        else
            $('#stripe_error').text(response.error.message)
            $('input[type=submit]').attr('disabled', false)