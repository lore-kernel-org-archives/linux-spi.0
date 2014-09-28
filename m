From: Mark Brown <broonie-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean
 up chip identification
Date: Sun, 28 Sep 2014 12:35:11 +0100
Message-ID: <20140928113511.GX27755@sirena.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PpfQBwiAIZcuDX26"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410714624.3040.38.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PpfQBwiAIZcuDX26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 14, 2014 at 06:10:24PM +0100, Ben Hutchings wrote:
> The first patch in the series restores the module aliases to m25p80, but
> it does so by duplicating the list of names.  This should be suitable
> for stable, but it isn't viable in the longer term.

Please don't CC patches not for the SPI subsystem to linux-spi, they
just clog up patchwork for no benefit.

--PpfQBwiAIZcuDX26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJ/JuAAoJECTWi3JdVIfQ40oH/ivrIeotI6hkkh/1jCCF4kWk
VTJS8gB9pdoWBkuHwOSPBbS+VW83CzzGABp5I9noxMGTtzLQZWH0gcNrrwXhFj4a
OY9sDiqWS4lhX7oh1g6myD/7ll5AoXoJ69+B1Y8v+JqIWqoTGzU/qC4/raoSU1EW
pt8VV02kMrrXIAqs53pZ4WcfCj7e6y2aQC/xt2tj/2W0r4dukre4Xv0cgmwNUiU1
qoobzVTZtCHbuYHdhMvKjufrSHYHiQiuWLhU61inxLV6oOd4GYWGmqWKBjTLrF2E
c+ofNShOnb6AoOrWfLEtY5Z+nXeNZ0Xg5AJMaEyiYZhPmTS2NprPJNpEmBVoCk8=
=kpAW
-----END PGP SIGNATURE-----

--PpfQBwiAIZcuDX26--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
