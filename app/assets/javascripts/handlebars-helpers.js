Handlebars.registerHelper('local_date', function(date_string) {
 return new Date(Date.parse(date_string)).toLocaleString();
});

Handlebars.registerHelper('one_decimal', function(num){
  return num.toFixed(1);
});
