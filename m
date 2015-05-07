From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1 v2] spi: Re-do the returning value of
 rspi_dma_check_then_transfer
Date: Thu, 7 May 2015 13:57:44 +0100
Message-ID: <20150507125744.GX15510@sirena.org.uk>
References: <1430359932-13245-1-git-send-email-cm-hiep@jinso.co.jp>
 <1430359932-13245-2-git-send-email-cm-hiep@jinso.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkHPdTSmtjV9vJ2x"
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org,
	kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430359932-13245-2-git-send-email-cm-hiep@jinso.co.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kkHPdTSmtjV9vJ2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 11:12:12AM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>=20
> To reduce indentation and complexity of code, insteeds of returning zero
> the function rspi_dma_check_then_transfer should return rspi_dma_transfer
> directly after checking error.

Applied, thanks.  Please use subject lines reflecting the style for the
subsystem and don't send cover letters for single patches - if there's
any content in there it's usually a sign that the changelog is not
detailed enough.

--kkHPdTSmtjV9vJ2x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS2FHAAoJECTWi3JdVIfQ3k8H/0YNH5bwhcWTgqnzJV3k68Nu
8/J5HI9Rt1dMLxrN/aZSfCm9TT3KlAeV/Qzr730LLiBrVpNdhiO8OfgoedoFMqGy
37kROlRAtTWO7F+Wu0zi9XdGqqUqsKzcD9eTnog4AC12SSpSZ1Af/c8Ll/ZEU1yM
6zI+UxTph05GmJACGzBHykil0FL+pHywki8W5TRapcHU6ltsh4zDCe6QI5kTpHUe
8mGKp8FWIV2ANQJ/wKDzaI7hrIm/NugKra4cFye/ybwAdcx93VhqopD4nBum5Nqg
PAd3sOymYPMNiNUj6YuiaZ3lWzotcOyqqPlLYP+iIbJjwIoWPH4Q/sj6spBetbs=
=J08m
-----END PGP SIGNATURE-----

--kkHPdTSmtjV9vJ2x--
