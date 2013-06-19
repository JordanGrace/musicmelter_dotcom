jQuery ->
    $('#show_coupon').click ->
        $('#coupon').toggle()
    subscription.setupForm()

# Stripe card prevalidation routine
subscription =
    setupForm: ->
        $('#new_business_account').submit ->
            $('input[type=submit]').attr('disabled', 'disabled')
            status = subscription.checkErrors()
            if status == true
                subscription.processCard()
            else
                $('input[type=submit]').attr('disabled', 'enabled')
                false
    processCard: ->
        alert 'processing'
        card =
            number: $('#card_number').val()
            cv: $('#card_code').val()
            expMonth: $('#card_month').val()
            expYear: $('#card_year').val()
        #Stripe.createToken(card, subscription.handleStripeResponse)
    handleStripeResponse: (status, response) ->
        if status == 200
            $('#payment_stripe_token').val(response.id)
            #$('#new_business_account').submit()
         else
            $('#stripe_error').append('<li>' + response.error.message + '<li>')
            $('input[type=submit]').attr('disabled', false)
    
    checkErrors: ->
        $('#error_count').text = ""
        $('#stripe_error').empty()
        $('.user_error').empty()
        card = subscription.checkBio()
        bio = subscription.checkCard()
        return card == 0 && bio == 0
    checkBio: ->
        formErrors = []
        if $('#business_account_name_first').val().length < 1
            formErrors.push("First Name can't be blank")
        if $('#business_account_name_last').val().length < 1
            formErrors.push("Last Name can't be blank")
        if $('#business_account_business').val().length < 1
            formErrors.push("Business Name can't be blank")
        if $('#business_account_email').val().length < 1
            formErrors.push("Email can't be blank")
        if $('#business_account_country').val().length < 1
            formErrors.push("Country can't be blank")
        if $('#business_account_country').val() == "CA" && $('#business_account_postal').val().length() < 5
            formErrors.push("Postal Code can't be blank")
        if formErrors.length > 0
            subscription.displayErrors(formErrors, '.user_error')
        return formErrors.count
    checkCard: ->
        formErrors = []
        d = new Date()
        month = parseInt($('#card_month').val())
        year = parseInt($('#card_year').val())
        if $('#card_number').val().length < 10
            formErrors.push ('Card Looks Invalid')
        if $('#card_code').val().length == 0
            formErrors.push ('Missing CV Code')
        if month <= d.getMonth() && year == d.getFullYear()
            formErrors.push ('Card Expired')
        if formErrors.length > 0
            subscription.displayErrors(formErrors, '#stripe_errors')
        return formErrors.count
    displayErrors: (formErrors, region) ->
        for error in formErrors
            do(error) ->
                $(region).append('<li>' + error + '</li>')
        false

