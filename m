From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: fix gpio chip-select in case of non-DT platform
Date: Thu, 28 Jan 2016 16:00:13 +0000
Message-ID: <yw1x37thk836.fsf@unicorn.mansr.com>
References: <1453913312-18108-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453913312-18108-1-git-send-email-nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
	(Nicolas Ferre's message of "Wed, 27 Jan 2016 17:48:32 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> writes:

> From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
>
> The non-DT platform that uses this driver (actually the AVR32) was ta=
king a bad
> branch for determining if the IP would use gpio for CS.
> Adding the presence of DT as a condition fixes this issue.
>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> [nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org: extract from ml discussion]
> Reported-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
> Fixes: 4820303480a1 ("spi: atmel: add support for the internal chip-s=
elect of the spi controller")
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.2+
> Signed-off-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Tested-by: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/spi/spi-atmel.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index aebad36391c9..8feac599e9ab 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1571,6 +1571,7 @@ static int atmel_spi_probe(struct platform_devi=
ce *pdev)
>
>  	as->use_cs_gpios =3D true;
>  	if (atmel_spi_is_v2(as) &&
> +	    pdev->dev.of_node &&
>  	    !of_get_property(pdev->dev.of_node, "cs-gpios", NULL)) {
>  		as->use_cs_gpios =3D false;
>  		master->num_chipselect =3D 4;
> --=20
> 2.1.3
>

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
