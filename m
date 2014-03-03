From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: sirf: provide a shortcut for spi command-data
 mode
Date: Mon, 3 Mar 2014 11:22:41 +0800
Message-ID: <20140303032241.GB2411@sirena.org.uk>
References: <1393648697-16865-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cJfXB9mphngkt5vq"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393648697-16865-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cJfXB9mphngkt5vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 01, 2014 at 12:38:17PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> there are many SPI clients which use the following protocal:
> step 1: send command bytes to clients(rx buffer is empty)
> step 2: send data bytes to clients or receive data bytes from
> clients.

Applied, thanks.

--cJfXB9mphngkt5vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE/V4AAoJELSic+t+oim9CycP/12xz+lWhRiyOEhmL4CoO0qC
V59Bii3h6YYf58EQVAjwUlaNbX0AFDTT7sDIBRFXBEUMi14+x9eIu0cisYJqqQD7
LfFJT427X1JxXOu1xHMTCDDpIdTbV3h9bdsxN+7Vv86LHGoCLbcRS2vrmRoHv8A0
NcsztgZOC2KoxJJt88v61cO6uI3w/7T2JcpPSP2ddi2hI2KKF+4pxav8RY4Pt2eJ
0N4yyIQWndNf8DTJBHRjOhL/oxk6F9iYu37qAB7WkQVIlpY6tMEPDCdRB2leydwO
1CqZ2jjacXUSM0+SHblz0RBMS6xEAuNP9pYLtRttMqKbYA0SeJSLUWqh+1v0PuoZ
/DNVtO2qUdYQM9eN3y7vK0IWYsY2N58PYHyBIEgXF3TBdXmHrTcgCOSNGRb9P054
x4Ou8RGvF5N5fd0zlezID26JTYUZp2u6Ynwz3yB54PT7SMKb7ssxnUHJ1BuqbF1W
ozaoWiuabgWwDSMu9bLu9iMN6G9cC7+Q41/sDswy7P7M2YH9nEpO1Snw1NwMVrnf
kLqZZIah9mIQfXpnKDBEGB0vAyMbDtZtgZHGZ/fgR65V4JWmJA+2enBBa5n7JeEZ
Y6zjmzDvW4Xa06HAhKWmGjedCRCV2rzZP/Wo3CgZI2OArOwUmdNFweG+5UxK3CCz
Ka2Um7NPT/CQ58bBf7i+
=0RpB
-----END PGP SIGNATURE-----

--cJfXB9mphngkt5vq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
