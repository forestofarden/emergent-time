/* event formatting functions used by events list and suggester
   should be converted to render on the server side?
   if so, there's collision between html rendering of timeline (the whole template)
   and the events list component */

/* TODO.  don't pollute the global javascript namespace */

var formatDate = function(d) {
  var m_names = new Array("January", "February", "March", 
  "April", "May", "June", "July", "August", "September", 
  "October", "November", "December");

  if (d === undefined || d == null) { return ''; }
  
  d = Timeline.DateTime.parseIso8601DateTime(d);
  var curr_date = d.getDate();
  var curr_month = d.getMonth();
  var curr_year = d.getFullYear();
  return curr_date + "-" + m_names[curr_month] + "-" + curr_year;
};

var formatEvent = function(e) {
  // not best to pollute event object, but templater has no access to other vars
  e.startDate = formatDate(e.start);
  e.finishDate = formatDate(e.finish);
  
  var template = '<li class="event" db_id="<%= this.id %>" evt_start="<%= this.start %>">' +
         '<div class="event_container">' + 
         '<div class="event_remove" title="Remove this event"></div>' +
         '<div class="event_dates"><%= this.startDate %><%= (this.finishDate == "") ? "" : " &mdash; " + this.finishDate %></div>' +
         '<div class="event_title"><%= (this.real_title || "") %></div> ' +
         '<div class="event_description"><%= this.description %></div> ' +
         '<div class="event_interpretation"><%= (this.interpretation || "") %></div>' +
         '</div>' + 
         '</li>';
  return new JsTemplate.Template(template).run(e);
};