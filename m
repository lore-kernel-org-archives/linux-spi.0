From: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: use gpio_desc instead of numeric gpio
Date: Wed, 24 May 2017 05:42:38 +0000
Message-ID: <1be4374ca1b1422fb2b14298bf21ae9d@svr-chch-ex1.atlnz.lc>
References: <20170523040322.10433-1-chris.packham@alliedtelesis.co.nz>
 <20170523040322.10433-2-chris.packham@alliedtelesis.co.nz>
 <CAHp75VcHktwnXg26sq6x=EqM6TFAEc6yQrRFZQu1CCpYYfq6wQ@mail.gmail.com>
 <ca3b3f5247624a35b8203472a53df79a@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 24/05/17 08:43, Chris Packham wrote:=0A=
> Hi Andy,=0A=
> =0A=
> On 24/05/17 06:28, Andy Shevchenko wrote:=0A=
>> On Tue, May 23, 2017 at 7:03 AM, Chris Packham=0A=
>> <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:=0A=
>>> By using a gpio_desc and gpiod_set_value() instead of a numeric gpio an=
d=0A=
>>> gpio_set_value() the gpio flags are taken into account. This is useful=
=0A=
>>> when using a gpio chip-select to supplement a controllers native=0A=
>>> chip-select.=0A=
>>=0A=
>> I think would be better to move everything in SPI core to GPIO descripto=
rs.=0A=
> =0A=
> I did consider it but it's a big change and I don't have access a lot of=
=0A=
> gear to test on (maybe 2 or 3 SoCs with a SPI host controller and the=0A=
> same SPI-NOR chips).=0A=
> =0A=
> I can give it a try. Perhaps converting the spi core structures over and=
=0A=
> leaving the slaves using numeric gpios. Then later converting the slaves.=
=0A=
> =0A=
=0A=
OK so I've had a look at this. The changes to change struct spi_master =0A=
to use gpio_desc in drivers/spi/spi-gpio.c are pretty straight forward =0A=
(in-line patch below, apologies for MUA wrapping).=0A=
=0A=
There are a few SPI host drivers that deal with cs_gpios directly. =0A=
spi-mt65xx.c and spi-davinci.c would be trivial to update. spi-ep93xx.c =0A=
and spi-imx.c are harder because they handle non-dt platforms.=0A=
=0A=
Changing struct spi_device to use gpio_desc would be wider reaching but =0A=
probably automatable s/gpio_set_value/gpiod_set_value/.=0A=
=0A=
I'm a little too nervous about messing up spi-ep93xx.c and spi-ep93xx.c =0A=
to push ahead with changing all of SPI core. I'd be happy to help out =0A=
someone with access to platforms using those.=0A=
=0A=
-- 8< --=0A=
index b39c0f9956dd..80a96d3daa45 100644=0A=
--- a/drivers/spi/spi.c=0A=
+++ b/drivers/spi/spi.c=0A=
@@ -40,6 +40,7 @@=0A=
  #include <linux/ioport.h>=0A=
  #include <linux/acpi.h>=0A=
  #include <linux/highmem.h>=0A=
+#include <linux/gpio/consumer.h>=0A=
=0A=
  #define CREATE_TRACE_POINTS=0A=
  #include <trace/events/spi.h>=0A=
@@ -531,8 +532,8 @@ int spi_add_device(struct spi_device *spi)=0A=
                 goto done;=0A=
         }=0A=
=0A=
-       if (master->cs_gpios)=0A=
-               spi->cs_gpio =3D master->cs_gpios[spi->chip_select];=0A=
+       if (master->cs_gpios[spi->chip_select])=0A=
+               spi->cs_gpio =3D =0A=
desc_to_gpio(master->cs_gpios[spi->chip_select]);=0A=
=0A=
         /* Drivers may modify this initial i/o setup, but will=0A=
          * normally rely on the device being setup.  Devices=0A=
@@ -1878,7 +1879,8 @@ EXPORT_SYMBOL_GPL(spi_alloc_master);=0A=
  #ifdef CONFIG_OF=0A=
  static int of_spi_register_master(struct spi_master *master)=0A=
  {=0A=
-       int nb, i, *cs;=0A=
+       int nb, i;=0A=
+       struct gpio_desc **cs;=0A=
         struct device_node *np =3D master->dev.of_node;=0A=
=0A=
         if (!np)=0A=
@@ -1894,7 +1896,7 @@ static int of_spi_register_master(struct =0A=
spi_master *master)=0A=
                 return nb;=0A=
=0A=
         cs =3D devm_kzalloc(&master->dev,=0A=
-                         sizeof(int) * master->num_chipselect,=0A=
+                         sizeof(*master->cs_gpios) * =0A=
master->num_chipselect,=0A=
                           GFP_KERNEL);=0A=
         master->cs_gpios =3D cs;=0A=
=0A=
@@ -1902,10 +1904,16 @@ static int of_spi_register_master(struct =0A=
spi_master *master)=0A=
                 return -ENOMEM;=0A=
=0A=
         for (i =3D 0; i < master->num_chipselect; i++)=0A=
-               cs[i] =3D -ENOENT;=0A=
+               cs[i] =3D NULL;=0A=
=0A=
-       for (i =3D 0; i < nb; i++)=0A=
-               cs[i] =3D of_get_named_gpio(np, "cs-gpios", i);=0A=
+       for (i =3D 0; i < nb; i++) {=0A=
+               struct gpio_desc *gpio;=0A=
+=0A=
+               gpio =3D devm_gpiod_get_index(&master->dev, "cs", i,=0A=
+                                           GPIOD_OUT_HIGH);=0A=
+               if (!IS_ERR(gpio))=0A=
+                       cs[i] =3D gpio;=0A=
+       }=0A=
=0A=
         return 0;=0A=
  }=0A=
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h=0A=
index 935bd2854ff1..46960ca62d5b 100644=0A=
--- a/include/linux/spi/spi.h=0A=
+++ b/include/linux/spi/spi.h=0A=
@@ -556,7 +556,7 @@ struct spi_master {=0A=
                            struct spi_message *message);=0A=
=0A=
         /* gpio chip select */=0A=
-       int                     *cs_gpios;=0A=
+       struct gpio_desc        **cs_gpios;=0A=
=0A=
         /* statistics */=0A=
         struct spi_statistics   statistics;=0A=
-- >8 --=0A=
=0A=
>>=0A=
>>>=0A=
>>> Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>=0A=
>>> ---=0A=
>>>=0A=
>>> Notes:=0A=
>>>       My specific use-case is I have a board that uses the spi-orion dr=
iver but=0A=
>>>       only has one CS pin available. In order to access two spi slave d=
evices the=0A=
>>>       board has a 1-of-2 decoder/demultiplexer which is driven via a gp=
io.=0A=
>>>=0A=
>>>       The problem is that for one of the 2 slave devices the gpio level=
 required=0A=
>>>       is opposite to the chip-select so I can't simply specify "spi-cs-=
high".=0A=
>>>       With this change I can flag the gpio as active low and the gpio s=
ubsystem=0A=
>>>       takes care of the additional inversion required.=0A=
>>>=0A=
>>>    drivers/spi/spi.c | 5 ++++-=0A=
>>>    1 file changed, 4 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c=0A=
>>> index 6f87fec409b5..b39c0f9956dd 100644=0A=
>>> --- a/drivers/spi/spi.c=0A=
>>> +++ b/drivers/spi/spi.c=0A=
>>> @@ -725,7 +725,10 @@ static void spi_set_cs(struct spi_device *spi, boo=
l enable)=0A=
>>>                   enable =3D !enable;=0A=
>>>=0A=
>>>           if (gpio_is_valid(spi->cs_gpio)) {=0A=
>>> -               gpio_set_value(spi->cs_gpio, !enable);=0A=
>>> +               struct gpio_desc *gpio =3D gpio_to_desc(spi->cs_gpio);=
=0A=
>>> +=0A=
>>> +               if (gpio)=0A=
>>> +                       gpiod_set_value(gpio, !enable);=0A=
>>>                   /* Some SPI masters need both GPIO CS & slave_select =
*/=0A=
>>>                   if ((spi->master->flags & SPI_MASTER_GPIO_SS) &&=0A=
>>>                       spi->master->set_cs)=0A=
>>> --=0A=
>>> 2.13.0=0A=
>>>=0A=
>>> --=0A=
>>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in=
=0A=
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=0A=
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
>>=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
> =0A=
=0A=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
