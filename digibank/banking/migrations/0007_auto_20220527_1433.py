# Generated by Django 3.2.13 on 2022-05-27 13:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('banking', '0006_auto_20220527_1349'),
    ]

    operations = [
        migrations.AddField(
            model_name='bankaccount',
            name='account_type1',
            field=models.CharField(choices=[('savings', 'Savings'), ('credit', 'Credit')], db_index=True, default='', max_length=20),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='bankaccount',
            name='account_type2',
            field=models.CharField(choices=[('savings', 'Savings'), ('credit', 'Credit')], db_index=True, default='', max_length=20),
            preserve_default=False,
        ),
    ]
