# Generated by Django 3.2.13 on 2022-05-27 03:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('banking', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='transactions',
            name='transaction_type',
            field=models.CharField(choices=[('deposit', 'Deposit'), ('withdrawal', 'Withdrawal'), ('transfer', 'trensfer')], max_length=20),
        ),
    ]