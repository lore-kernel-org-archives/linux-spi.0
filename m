From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] SPI-txx9: Deletion of an unnecessary check before
 the function call "clk_disable"
Date: Mon, 1 Dec 2014 19:25:40 +0000
Message-ID: <20141201192540.GM7712@sirena.org.uk>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <547A050C.5040906@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3dMOQFbIPOCGfYdm"
Cc: linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <547A050C.5040906@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3dMOQFbIPOCGfYdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2014 at 06:40:28PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 29 Nov 2014 18:34:20 +0100
>=20
> The clk_disable() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.

Applied, but please do try to use subject lines matching the style for
the subsystem.

--3dMOQFbIPOCGfYdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfMCzAAoJECTWi3JdVIfQ0T4H/0xhWZpQIq2arup2m4KilsRg
zwchhHnOwmPcomLlJMa/6evEBP2drBpJkpzPs5vwpPI+0/ctiNFuxyq9f4OWlGJ8
hrnCL0N/Qz6B9Y5GnJDSQL+sZwr1GFkM5T0nba72dc32HTuibwqvjPwhbZsekw2A
+ekjRnL0qk0jfS2VNHNFzR+0WN8TX0B2GfVWNRhpLlGIsN7z5+ociFKLZvC57vsN
BKebhg2bzf1nWepTcSa9NIJEXG7TB8X8F1z7WBuJmot8NxP3o0yWdIhyicP1H2tk
3eXMIy17TM192FNyPv1fbeIeYjYZ3zM6XOylZlZPtsw0NRUId+miywL7Vb8/jgM=
=wFaD
-----END PGP SIGNATURE-----

--3dMOQFbIPOCGfYdm--
