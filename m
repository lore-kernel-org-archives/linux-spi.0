From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: orion: Fix maximum baud rates for Armada 370/XP
Date: Tue, 26 May 2015 11:36:50 +0100
Message-ID: <20150526103650.GM21577@sirena.org.uk>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1421285698391086533=="
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Tawfik Bayouk <tawfik@marvell.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-spi@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432633484-18758-2-git-send-email-gregory.clement@free-electrons.com>
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


--===============1421285698391086533==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RzoDHZBRv7fez6cK"
Content-Disposition: inline


--RzoDHZBRv7fez6cK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 11:44:42AM +0200, Gregory CLEMENT wrote:

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reported-by: Kostya Porotchkin <kostap@marvell.com>
> Cc: <stable@vger.kernel.org> #Fixes df59fa7f4bca

Applied, but please format this stuff in a standard fashion - use a
Fixes: tag to reference commits you're fixing.  This makes it easier for
tooling to work with the information you're providing.

--RzoDHZBRv7fez6cK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZEzBAAoJECTWi3JdVIfQ0YIH/AntfoJrPyRh9/Xt8Xh7L81m
pL1JmYf81pDU/rpUtijQ1Z2jfHy+3OyedaE+r7mZ7YWTKTpKXT9yhtY94eHT1dSH
ytIShvMSeCt/38tGJjRyHUb25rBRjqLliP2xyWXzWV+G67XDWLY6V5KLaXOgSXUI
qcCXLkCOmM22OthRUUb+qkqGX9Znvnc9BpoBLSVCU/IzEdJhU+RBreSd8uFXoCaY
I9gPd0C0H9vxoXu0NH2/s3vclAcfypHPX+8+A6zIaIb+lxa9g0daLWcsJhAOxLUQ
/1a3x23JrrG3EV12OAGxMKTGM4L0yWRqoHLt/rX+IGbblMSx5BOmXTT0V/SLh04=
=loyq
-----END PGP SIGNATURE-----

--RzoDHZBRv7fez6cK--


--===============1421285698391086533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1421285698391086533==--
