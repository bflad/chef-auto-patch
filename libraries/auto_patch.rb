# Cookbook Name:: auto-patch
# Library:: AutoPatch
#
# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'date'

class Chef::Recipe::AutoPatch
  WEEKS = %w{ first second third fourth }
  WEEKDAYS = %w{ sunday monday tuesday wednesday thursday friday saturday }

  def self.day(monthly_specifier)
    week,weekly_specifier = monthly_specifier.split(" ")
    week.lower!
    weekly_specifier.lower!
    Chef::Application.fatal!("Unknown week specified.") unless WEEKS.include?(week)

    current_time = Time.now
    patch_day = monthly_day(current_time.year,current_time.month,week,weekly_specifier)

    if current_time > Time.new(current_time.year,current_time.month,patch_day,current_time.hour,current_time.minute)
      if current_time.month == 12
        patch_day = monthly_day(current_time.year+1,1,week,weekly_specifier)
      else
        patch_day = monthly_day(current_time.year,current_time.month+1,week,weekly_specifier)
      end
    end

    patch_day
  end

  def self.monthly_day(year,month,week,weekly_specifier)
    first_day_occurance = 1
    while weekday(weekly_specifier) != Date.new(year,month,first_day_occurance).wday
      first_day_occurance = first_day_occurance + 1
    end
    first_day_occurance * ( WEEKS.index(week) + 1 )
  end

  def self.weekday(weekly_specifier)
    Chef::Application.fatal!("Unknown weekday specified.") unless WEEKDAYS.include?(weekly_specifier)
    WEEKDAYS.index(weekly_specifier)
  end

end