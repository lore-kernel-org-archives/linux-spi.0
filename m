From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 5/9] spi: bcm2835aux: fix driver to not allow 65535
 (=-1) cs-gpios
Date: Wed, 3 Apr 2019 11:32:08 +0700
Message-ID: <20190403043208.GB5748@sirena.org.uk>
References: <20190330093106.20723-1-kernel@martin.sperl.org>
 <20190330093106.20723-6-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3443038189894913339=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org,
 Hubert Denkmair <h.denkmair@intence.de>, linux-arm-kernel@lists.infradead.org
To: kernel@martin.sperl.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190330093106.20723-6-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============3443038189894913339==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2019 at 09:31:02AM +0000, kernel@martin.sperl.org wrote:

> Fixes: 1ea29b39f4c812ec ("spi: bcm2835aux: add bcm2835 auxiliary spi devi=
ce...")
>=20
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

There's no need for the blank lines after the Fixes tags, and they might
potentially confuse some scripts.

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykN0cACgkQJNaLcl1U
h9CHVAf9HR4zk3a8M8HN2x636XT+qTn0a20b6OqaNt+qGcDNolfUvBtI4eWsgHM5
i2ci6xx+9HOQdvQu4LPk7WobcbrQK7EP6PPYZR3QwnyXqDrkvO8YO8CMLup4ib+h
otfIwjub4rhCKBC1xVRrCIOe/9e1O4qutPobk1LcE1dsTZOBBDiwovh/yBg6LkTy
ocuB4XUoB/lZoJHk31EHptmKrK0/4dGB9G9qjwy7hlfEFAd8quit9kLJ2rzdmYlK
in7v7pQL8MAbUcnSln2PVFkzZhi9xeM9xV/SWXZnN30CipqiozfoGVE0xQpFs+RT
NjEnAB4eqx+rMhK7BKboXyS4+qNWuA==
=IqG5
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--


--===============3443038189894913339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3443038189894913339==--
