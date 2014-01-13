From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 4/9] spi: rspi: Add DT support
Date: Mon, 13 Jan 2014 12:08:44 +0000
Message-ID: <20140113120844.GM29039@sirena.org.uk>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-5-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XZn3P0VKTizxZG2b"
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389525222-3482-5-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XZn3P0VKTizxZG2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2014 at 12:13:37PM +0100, Geert Uytterhoeven wrote:

> +Required properties:
> +- compatible       : For Renesas Serial Peripheral Interface on SH:
> +                     "renesas,rspi-<soctype>", "renesas,rspi-sh" as fallback.
> +		     For Renesas Serial Peripheral Interface on ARM:
> +                     "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
> +		     For Quad Serial Peripheral Interface:
> +		     "renesas,qspi-<soctype>", "renesas,qspi" as fallback.

This should specify what <soctype> is and ideally list the valid values
or at least the convention for writing them; perhaps a list of SoCs in
some common place would be useful for sharing between all the IPs.

> +- interrupts       : Up to 3 interrupts for RSPI (SPEI, SPRI, SPTI),
> +		     1 interrupt for QSPI

For multiple interrupts you need to say how they are identified - if
they're not named the order must be specified.

> +Pinctrl properties might be needed, too. See there.

Where?

> +static const struct of_device_id rspi_of_match[] = {
> +	/* RSPI on legacy SH */
> +	{ .compatible = "renesas,rspi-sh7757", .data = &rspi_sh_of_data },
> +	{ .compatible = "renesas,rspi-sh", .data = &rspi_sh_of_data },
> +	/* RSPI on RZ */
> +	{ .compatible = "renesas,rspi-r7s72100", .data = &rspi_rz_of_data },
> +	{ .compatible = "renesas,rspi-rz", .data = &rspi_rz_of_data },
> +	/* QSPI on R-Car Gen2 */
> +	{ .compatible = "renesas,qspi-r8a7790", .data = &qspi_of_data },
> +	{ .compatible = "renesas,qspi-r8a7791", .data = &qspi_of_data },
> +	{ .compatible = "renesas,qspi", .data = &qspi_of_data },
> +	{ /* sentinel */ }
> +};

No need to actually list the specific SoCs given that the fallback is
mandatory and the resulting data is identical, if you are going to do
that then I'd have the compatible set num_cs too.

--XZn3P0VKTizxZG2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS09dJAAoJELSic+t+oim9ITQQAJFvmB+J5nL40HAKjm4GiqRo
myewemRmMSQVPcbvR2sqNvsMfT5mHZc+BzdfYQISFgQ4stPfEtScKJcI4sl7K0Ao
D1yWdSzuyq2JTFPQBuAars9RxN/dEll2BY1zIbHmyyMfthN19vW/EN/LXQM4ZxLt
losGJCegTxm9HgZinazsmDLSfVV+NAdq6t+4S60+rWVcqOiUfbus5Cg7OZZHQOfH
bY0lRtbO3/K8boNeqUkvzvjDrH/VWyJl7Hga9a31aHUf7vBfYpO7DfHm8i7sYokw
XV4M9iBeSEvmbONT2F6HZcOdxF/vSPHiurtGbPXetk5acneS0rMoMbjTCypoZC5A
MNFULzTCQKu8Vak+CUqm0aJlU5qt5lJH0cXFKNxSm+kmmFdNZAr33QMNRAyioGOk
M9cdVe3oCm8vND3WHQjSsshv5UjUUNMZT/DhmOBTFi6+cnHZTDtmj+N0DD7hhAc4
ZNpjIXGjq1ucHuRt1sTtAZa9X7626ZjILpXtxtEkNyMy3h41XfRolcB7z0KvBenl
JV2DdR+vTYe/Y01xw0q1WOLXgNAnKFLwURzWT/oRickJflxd5MDn7RhqhcH8fnro
i0RfvuKxNj9ytr8uUM/ChiJzzzNCsWVt+LZRv/ikScJ0Ty9cjvBmdL8Z2CXWkCq4
4JEUKpyHG1sJPYfqnmZK
=dMNp
-----END PGP SIGNATURE-----

--XZn3P0VKTizxZG2b--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
