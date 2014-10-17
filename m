From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Fri, 17 Oct 2014 13:13:49 +0200
Message-ID: <20141017111349.GC1820@sirena.org.uk>
References: <1413497251-21954-1-git-send-email-tthayer@opensource.altera.com>
 <1413497251-21954-2-git-send-email-tthayer@opensource.altera.com>
 <20141017065233.GA10262@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Cc: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org,
	baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141017065233.GA10262-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2014 at 08:52:33AM +0200, Steffen Trumtrar wrote:
> On Thu, Oct 16, 2014 at 05:07:31PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:

> > +			bus-num = <0>;
> 			^^^^^^^^^^^^^^

> I think you can/should get rid of this property. It is only used/documented for
> fsl-dspi as far as I can see.

Yes, and it shouldn't be there either.

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQPnpAAoJECTWi3JdVIfQt6IH/jxvrPY4x5yyqoJ1Y9Uk5w5H
tHCx5HGbGiFrZkBcGUhAnuCieGl6lCpP4dleQ05JWielKU+wp4BGhQSSrVjSsNCC
Mlpq3yknXFdq+VJXcwMODDEBtDketYdMCatUp5QtFrA9ZXcI5nanFwEPsdLS056I
fJiwPpSEncMrPia8w9KiOdVBBufvkNZ9B4VLWcQXCZNO9awgbrDBStoACAYBuoWw
oluk9Zi1uUCMVUeTCXnOFdajZkFhcbU/jYU1DqbYuyaAcNGCQsDT0RyBzuXgiR7k
uTvGTD8giVaEjw8NZK3PJBdQXUFiSUFNuVne/pKLwk2ttV7eDFoV/pQucHhfYcE=
=y4AR
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
