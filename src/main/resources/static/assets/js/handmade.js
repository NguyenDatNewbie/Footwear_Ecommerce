import PopupManager from 'https://cdn.jsdelivr.net/gh/jorgeabrahan/popup_library@67068b1/popup/Popup.js'
function confirmProductOutStock(paymentOption,orderCombine){
    const btnClose = '<span class="material-symbols-outlined">close</span>'

    const ConfirmationPopup = new PopupManager({ btnClose })

    ConfirmationPopup.display({
        title: 'Delete file',
        content: 'Are you sure you want to delete file?',
        buttons: {
            elements: [
                { text: 'Confirm', type: 'confirm', handler: function (){
                        $.ajax({
                            url: '/cart/payment/DELIVERY/' + paymentOption.value,
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify(orderCombine),
                            success: function (response) {
                                if (response != "success") {
                                    window.location.href = "/sign-in-up"
                                }
                                localStorage.removeItem('cart');
                                localStorage.removeItem('storeValid');
                                window.location.reload();
                            }
                        });
                    }},
                { text: 'Cancel', type: 'error', handler: () => ConfirmationPopup.close() }
            ]
        }
    })
}