//require ./select_installment

var ALL_CHECKOUT_SELECTORS = '' +
    '.buy-now-button, ' +
    '.checkout-content-save-continue-button, ' +
    '.cart-checkout-btn, ' +
    '.product-added-modal-button, ' +
    '.add-to-cart-button'

$(function () {
    controlPayNowButton();
    propagateInstallmentOptions();
    startLoading()
})

function hideOtherButtons() {
    $('.checkout-content-save-continue-button').hide();
}

function controlPayNowButton() {
    var pay_now = $('.pay-now-input')
    disablePaymentInput(pay_now)
    $('#readTNC').on('click', function () {
        if ($(this).is(':checked'))
            enablePaymentInput(pay_now)
        else
            disablePaymentInput(pay_now)
    })
    
    
    $('#sslczPayBtn').on('click', function (e) {
        return false;
    })
}

function disablePaymentInput(inputs) {
    $.map(inputs, function (input) {
        $(input).attr('disabled', true)
    })
}

function enablePaymentInput(inputs) {
    hideOtherButtons()
    
    $.map(inputs, function (input) {
        $(input).attr('disabled', false)
    })
}

function payNowButton() {
    return $('#sslczPayBtn');
}

function propagateInstallmentOptions() {
    var installmentOptions = $('#select-installment');
    payNowButton().prop('postdata', setInstallmentParams(0))
    installmentOptions.on('change', handleInstallmentChange)
}

function handleInstallmentChange() {
    disablePaymentInput(['#sslczPayBtn']) // lets disable the button
    var option = $(this).val();
    buildInstallmentValue(Number(option))
    enablePaymentInput(['#sslczPayBtn']) // lets enable the button
}

function buildInstallmentValue(value) {
    payNowButton().prop('postdata', setInstallmentParams(value))
}

function setInstallmentParams(value) {
    return (
        {
            emi_selected_installment: value
        }
    );
}


function startLoading() {
    $(ALL_CHECKOUT_SELECTORS).on('click', function () {
        $("div.spanner").addClass("show");
        $("div.overlay").addClass("show");
    })
}

