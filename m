From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [v3] spi: orion: support armada extended baud rates
Date: Mon, 13 Oct 2014 14:48:16 +0200
Message-ID: <20141013124816.GX27755@sirena.org.uk>
References: <1411910644-7174-1-git-send-email-gerg@uclinux.org>
 <20141011144857.GA17350@gobelin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H/HqDnEH3ZcfIhoq"
Cc: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karl Beldan <karl.beldan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141011144857.GA17350@gobelin>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H/HqDnEH3ZcfIhoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 11, 2014 at 04:52:04PM +0200, Karl Beldan wrote:
> On 28/09/14 23:24:04, Greg Ungerer wrote:
> > @@ -378,6 +452,10 @@ static int orion_spi_probe(struct platform_device *pdev)

> > +	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
> > +	devdata = of_id->data;
> > +	spi->devdata = devdata;

> Won't of_match_device return NULL on non-DT systems, and further
> references oops ?

Yes.

--H/HqDnEH3ZcfIhoq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUO8oQAAoJECTWi3JdVIfQDiwH/1XnWWZYDD1GbvG9capkyVd7
dsg4R4mWOxI8yqB5jhahkVjq6zVuxc0JlU/Z8qlsubENEWJEEqJJZ6gCmrUoPyQu
WE8rZ2kEBCzvEAiRIRvg3a/7yplvHjrqwf/tkadGUUMGP9jPHQSDb0CGKXAEUX9w
Bnqa7TheFZYVTon5CTvYLRy7ci21HJMKq/2R/Yn/EqyjRsYjU2kj1LnJLX5IqKL3
XZuD5j4nchHrHLPzzgdfu3PGXqIvmM6Phx7iwx2m10gXycbtbfubu7hpK7EFzPIq
mTBdF3c/t5/IYyNF6dr71XlgC4Cr7lox4qRFCBKQ9F/qJTwwtw9oMqloesfvlj0=
=eBBN
-----END PGP SIGNATURE-----

--H/HqDnEH3ZcfIhoq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
