# sauna-vs-gym-cost

Cost-per-session math for home recovery gear.

A home sauna's real price is not the sticker. It is the gear price
spread over the sessions a habit accrues, plus the
electricity each session draws. A $2,500 unit run four times a week at
$0.17 per kilowatt-hour lands at $25.34 a session by session 100 and
$2.84 by session 1,000, electricity included both times.

The package follows the cost-per-session method used on
[HackedSelf](https://hackedself.com). It depends only on base.

## Example

A $2,500 sauna, a $22 gym visit across town, and $0.34 of power per
session:

* per-session electricity: `utilityCost 2.0 0.17` = $0.34
* session 100 all-in: `sessionCost 2500 100 0.34` = $25.34
* session 1,000 all-in: `sessionCost 2500 1000 0.34` = $2.84
* break-even: `breakEvenSessions 2500 22 0.34` = 115.4 visits

At four sessions a week, 115.4 visits is about 6.6 months. Every gym
trip after that costs more than the power bill for a home session. If
the alternative were a $0.30 day pass, cheaper than the electricity
alone, the break-even count goes infinite: no amount of usage closes a
gap that opens the wrong way.
