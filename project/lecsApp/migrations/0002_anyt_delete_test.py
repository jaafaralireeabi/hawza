# Generated by Django 4.1.13 on 2024-03-14 09:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('lecsApp', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='anyt',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('image', models.ImageField(blank=None, default='images/defaultLec.png', upload_to='images/%y/%m/%d')),
            ],
            options={
                'verbose_name': 'اقسام المحاضرات',
            },
        ),
        migrations.DeleteModel(
            name='test',
        ),
    ]
