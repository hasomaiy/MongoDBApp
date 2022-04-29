$(document).ready(function () {
  $('#dtBasicExample').DataTable();
  $('.dataTables_length').addClass('bs-select');
});

$("#dtBasicExample_filter").keyup(function(){

   if ($(this).val() == '') return;

   $.ajax({
    url: 'index.jsp',
    dataType: 'html',
    type: 'get',
    data: 'name='+$("#name").val(),
    success: function (result) {
      $("#dtBasicExample").html(result);
    },

    error: function (result) {
        $("#dtBasicExample").html("Error.");
    }
  });
});
