# Generated by Django 3.2.13 on 2022-05-27 11:17

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('banking', '0003_moneytransfer'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='moneytransfer',
            name='user',
        ),
        migrations.AlterField(
            model_name='moneytransfer',
            name='curr_user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='MoneyTransfer', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='moneytransfer',
            name='dest_user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='MoneyTransfer1', to=settings.AUTH_USER_MODEL),
        ),
    ]
