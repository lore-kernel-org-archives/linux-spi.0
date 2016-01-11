From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: improve internal vs gpio chip-select choice
Date: Mon, 11 Jan 2016 17:33:27 +0100
Message-ID: <5693D957.30103@atmel.com>
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
 <5693C9A3.9040403@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5693C9A3.9040403-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mans,

Le 11/01/2016 16:26, Nicolas Ferre a =E9crit :
> Le 08/01/2016 01:11, Mans Rullgard a =E9crit :
[...]
>> @@ -1569,13 +1576,6 @@ static int atmel_spi_probe(struct platform_de=
vice *pdev)
>> =20
>>  	atmel_get_caps(as);
>> =20
>> -	as->use_cs_gpios =3D true;
>> -	if (atmel_spi_is_v2(as) &&
>=20
> I don't see this atmel_spi_is_v2() test in the resulting code anymore=
:
> did you make sure that the v1 of the peripheral is protected?
>=20
>> -	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>> -		as->use_cs_gpios =3D false;
>> -		master->num_chipselect =3D 4;
>=20
> This line is pretty important: you mustn't remove it blindly!
>=20
>=20

Actually, few lines above master->num_chipselect is initialized with:
	master->dev.of_node =3D pdev->dev.of_node;
[...]
	master->num_chipselect =3D master->dev.of_node ? 0 : 4;


So 0 in the case of DT support, 4 otherwise.


Now looking at the source code of spi_register_master(), this function:

1 - calls of_spi_register_master(), which initializes master->num_chips=
elect:
	nb =3D of_gpio_name_count(np, "cs-gpios");
	master->num_chipselect =3D max_t(int, nb, master->num_chipselect);

	if (nb =3D=3D 0 || nb =3D=3D -ENOENT)
		return 0;

2 - check master->num_chipselect with:
	if (master->num_chipselect =3D=3D 0)
		return -EINVAL;

It means that in the case of DT support, master->num_chipselect was ini=
tialized
according to the value of the "cs-gpios" DT property. Hence this proper=
ty used
to be mandatory but now we want it to be optional for hardware version =
2 and
later.

This is why we added a check "hw version >=3D 2 and cs-gpios missing". =
In such
a case the master->num_chipselect was initialized to 4 so spi_register_=
master()
does not fail with -EINVAL.

I have applied the following fix after your patch and now the driver wo=
rks
again on sama5d2:

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1576,6 +1576,11 @@ static int atmel_spi_probe(struct platform_devic=
e *pdev)
=20
        atmel_get_caps(as);
=20
+       if (atmel_spi_is_v2(as) &&
+           master->dev.of_node &&
+           !of_get_property(master->dev.of_node, "cs-gpios", NULL))
+               master->num_chipselect =3D 4;
+
        as->use_dma =3D false;
        as->use_pdc =3D false;
        if (as->caps.has_dma_support) {

>> -	}
>> -
>>  	as->use_dma =3D false;
>>  	as->use_pdc =3D false;
>>  	if (as->caps.has_dma_support) {
>>
>=20
> So, sorry but it's a NACK for me.
>=20
> Bye,
>=20

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
