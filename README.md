# demograph
This app takes an input an event or eventually an organization on Meetup.com and returns estimates of the gender of the RSVP'd attendees.

By estimates, we mean that we are just running predictions based on first name in most cases. There's no knowledge of the actual gender of the specific person, since Meetup does not allow access to that information. So we are guessing. Many names can be both genders and so we'll probably move to a probabilistic model.

We also don't intend to suggest that sex/gender is binary. If we can find an API/statistics that recognize that (e.g. the name Chris is 90% male, 8% female, and 2% gender-queer), even better, but if we can't, we still believe we are providing a useful service and hope people will forgive any numbers that would seem to suggest that male + female should equal 100%.

Reach out if interested in contributing. It's in the early stages.

A few possible directions:

1. Keep it simple - input event or org and get back data (this most closely represents the description above). In this world, we don't actively retrieve data from meetup until a user searches for it.
  a. Getting better at gender detection - current API is based in US names and does poorly with foreign ones. We can do better. Additionally, we are still very much in gender-binary land, a land we don't really want to be in.
  b. Visualizations of data
  c. Feedback loop - users can correct the gender of people if they believe it's inappropriately assigned. But then we should start persisting that - basically, storing gender assessments for Meetup users
2. Users can search an area or topic and get back meetups ranked by gender disparity. At this point, we're basically building meetup, but with one additional paramater
3. We hope to estimate race in the long run as well, though this would probably require classification based on profile pic, which is a dubious proposition.