jQuery ->
    $('#show_coupon').click ->
        $('#coupon').toggle()
    subscription.setupForm()

#If you're looking for the show_us and show_ca methods - they are at the bottom
# of the form in views/business_accounts/_form.html.erb

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
        formErrors = 0
        if $('#business_account_name_first').val().length < 1
            subscription.displayErrors(" can't be blank", 'label[for=name_first]', 'First Name')
            formErrors += 1
        if $('#business_account_name_last').val().length < 1
            subscription.displayErrors( " can't be blank", 'label[for=last_name]', 'Last Name')
            formErrors += 1
        if $('#business_account_business').val().length < 1
            subscription.displayErrors(" can't be blank", 'label[for=business]', 'Business')
            formErrors += 1
        if $('#business_account_email').val().length < 1
            subscription.displayErrors(" can't be blank", 'label[for=email]', 'Email')
            formErrors += 1
        if $('#business_account_country').val().length < 1
            subscription.displayErrors(" can't be blank", 'label[for=country]', 'Country')
            formErrors += 1
        if $('#business_account_country').val() == "US" && $('#business_account_zip').val().length < 5
            subscription.displayErrors(" can't be blank", 'label[for=zip]', 'Zip')
            formErrors += 1
        if $('#business_account_country').val() == "US" && $('#business_account_state').val().length == 0
            subscription.displayErrors(" can't be blank", 'label[for=state]', 'State')
            formErrors += 1
        if $('#business_account_country').val() == "CA" && $('#business_account_postal').val().length < 5
            subscription.displayErrors(" can't be blank", 'label[for=postal]', 'Postal Code')
            formErrors += 1
        if $('#business_account_country').val() == "CA" && $('#business_account_province').val().length < 5
            subscription.displayErrors(" can't be blank", 'label[for=province]', 'Province')
        return formErrors.count
    checkCard: ->
        $('#stripe_error').empty()
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
        if $('input[type=checkbox]:checked').length > 0 && $('#business_account_coupon_code').val() == ""
            formErrors.push ('Missing Discount Code')
        if formErrors.length > 0
            subscription.displayErrors(formErrors, '#stripe_error', '')

        return formErrors.count
    displayErrors: (error, region, replacement) ->
        if replacement == 0
            for error in error
                do (error) ->
                    $(region).append('<li class="red">' + error + '</li>')
        else
        $(region).empty().append('<small>' + error + '</small>')
        false
    displayErrors: (error, region, replacement) ->
        $(region).empty().append(replacement + error)
        false
