// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap'
import './src/application.scss'
import 'jquery'
import "trix"
import "@rails/actiontext"
global.$ = jQuery;

Rails.start()
ActiveStorage.start()

$(document).ready(function(){
  $('.navbar .dropdown').hover(function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
  }, function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
  });
})

require("trix")
require("@rails/actiontext")

$(function () {
  let storiesTable = $('#stories-table').DataTable({
    columnDefs: [{ orderable: false, targets: [5, 6] }],
    language: {
      url:
        'https://cdn.datatables.net/plug-ins/1.10.19/i18n/Portuguese-Brasil.json',
    },
  });
  storiesTable.draw();
})