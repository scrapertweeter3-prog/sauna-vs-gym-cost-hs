-- | Cost-per-session math for home recovery gear.
--
-- A home sauna or cold plunge is a gear price, a usage habit, and an
-- electricity line. The sticker price says nothing until usage spreads
-- it over sessions and the electricity lands on each one. This module
-- restates a purchase into dollars per session and counts the visits
-- until the gear has paid for itself against a per-visit alternative
-- like a gym membership or a day pass.
module SaunaVsGym.Cost
  ( utilityCost
  , annualSessions
  , sessionCost
  , breakEvenSessions
  ) where

-- | Per-session utility cost from kilowatt-hours and the meter rate.
-- A 2 kW heater run 1 hour at $0.17/kWh is 0.34 dollars a session.
utilityCost :: Double -> Double -> Double
utilityCost kwhPerSession ratePerKwh = kwhPerSession * ratePerKwh

-- | Sessions a weekly habit adds up to over a year.
-- Four a week is 208.
annualSessions :: Double -> Double
annualSessions sessionsPerWeek = sessionsPerWeek * 52

-- | Amortized cost of one session: the gear price spread over total
-- sessions plus the electricity line. Sessions accrue as the habit
-- runs, so the same $2,500 unit lands at $25.34 by session 100 and
-- $2.84 by session 1,000 before electricity. No sessions means no
-- denominator, so the cost is infinite rather than zero.
sessionCost :: Double -> Double -> Double -> Double
sessionCost gearCost totalSessions utilityPerSession
  | totalSessions <= 0 = 1 / 0
  | otherwise          = gearCost / totalSessions + utilityPerSession

-- | Visits until the gear has paid for itself against a per-visit
-- alternative. Infinite when the alternative is cheaper than the
-- electricity alone, because usage then never closes the gap. A $22
-- gym visit against $0.34 of power needs 115.4 sessions, about 6.6
-- months at four a week, before every visit after that is free.
breakEvenSessions :: Double -> Double -> Double -> Double
breakEvenSessions gearCost alternativePerVisit utilityPerSession
  | gap <= 0  = 1 / 0
  | otherwise = gearCost / gap
  where gap   = alternativePerVisit - utilityPerSession
