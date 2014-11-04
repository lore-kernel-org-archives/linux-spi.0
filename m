From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: spi-gpio: Add dt support for a single device
 with no chip select
Date: Tue, 4 Nov 2014 19:57:32 +0000
Message-ID: <20141104195732.GX3815@sirena.org.uk>
References: <1415031475-2268-1-git-send-email-torfl6749@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="umhhH1MY3lvPZrwj"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415031475-2268-1-git-send-email-torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--umhhH1MY3lvPZrwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 05:17:55PM +0100, Torsten Fleischer wrote:
> From: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> In order to describe a single slave device that has no chip select line
> the 'num-chipselects' property has to be <0> and the 'cs-gpios' property
> doesn't need to be set.

Applied, thanks.

--umhhH1MY3lvPZrwj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWS+sAAoJECTWi3JdVIfQ2zoH/AtLkp1eNCvq46l7yZU6Cy+9
DUB96pmHjF1HozvCcFPzuS9S+6JUJYxmoVYltYKt6hb5D/Pgta7z3Iwo9BTwe/pt
/bW4S7wCb2Bu2yfZ4Heu2vftWhUXc3cwfi0VPT7qsCch+EOEHH3cw3W0vFcPVq2+
YH+EG6wOHhrVWojX6YsOH/0Trl7YAsWKC1sqI/E7IKnr6C7c/KQ/KJV3FIhpIDtN
cqCVZ0YIpozGCqmAPWMCTkJlYaxXVahiXixqZ4o6OJ9K0j5khHLPhxjWK9KTJUU8
QsSiQbVLRkbFa58Xv7DB2azHpB87JaJR6aMXbyKuX04DBfg4/7HQVY0SlFdIW8U=
=nmig
-----END PGP SIGNATURE-----

--umhhH1MY3lvPZrwj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
