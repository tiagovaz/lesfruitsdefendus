#!/usr/bin/python
# -*- coding: utf-8 -*-

from redmine import Redmine
from icalendar import Calendar, Event, vCalAddress, vText, vDatetime
import datetime, os

# connecting to redmine
redmine = Redmine('http://acaia.ca:3000', username='XXX', password='XXX')
project = redmine.project.get('fruitsdefendus')

# to be used around the code...
now = datetime.datetime.now()

def get_date_range(days_before=0, days_after=10):
    """
    Receives the amount of days before and after today to build
    the filter string used by Redmine API. Returns a string which
    means a date range for Redmine.
    """
    start_date = now - datetime.timedelta(days=days_before)
    end_date = now + datetime.timedelta(days=days_after)
    now_str = now.strftime('%Y-%m-%d')
    start_date_str = start_date.strftime('%Y-%m-%d')
    end_date_str = end_date.strftime('%Y-%m-%d')
    due_date_filter = '><'+start_date_str+'|'+end_date_str
    return due_date_filter

def get_issues(date_range):
    issues = redmine.issue.filter(project_id='fruitsdefendus',
                                    tracker_id=4, # 4 is 'recolte'
                                    status_id='*', # 6 is 'scheduled', 9 is 'Full'
                                    due_date=date_range,
                                    sort='due_date'
                                 )
    return issues

def build_calendar(issues, ics_path):
    cal = Calendar()
    for i in issues:
        event = Event()
        if "Full" in str(i.status):
            summary = "[COMPLET] " + i.subject
        else:
            summary = i.subject
        event.add('summary', summary)
        event.add('description', i.description)
        event['uid'] = i.id
        for c in i.custom_fields:
            if c.id == 20: # 20 is 'debut'
                start_time = str(c.value).replace(':', '')+"00"
            if c.id == 21: # 21 is 'fin'
                end_time = str(c.value).replace(':', '')+"00"
        event['dtstart'] = i.due_date.replace('/','')+"T"+start_time
        event['dtend'] = i.due_date.replace('/','')+"T"+end_time
        event['dtstamp'] = vDatetime(now).to_ical()
        organizer = vCalAddress('MAILTO:info@lesfruitsdefendus.org')
        organizer.params['cn'] = vText('Les fruits défendus')
        event['organizer'] = organizer
        event['location'] = vText('Montréal, QC')
        cal.add_component(event)

        f = open(ics_path, 'wb')
        f.write(cal.to_ical())
        f.close()

# main program

date_range = get_date_range(10, 10)
issues = get_issues(date_range)
build_calendar(issues, '/tmp/calendar.ics')

