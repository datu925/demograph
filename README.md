#demograph

##Synopsis

This app takes an input an event or eventually an organization on Meetup.com and returns estimates of the gender of the RSVP'd attendees.

##Disclaimer

By estimates, we mean that we are just running predictions based on first name in most cases. There's no knowledge of the actual gender of the specific person, since Meetup does not allow access to that information. So we are guessing. The idea is to be roughly accurate at the event-level but not necessarily at the individual level.

We also don't intend to suggest that sex/gender is binary. If we can find an API/statistics that recognize that (e.g. the name Chris is 90% male, 8% female, and 2% gender-queer), even better, but if we can't, we still believe we are providing a useful service and hope people will forgive any numbers that would seem to suggest that male + female should equal 100%.

##Usage

Simply put in an a Meetup.com event URL, click go, and see the results.

##Motivation

I went to a tech meetup with a friend and at some point, she noticed that she was the only woman there, out of maybe 35-40 attendees. I know tech is lopsided in this regard, but 3%? Come on.

These kinds of metrics will change faster if they are tracked. That which gets measured gets managed. Demograph lowers the barrier to measurement.

##Contributing

See the [contributing.md] file. The direction I'm most interested in heading in is allowing event subscriptions - you get sent an email some interval of days before the event if you're not gender-balanced, giving you time to rectify the situation.