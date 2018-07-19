App.cable.subscriptions.create 'NotificationsChannel',
  connected: ->
    console.log('Subscribed to NotificationsChannel.')

  rejected: ->
    console.log('Error subscribing to NotificationsChannel.')

  received: (data)->
    $('[data-id="js-notifications-dot"]').toggleClass('hidden')