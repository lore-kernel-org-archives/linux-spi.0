From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] spi: atmel: improve internal vs gpio chip-select choice
Date: Mon, 11 Jan 2016 16:37:03 +0000
Message-ID: <yw1x8u3wvzrk.fsf@unicorn.mansr.com>
References: <1452211907-16074-1-git-send-email-mans@mansr.com>
	<5693C9A3.9040403@atmel.com> <5693D957.30103@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"Yang\, Wenyou" <Wenyou.Yang@atmel.com>
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5693D957.30103@atmel.com> (Cyrille Pitchen's message of "Mon, 11
	Jan 2016 17:33:27 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Cyrille Pitchen <cyrille.pitchen@atmel.com> writes:

> Hi Mans,
>
> Le 11/01/2016 16:26, Nicolas Ferre a =E9crit :
>> Le 08/01/2016 01:11, Mans Rullgard a =E9crit :
> [...]
>>> @@ -1569,13 +1576,6 @@ static int atmel_spi_probe(struct platform_d=
evice *pdev)
>>> =20
>>>  	atmel_get_caps(as);
>>> =20
>>> -	as->use_cs_gpios =3D true;
>>> -	if (atmel_spi_is_v2(as) &&
>>=20
>> I don't see this atmel_spi_is_v2() test in the resulting code anymor=
e:
>> did you make sure that the v1 of the peripheral is protected?
>>=20
>>> -	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>>> -		as->use_cs_gpios =3D false;
>>> -		master->num_chipselect =3D 4;
>>=20
>> This line is pretty important: you mustn't remove it blindly!
>>=20
>>=20
>
> Actually, few lines above master->num_chipselect is initialized with:
> 	master->dev.of_node =3D pdev->dev.of_node;
> [...]
> 	master->num_chipselect =3D master->dev.of_node ? 0 : 4;
>
> So 0 in the case of DT support, 4 otherwise.
>
> Now looking at the source code of spi_register_master(), this functio=
n:
>
> 1 - calls of_spi_register_master(), which initializes master->num_chi=
pselect:
> 	nb =3D of_gpio_name_count(np, "cs-gpios");
> 	master->num_chipselect =3D max_t(int, nb, master->num_chipselect);
>
> 	if (nb =3D=3D 0 || nb =3D=3D -ENOENT)
> 		return 0;
>
> 2 - check master->num_chipselect with:
> 	if (master->num_chipselect =3D=3D 0)
> 		return -EINVAL;
>
> It means that in the case of DT support, master->num_chipselect was
> initialized according to the value of the "cs-gpios" DT
> property. Hence this property used to be mandatory but now we want it
> to be optional for hardware version 2 and later.
>
> This is why we added a check "hw version >=3D 2 and cs-gpios
> missing". In such a case the master->num_chipselect was initialized t=
o
> 4 so spi_register_master() does not fail with -EINVAL.
>
> I have applied the following fix after your patch and now the driver =
works
> again on sama5d2:
>
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1576,6 +1576,11 @@ static int atmel_spi_probe(struct platform_dev=
ice *pdev)
>
>         atmel_get_caps(as);
>
> +       if (atmel_spi_is_v2(as) &&
> +           master->dev.of_node &&
> +           !of_get_property(master->dev.of_node, "cs-gpios", NULL))
> +               master->num_chipselect =3D 4;
> +
>         as->use_dma =3D false;
>         as->use_pdc =3D false;
>         if (as->caps.has_dma_support) {

That's pretty much what I did (left the original alone) in v2 of the
patch.

Thanks for testing.

--=20
M=E5ns Rullg=E5rd
