
$("#new_user_book").on('ajax:success', function(event, data, status) {
  // insert the failure message inside the "#account_settings" element
  console.log(data);
  console.log(event);
  // alert("book list updated successfully.")
});

$(document).on('ajax:success', function(event, data, status) {
  // insert the failure message inside the "#account_settings" element
  console.log(data);
  console.log(data);

  if (.indexOf("edit_user_book"))
    alert("book list updated successfully.")
});

$(document).on('ajax:error', function(event, xhr, status) {
  // insert the failure message inside the "#account_settings" element
  console.log(xhr.responseText)
});