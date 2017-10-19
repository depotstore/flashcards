function checkSize() {
  var card_picture = document.getElementById('card_picture');
  var size_in_megabytes = card_picture.files[0].size/1024/1024;
  if (size_in_megabytes > 5) {
    alert('Maximum file size is 5MB. Please choose a smaller file.');
    card_picture.value = "";
  }
}
