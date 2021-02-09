$(function () {
    var pay_now = $('#sslczPayBtn')
    pay_now.attr('disabled', true)
    
    $('#readTNC').on('click', function () {
        if($(this).is(':checked'))
            pay_now.attr('disabled', false)
        else
            pay_now.attr('disabled', true)
    })
    
    
    pay_now.on('click', function (e) {
        return false;
    })
    
})
