From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/10] spi: Expose spi_{map,unmap}_buf() for internal
 use
Date: Mon, 16 Apr 2018 13:11:27 +0100
Message-ID: <20180416121127.GC20726@sirena.org.uk>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
 <20180410224439.9260-3-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4397939641288136125=="
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Richard Weinberger <richard@nod.at>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-spi@vger.kernel.org,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, linux-mtd@lists.infradead.org,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180410224439.9260-3-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============4397939641288136125==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 12:44:31AM +0200, Boris Brezillon wrote:

> 2/ we create a new header (drivers/spi/internals.h?) for all
>    definitions that are meant for internal use (shared between spi.c
>    and spi-mem.c)

> I personally prefer #2 as it provides a better separation between spi
> and spi-mem code.
> ---
>  drivers/spi/spi.c       | 23 +++++------------------
>  include/linux/spi/spi.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 18 deletions(-)

I prefer that too (if you prefer it you should go with it so it's the
option on the table!).  I'd go with drivers/spi/internals.h though so
that it's even more obvious if something is being silly trying to use
it when they shouldn't.

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrUku4ACgkQJNaLcl1U
h9CJ5wgAgpUXA9I2SZRq2krUOla6ygDObJY6loIIg/CrJLASzhi6JC/ZqI3me5mR
OMrmmZXyLTN5Ri7SZaBvivDbBJ3D4JnguhE9Smz4kw9EGfE75K64mcA2iVMIZ9aj
cudXzuTFUXUWLJ/MEUIA5L9ZTyi2nthn8srO2Ef2GPLBwtbYeqwqJnmXrJBhDK3Z
jAKS3p3PZgeDzHGEArpxTj64eVbtr07NixAQXu1eNq5udVWYTqpA0Fj+udghxWAk
+c8fOrLqZspda8EpKktwgHOTyFJOnVhX+9pgid8nfkVWTUce1aUe5iC0ILJSZ77N
nNuHPLUYuiXroKwyC464boDxIyBzmg==
=Utjc
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--


--===============4397939641288136125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4397939641288136125==--
