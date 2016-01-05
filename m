From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: atmel: add support for the internal chip-select of the spi controller
Date: Tue, 05 Jan 2016 21:50:54 +0000
Message-ID: <yw1xvb771yrl.fsf@unicorn.mansr.com>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
	<c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Mark Browk <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c05f4d9abfdabb62b3b3cfeb57a3f9c138b4e45d.1433850255.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
	(Cyrille Pitchen's message of "Tue, 9 Jun 2015 13:53:52 +0200")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

> This patch relies on the CSAAT (Chip Select Active After Transfer) fe=
ature
> introduced by the version 2 of the spi controller. This new mode allo=
ws to
> use properly the internal chip-select output pin of the spi controlle=
r
> instead of using external gpios. Consequently, the "cs-gpios" device-=
tree
> property becomes optional.
>
> When the new CSAAT bit is set into the Chip Select Register, the inte=
rnal
> chip-select output pin remains asserted till both the following condi=
tions
> become true:
> - the LASTXFER bit is set into the Control Register (or the Transmit =
Data
>   Register)
> - the Transmit Data Register and its shift register are empty.
>
> WARNING: if the LASTXFER bit is set into the Control Register then ne=
w
> data are written into the Transmit Data Register fast enough to keep =
its
> shifter not empty, the chip-select output pin remains asserted. Only =
when
> the shifter becomes empty, the chip-select output pin is unasserted.
>
> When the CSAAT bit is clear in the Chip Select Register, the LASTXFER=
 bit
> is ignored in both the Control Register and the Transmit Data Registe=
r.
> The internal chip-select output pin remains active as long as the Tra=
nsmit
> Data Register or its shift register are not empty.
>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-atmel.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)

[...]

> @@ -1338,6 +1350,13 @@ static int atmel_spi_probe(struct platform_dev=
ice *pdev)
>
>  	atmel_get_caps(as);
>
> +	as->use_cs_gpios =3D true;
> +	if (atmel_spi_is_v2(as) &&
> +	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
> +		as->use_cs_gpios =3D false;
> +		master->num_chipselect =3D 4;
> +	}

This part breaks the AVR32 boards and probably anything else that
doesn't use devicetree but does use GPIOs for chip select.

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
