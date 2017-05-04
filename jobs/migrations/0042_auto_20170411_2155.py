# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2017-04-11 21:55
from __future__ import unicode_literals

import django.contrib.postgres.fields
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('jobs', '0041_hdxexportregion_is_private'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='hdxexportregion',
            name='country_codes',
        ),
        migrations.AddField(
            model_name='hdxexportregion',
            name='license',
            field=models.CharField(max_length=32, null=True),
        ),
        migrations.AddField(
            model_name='hdxexportregion',
            name='locations',
            field=django.contrib.postgres.fields.ArrayField(base_field=models.CharField(max_length=32), null=True, size=None),
        ),
        migrations.AddField(
            model_name='hdxexportregion',
            name='subnational',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='hdxexportregion',
            name='extra_notes',
            field=models.TextField(null=True),
        ),
    ]