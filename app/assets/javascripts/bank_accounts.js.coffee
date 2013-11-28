# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $('#bank-account-form').submit (event) ->
    $form = $(this)

    #   Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true)

    Stripe.bankAccount.createToken(
      {
        country: "US",
        routingNumber: $('#routing_number').val(),
        accountNumber: $('#account_number').val(),
      }, stripeResponseHandler);

    #   Prevent the form from submitting with the default action
    return false


stripeResponseHandler = (status, response) ->
  $form = $('#bank-account-form')

  if (response.error)
#     Show the errors on the form
    $form.find('.payment-errors').text(response.error.message)
    $form.find('button').prop('disabled', false)
  else
#  token contains id, last4, and card type
    token = response.id
    bank_account = response.bank_account
    $("#bank_account_description").val(bank_account.bank_name)
    $("#temp_token").val(token)
#   and submit
    $form.get(0).submit()
