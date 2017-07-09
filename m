From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
Date: Sun, 9 Jul 2017 11:30:08 +0200
Message-ID: <1677d448-4cdd-363f-34a6-152c61a06c0e@web.de>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1586981672518515553=="
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1586981672518515553==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fH9vPVN69Dg2cGrV92R9caLrc6eMX9RJp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fH9vPVN69Dg2cGrV92R9caLrc6eMX9RJp
Content-Type: multipart/mixed; boundary="w7RWeOXlRFUcgWWK8VOSGEsW21VmEv5tQ";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka@web.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang
 <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1677d448-4cdd-363f-34a6-152c61a06c0e@web.de>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>

--w7RWeOXlRFUcgWWK8VOSGEsW21VmEv5tQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2017-07-08 23:48, Andy Shevchenko wrote:
> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka@web.de> wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Avoid hogging chip select GPIOs just because they are listed for the
>> master. They might be mulitplexed and, if no slave device is attached,=

>> used for different purposes. Moreover, this strategy avoids having to
>> allocate a cs_gpiods structure.
>>
>> Tested on the IOT2000 where the second SPI bus is connected to an
>> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM=

>> usage.
>=20
> Can we first switch the driver to use GPIO descriptors instead of
> plain integers?

-ENOPARSE

>=20
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  drivers/spi/spi-pxa2xx.c | 59 +++++++++++++++++----------------------=
---------
>>  1 file changed, 21 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
>> index 38d053682892..be991266a6ce 100644
>> --- a/drivers/spi/spi-pxa2xx.c
>> +++ b/drivers/spi/spi-pxa2xx.c
>> @@ -1213,21 +1213,33 @@ static int setup_cs(struct spi_device *spi, st=
ruct chip_data *chip,
>>                     struct pxa2xx_spi_chip *chip_info)
>>  {
>>         struct driver_data *drv_data =3D spi_master_get_devdata(spi->m=
aster);
>> +       struct device *pdev =3D &drv_data->pdev->dev;
>> +       struct gpio_desc *gpiod;
>>         int err =3D 0;
>> +       int count;
>>
>>         if (chip =3D=3D NULL)
>>                 return 0;
>>
>> -       if (drv_data->cs_gpiods) {
>> -               struct gpio_desc *gpiod;
>> +       count =3D gpiod_count(pdev, "cs");
>> +       if (count > 0) {
>> +               if (spi->chip_select >=3D count)
>> +                       return -EINVAL;
>> +
>> +               gpiod =3D gpiod_get_index(pdev, "cs", spi->chip_select=
,
>> +                                       GPIOD_OUT_HIGH);
>> +               if (IS_ERR(gpiod)) {
>> +                       /* Means use native chip select */
>> +                       if (PTR_ERR(gpiod) =3D=3D -ENOENT)
>> +                               return 0;
>>
>> -               gpiod =3D drv_data->cs_gpiods[spi->chip_select];
>> -               if (gpiod) {
>> -                       chip->gpio_cs =3D desc_to_gpio(gpiod);
>> -                       chip->gpio_cs_inverted =3D spi->mode & SPI_CS_=
HIGH;
>> -                       gpiod_set_value(gpiod, chip->gpio_cs_inverted)=
;
>> +                       return PTR_ERR(gpiod);
>>                 }
>>
>> +               chip->gpio_cs =3D desc_to_gpio(gpiod);
>> +               chip->gpio_cs_inverted =3D spi->mode & SPI_CS_HIGH;
>> +               gpiod_set_value(gpiod, chip->gpio_cs_inverted);
>> +
>>                 return 0;
>>         }
>>
>> @@ -1415,8 +1427,7 @@ static void cleanup(struct spi_device *spi)
>>         if (!chip)
>>                 return;
>>
>> -       if (drv_data->ssp_type !=3D CE4100_SSP && !drv_data->cs_gpiods=
 &&
>> -           gpio_is_valid(chip->gpio_cs))
>> +       if (drv_data->ssp_type !=3D CE4100_SSP && gpio_is_valid(chip->=
gpio_cs))
>>                 gpio_free(chip->gpio_cs);
>>
>>         kfree(chip);
>> @@ -1752,38 +1763,10 @@ static int pxa2xx_spi_probe(struct platform_de=
vice *pdev)
>>         master->num_chipselect =3D platform_info->num_chipselect;
>>
>>         count =3D gpiod_count(&pdev->dev, "cs");
>> -       if (count > 0) {
>> -               int i;
>> -
>> +       if (count > 0)
>>                 master->num_chipselect =3D max_t(int, count,
>>                         master->num_chipselect);
>>
>> -               drv_data->cs_gpiods =3D devm_kcalloc(&pdev->dev,
>> -                       master->num_chipselect, sizeof(struct gpio_des=
c *),
>> -                       GFP_KERNEL);
>> -               if (!drv_data->cs_gpiods) {
>> -                       status =3D -ENOMEM;
>> -                       goto out_error_clock_enabled;
>> -               }
>> -
>> -               for (i =3D 0; i < master->num_chipselect; i++) {
>> -                       struct gpio_desc *gpiod;
>> -
>> -                       gpiod =3D devm_gpiod_get_index(dev, "cs", i,
>> -                                                    GPIOD_OUT_HIGH);
>> -                       if (IS_ERR(gpiod)) {
>> -                               /* Means use native chip select */
>> -                               if (PTR_ERR(gpiod) =3D=3D -ENOENT)
>> -                                       continue;
>> -
>> -                               status =3D (int)PTR_ERR(gpiod);
>> -                               goto out_error_clock_enabled;
>> -                       } else {
>> -                               drv_data->cs_gpiods[i] =3D gpiod;
>> -                       }
>> -               }
>> -       }
>> -
>>         tasklet_init(&drv_data->pump_transfers, pump_transfers,
>>                      (unsigned long)drv_data);
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" i=
n
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20



--w7RWeOXlRFUcgWWK8VOSGEsW21VmEv5tQ--

--fH9vPVN69Dg2cGrV92R9caLrc6eMX9RJp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllh96QACgkQitSsb3rl5xQLxQCfZ4gzzEi9GEORwy/UnBZfZh1u
n/AAn2F0lmNwpc7tQQ61Yvj5dHgckMMW
=09LT
-----END PGP SIGNATURE-----

--fH9vPVN69Dg2cGrV92R9caLrc6eMX9RJp--


--===============1586981672518515553==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1586981672518515553==--
