From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: s3c64xx: Added provision for dedicated cs pin
Date: Tue, 23 Apr 2013 15:42:56 +0100
Message-ID: <20130423144256.GP5019@opensource.wolfsonmicro.com>
References: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
 <1366614565-3743-3-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o41d8xLWOaLD8vYh"
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	grant.likely@secretlab.ca, t.figa@samsung.com
To: Girish K S <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366614565-3743-3-git-send-email-ks.giri@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--o41d8xLWOaLD8vYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2013 at 12:39:24PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
>=20
> The existing driver supports gpio based /cs signal.
> For controller's that have one device per controller,
> the slave device's /cs signal might be internally controlled
> by the chip select bit of slave select register. They are not
> externally asserted/deasserted using gpio pin.

This doesn't build:

drivers/spi/spi-s3c64xx.c: In function 's3c64xx_get_slave_ctrldata':
drivers/spi/spi-s3c64xx.c:1023: error: 'sdd' undeclared (first use in this =
function)
drivers/spi/spi-s3c64xx.c:1023: error: (Each undeclared identifier is repor=
ted only once
drivers/spi/spi-s3c64xx.c:1023: error: for each function it appears in.)

--o41d8xLWOaLD8vYh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdp22AAoJELSic+t+oim9HZwP/Rfy/Hh2QPJA+xs2wZULjlZ0
9t1q4NKWSm5t7Q06uiHr8Pw0CWWFg5JE/YLKOv/3l96BSq+m+qvcPxyQX8UoTfUv
Fb28SIc4iixHo264z0y/of7EM3v2f+w6Yga0emVwYd06f4yhEo7kbSXyZCUekbKF
3vy+ikkJCM6m/5fmP83Ho0MAF1YfwJyx7qncjCh8lUbKLXFyOOfdT8uCJui+SYup
WV5SldLm7z5emzrp6PDHAMZaVB+jbNFmOoR6ZLYGEsOTdNwVjVtta2F5GICeOxGM
4TQRd99vgHf1bzhrLOcGamgTUSKgVRmi2cU7dfBY6BVPB/oWjMJnlyftM95QMT+F
TRsyVsC6kx0hzEHd+u+BUtMFkPkflK/496I60WTX0O2cjYdZTAOu65NRDtzocbW5
Koaydd+OFiYC1zD8eQR2GnqsNJyZeXgSzZsmoijGhyUbKV/34xVaSwHfNyeGp6q6
HpHBhzikEwpwO+iG4Kl3KMA4lNEv31CdXhpbyxYQl8ETGc2LsOl6rack7EPLITF6
EqukUNxbj7gYBtdxDg9JN+hu/mck5VP5cQ0UQ9q4DxbN7ygKyYymtchp/Sl3D+DV
EA5EZXjxjlvswFzx357JaLShpy9/LR1zn0FuFm8EMdkssUp3YasftC4aC4PQ98ZI
lqAjTfHZ+cXsmF9+X94X
=FC8B
-----END PGP SIGNATURE-----

--o41d8xLWOaLD8vYh--
