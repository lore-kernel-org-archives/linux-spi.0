From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 2/2] spi: use gpio_desc instead of numeric gpio
Date: Tue, 23 May 2017 20:43:13 +0000
Message-ID: <ca3b3f5247624a35b8203472a53df79a@svr-chch-ex1.atlnz.lc>
References: <20170523040322.10433-1-chris.packham@alliedtelesis.co.nz>
 <20170523040322.10433-2-chris.packham@alliedtelesis.co.nz>
 <CAHp75VcHktwnXg26sq6x=EqM6TFAEc6yQrRFZQu1CCpYYfq6wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andy,=0A=
=0A=
On 24/05/17 06:28, Andy Shevchenko wrote:=0A=
> On Tue, May 23, 2017 at 7:03 AM, Chris Packham=0A=
> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>> By using a gpio_desc and gpiod_set_value() instead of a numeric gpio and=
=0A=
>> gpio_set_value() the gpio flags are taken into account. This is useful=
=0A=
>> when using a gpio chip-select to supplement a controllers native=0A=
>> chip-select.=0A=
>=0A=
> I think would be better to move everything in SPI core to GPIO descriptor=
s.=0A=
=0A=
I did consider it but it's a big change and I don't have access a lot of =
=0A=
gear to test on (maybe 2 or 3 SoCs with a SPI host controller and the =0A=
same SPI-NOR chips).=0A=
=0A=
I can give it a try. Perhaps converting the spi core structures over and =
=0A=
leaving the slaves using numeric gpios. Then later converting the slaves.=
=0A=
=0A=
>=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>=0A=
>> Notes:=0A=
>>      My specific use-case is I have a board that uses the spi-orion driv=
er but=0A=
>>      only has one CS pin available. In order to access two spi slave dev=
ices the=0A=
>>      board has a 1-of-2 decoder/demultiplexer which is driven via a gpio=
.=0A=
>>=0A=
>>      The problem is that for one of the 2 slave devices the gpio level r=
equired=0A=
>>      is opposite to the chip-select so I can't simply specify "spi-cs-hi=
gh".=0A=
>>      With this change I can flag the gpio as active low and the gpio sub=
system=0A=
>>      takes care of the additional inversion required.=0A=
>>=0A=
>>   drivers/spi/spi.c | 5 ++++-=0A=
>>   1 file changed, 4 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c=0A=
>> index 6f87fec409b5..b39c0f9956dd 100644=0A=
>> --- a/drivers/spi/spi.c=0A=
>> +++ b/drivers/spi/spi.c=0A=
>> @@ -725,7 +725,10 @@ static void spi_set_cs(struct spi_device *spi, bool=
 enable)=0A=
>>                  enable =3D !enable;=0A=
>>=0A=
>>          if (gpio_is_valid(spi->cs_gpio)) {=0A=
>> -               gpio_set_value(spi->cs_gpio, !enable);=0A=
>> +               struct gpio_desc *gpio =3D gpio_to_desc(spi->cs_gpio);=
=0A=
>> +=0A=
>> +               if (gpio)=0A=
>> +                       gpiod_set_value(gpio, !enable);=0A=
>>                  /* Some SPI masters need both GPIO CS & slave_select */=
=0A=
>>                  if ((spi->master->flags & SPI_MASTER_GPIO_SS) &&=0A=
>>                      spi->master->set_cs)=0A=
>> --=0A=
>> 2.13.0=0A=
>>=0A=
>> --=0A=
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in=
=0A=
>> the body of a message to majordomo@vger.kernel.org=0A=
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
>=0A=
>=0A=
>=0A=
=0A=
=0A=
