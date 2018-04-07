# DC_Parking

## An R Shiny Application about DC Parking Violation Visualization

*For GW MSBA Program DNSC6211 Programming for Analytics class*

**YouTube video:** https://www.youtube.com/watch?v=qNyjYBzbJ0I&feature=youtu.be 

**Dataset:** http://opendata.dc.gov/datasets/parking-violations-issued-in-september-2017

From the side of traffic police, issuing parking tickets is only a measure to maintain clear traffic condition. One of the aspect they can consider is to improve the parking service so that cars on streets won’t affect the moving traffic. Understanding when and where street-parking cars may obstruct the traffic is an effective way to help improve the service of street parking and optimize regulation.

Packages leaflet, leaflet.extras, tidyr, DT and data.table are required. In the shiny application, there are three maps. The first two are a heat map with the filter of violation descriptions and a regular map with the filter of day of week and range of hours. They are binding together when the selection of violation type will also affect the markers on the second map. With these two maps, users can choose a specific violation, the day or a time range to see the patterns of parking. Moreover, in the interactive map, there is a start button within the range of hours, animating the changes over time with an interval of 1 hour.

A third map of location searcher is the one to explore parking situations on a specific street. It is linked to the data explorer, where the user can find more details about those tickets on the road inputted, sorting by any column such as datetime and street ID.

With this interactive application, traffic police are able to find the patterns of locations, time and types on parking violations. Issuing tickets is not a method to generate revenue, but to manage the traffic. After analyzing the patterns of parking violation, the department of transportation can develop proposals to help improve parking problems to provide citizens with conveniences.
