# Generated by Django 5.0.1 on 2024-02-04 19:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('lecsApp', '0009_alter_lec_options_alter_lecvideo_options_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='lec',
            name='image',
            field=models.ImageField(blank=None, default='images/defaultLec.png', upload_to='images/%y/%m/%d'),
        ),
        migrations.AlterField(
            model_name='lecvideo',
            name='catgory',
            field=models.CharField(choices=[('علم الكلام', 'علم الكلام'), ('الاصول', 'الاصول'), ('السيرة', 'السيرة'), ('الفلسفة', 'الفلسفة'), ('الفقه 1', 'الفقه 1'), ('المنطق', 'المنطق'), ('الحديث والرجال', 'الحديث والرجال'), ('التاريخ', 'التاريخ'), ('اختبار', 'اختبار')], max_length=100),
        ),
    ]