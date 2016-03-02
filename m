From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] DT: add documentation for spi-fc-test driver
Date: Wed, 2 Mar 2016 11:17:55 +0900
Message-ID: <20160302021755.GQ18327@sirena.org.uk>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
 <1456843400-20696-3-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B8XbdO3LMJiqT+9q"
Cc: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456843400-20696-3-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--B8XbdO3LMJiqT+9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2016 at 03:43:17PM +0100, Oleksij Rempel wrote:

>  .../devicetree/bindings/spi/spi-fc-test.txt        | 30 ++++++++++++++++++++++

We should not be supporting DT bindings for a test device that doesn't
represent physical hardware, this is an invitation to abuse by people
writing bad DT bindings for actual hardware.

--B8XbdO3LMJiqT+9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1k1MAAoJECTWi3JdVIfQ148H/jPnO/pxjlepVBYqt6I7gYlA
sy6zTfK4lb5YSuLDNZjWlA7odry6WDn7mxzGsGRjsrctfnZXfzmiFCSSeLjI5LzH
B+uonzuKVeLUdTN4FkbmXzG9Fhg4UJecQWnTAu+VVgH/zBhPyek2xCrf0Eyhm1WB
OGcVbPCfSshXp0tcqyyKuC4nSWs5CLw8SoaWg5R/meynrLQj1y3RATSBMAfnBOWv
n48LTby/l1rkbremW1GumobYU7t3/xWbmVniouFNnnSFcmeeoOLziHoqqe1UI+FU
zgg/NcouS7bIURn2DUlLZ+NZoaUi6RQOWjwF3T13NYBjyw2iWw9v7GZoXmcOD5o=
=bTe1
-----END PGP SIGNATURE-----

--B8XbdO3LMJiqT+9q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
