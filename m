From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: intel-ssc: add support for Intel SSC SPI controller
Date: Wed, 5 Oct 2016 17:25:27 +0200
Message-ID: <20161005152527.u7jjlo5sd57hazbj@sirena.org.uk>
References: <20161002214408.30329-1-hauke@hauke-m.de>
 <20161004031303.mwn6rk54owuu6eto@sirena.org.uk>
 <c90eff61-2aa9-130e-54de-fd8160ce97cd@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w4bi36jjogpypzld"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c90eff61-2aa9-130e-54de-fd8160ce97cd-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--w4bi36jjogpypzld
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 04, 2016 at 11:56:05PM +0200, Hauke Mehrtens wrote:
> On 10/04/2016 05:13 AM, Mark Brown wrote:

> >> +static void hw_finish_message(const struct intel_ssc_spi *spi)
> >> +{
> >> +	/* Disable interrupts */
> >> +	intel_ssc_spi_writel(spi, 0, SPI_IRNEN);
> >> +
> >> +	/* Disable transmitter and receiver */
> >> +	intel_ssc_spi_maskl(spi, 0, SPI_CON_TXOFF | SPI_CON_RXOFF, SPI_CON);
> >> +}

> > This needs to be done per message or just when the hardware idles?

> I can not find anything suggesting that this is needed after every
> message, just when the hardware is idle we should do it.

Make it an unprepare_transfer_hardware() then and let the core figure
out when to call it.

> Thanks for the hint, I will set bits_per_word_mask. Then I do not have
> to manually check if the mask is supported any more, is that correct?

Yes.

> >> +static int intel_ssc_spi_transfer_one_message(struct spi_master *master,
> >> +					      struct spi_message *msg)

> > Why not implement transfer_one()?  This seems to just duplicate the
> > standard implementation.

> Yes I will look into this. The chip documentation says that we should
> not change the clock while a chip select is active becasue this could be
> interpreed as data by the device. How should I handle the speed_hz
> member in the transfer?

Return an error (you need to do that regardless of open coding or not).

--w4bi36jjogpypzld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9RtmAAoJECTWi3JdVIfQAQAH/3msFGzsWbVOFK1dwHvbHeiz
DxZ6DNYkAyjS2UB4c2PR6VP28b3Ya212FLHqzj7TyNnUpOJbT93P7rEd1BgFHr4k
sXpiEisbMAYiY7Fw/Yg5mSsrzV+XpODE4PxV/KY8CHQNH1CWYzsye92/UZ9ns3c4
HEo4ud/hYqHnwWuztusL/OptMmHVSCtw85BQxRxy6N59yDqbwsbqocHlSZptrIpX
S9mVHDDfLDkxLxFSX3Luh0dhDiZFAB3roxhsYIVt5koX0Rnk1VVdljrnXLcOWGaE
eZIvACZSwL+TaheOeA8zilwljYGFFAxxvgWnzJPC8JD7PNr7DNXSl5iBRXzOlZ4=
=eTQM
-----END PGP SIGNATURE-----

--w4bi36jjogpypzld--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
