# Generated by Django 3.2.13 on 2022-05-30 01:37

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('banking', '0009_auto_20220530_0224'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='moneytransfer',
            options={},
        ),
        migrations.RemoveField(
            model_name='moneytransfer',
            name='curr_user1',
        ),
        migrations.RemoveField(
            model_name='moneytransfer',
            name='transaction_date',
        ),
    ]
