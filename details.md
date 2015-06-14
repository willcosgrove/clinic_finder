The first thing I'm going to do is plan out how the data will be modeled.  I
think we'll probably just have one model, a Clinic.  And I think I'll just go
ahead and store everything that the CSV gives me.  I'll also add fields for
latitude and longitude to hold our geocoding result.

I want to go ahead and get some data in here, so I'm going to write my importer
next.

Importer and it's tests are written.  My database is now populated with 8716
clinics.  My next step will be to get the latitude and longitude populated.
