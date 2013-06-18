# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
    subscription.setupForm()
    $('#show_coupon').click ->
        $('#coupon').toggle()
subscription =
    setupForm: ->
        $('#new_business_account').submit ->
            $('input[type=submit]').attr('disabled', true)
            subscription.processCard()
            return false

    processCard: ->
        alert('hi from process card')
        card =
            number: $('#card_number').val()
            cv: $('#card_code').val()
            expMonth: $('#card_month').val()
            expYear: $('#card_year').val()
        Stripe.createToken(card, subscription.handleStripeResponse)

    handleStripeResponse: (status, response) ->
        alert('hi from handle response')
        $form = $('#new_business_account')

        if status == 200
            $('#payment_stripe_token').val(response.id)
            $('#new_payment')[0].submit()
        else
            $('#stripe_error').text(response.error.message)
            $('input[type=submit]').attr('disabled', false)