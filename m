From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm53xx: driver for SPI controller on Broadcom bcma
 SoC
Date: Sun, 17 Aug 2014 09:21:17 -0500
Message-ID: <20140817142117.GI14537@sirena.org.uk>
References: <1407933212-20530-1-git-send-email-zajec5@gmail.com>
 <1408228864-20313-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408228864-20313-1-git-send-email-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2014 at 12:41:04AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:

> +static inline unsigned int bcm53xxspi_calc_timeout(size_t len)
> +{
> +	return (len * 9000 / 13500000 * 110 / 100) + 1;
> +}

Magic numbersr!

> +static int bcm53xxspi_wait(struct bcm53xxspi *b53spi, unsigned int timeo=
ut_ms)
> +{
> +	unsigned long deadline;
> +	u32 tmp;
> +
> +	/* SPE bit has to be 0 before we read MSPI STATUS */
> +	while (1) {
> +		tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
> +		if (!(tmp & B53SPI_MSPI_SPCR2_SPE))
> +			break;
> +	}

This could block for ever, there should be a timeout of some kind.  I'd
also include a cpu_relax() in here since it's a busy wait.

> +static void bcm53xxspi_buf_write(struct bcm53xxspi *b53spi, u8 *w_buf,
> +				 size_t len, bool cont)
> +{
> +	u32 tmp;
> +	int i;
> +
> +	for (i =3D 0; i < len; i++) {
> +		/* Transmit Register File MSB */
> +		bcm53xxspi_write(b53spi, B53SPI_MSPI_TXRAM + 4 * (i * 2),
> +				 (unsigned int)w_buf[i]);
> +	}
> +
> +	for (i =3D 0; i < len; i++) {
> +		tmp =3D B53SPI_CDRAM_CONT | B53SPI_CDRAM_PCS_DISABLE_ALL |
> +		      B53SPI_CDRAM_PCS_DSCK;
> +		if (!cont && i =3D=3D len - 1)
> +			tmp &=3D ~B53SPI_CDRAM_CONT;
> +		tmp &=3D ~0x1;
> +		/* Command Register File */
> +		bcm53xxspi_write(b53spi, B53SPI_MSPI_CDRAM + 4 * i, tmp);
> +	}
> +
> +	/* Set queue pointers */
> +	bcm53xxspi_write(b53spi, B53SPI_MSPI_NEWQP, 0);
> +	bcm53xxspi_write(b53spi, B53SPI_MSPI_ENDQP, len - 1);
> +
> +	if (cont)
> +		bcm53xxspi_write(b53spi, B53SPI_MSPI_WRITE_LOCK, 1);
> +
> +	/* Start SPI transfer */
> +	tmp =3D bcm53xxspi_read(b53spi, B53SPI_MSPI_SPCR2);
> +	tmp |=3D B53SPI_MSPI_SPCR2_SPE;
> +	if (cont)
> +		tmp |=3D B53SPI_MSPI_SPCR2_CONT_AFTER_CMD;
> +	bcm53xxspi_write(b53spi, B53SPI_MSPI_SPCR2, tmp);
> +
> +	/* Wait for SPI to finish */
> +	bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));

This means we can only do unidirectonal transfers from the look of it -
is that a limitation of the hardware (from a quick read it seems like it
might be)?

> +	/* Wait for SPI to finish */
> +	bcm53xxspi_wait(b53spi, bcm53xxspi_calc_timeout(len));

No interrupts?  This will busy wait for the entire transfer which seems
a bit much.

I'm also not seeing a set_cs() operation here.

> +	err =3D spi_register_master(master);
> +	if (err) {

devm_spi_register_master().

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8LpaAAoJELSic+t+oim9eTUQAJU4pb4r044w7Or4Xo/29jI7
+isdysdmfy57d8fPR73uVtMkUadCajHc43P+9F5/RxmdxtWletLj99ui0klZb/os
/MUXua8+RbYsGPIkT1+0B1Kj20hBaR22wminL1INbRmK3hGjrxuOn6MK/oEH8yLZ
K4CISii14va6h4T7b9wPqb5Az/g8Kq3/6JuJzUERpGvx4w9MwotjB42LkfNVIOGc
5Ye0weaAoNjoaR0XgJ400n4zBzPPjuX1JxjYMzd5B/gAavsRroRBEVLXYwyjYqex
uX+G4vYatrdfdKPsS+FQWm0cBdNFJjHTT1BwklCdWLBeVNA84Lsk7fZgFtyOtQg9
wXN37rwZ40Ij8IsQVO0lnFZkSrHjhkBt+ACJXYvhIft4okrusCAV/K5H/a5TP7Sl
PRHLcsebR2A/s8IvmBmbNf4iE5SNIG7FhIlcR19pDqaY2t4YDzfmY17SJ1YJ6Xnu
kpov1YHA1TJu3oQY/zN9Hd9gN0b6vZrSOjbdvlsvtxxqUK+SHIK2SNmD4R4rWLU4
R4Tc6vU7eG0ucQKed3TPZwG+Z0cgSovPSmxlGnuN7A/pii+kphe8nKlVC5MkDtHJ
cd16WIQA15JC0GA5vUdWDYy7YIE/U4DHMLgcQteaUWWgkckZvKTRuDRfHPN+tdZn
8Di4xR29VDhcQ222FOg1
=4lMH
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
