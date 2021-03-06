# Generated by Django 3.2.13 on 2022-05-30 01:24

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('banking', '0008_auto_20220527_1606'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='moneytransfer',
            options={'ordering': ['-transaction_date']},
        ),
        migrations.AddField(
            model_name='moneytransfer',
            name='curr_user1',
            field=models.ForeignKey(default='', on_delete=django.db.models.deletion.CASCADE, related_name='MoneyTransfer', to='accounts.customuser'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='moneytransfer',
            name='transaction_date',
            field=models.DateTimeField(auto_now=True, db_index=True),
        ),
        migrations.AlterField(
            model_name='moneytransfer',
            name='amount',
            field=models.FloatField(),
        ),
    ]
