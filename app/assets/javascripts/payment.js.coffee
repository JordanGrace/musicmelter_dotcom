# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
    subscription.setupForm()

subscription =
    setupForm: ->
        $('#new_payment').submit ->
            $('input[type=submit]').attr('disabled', true)
            if $('#card_number').length == 0
                $('#new_payment')[0].submit()
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
        $form = $('#new_payment')

        if status == 200
            $('#payment_stripe_card_token').val(response.id)
            $('#new_payment')[0].submit()
        else
            $('#stripe_error').text(response.error.message)
            $('input[type=submit]').attr('disabled', false)
