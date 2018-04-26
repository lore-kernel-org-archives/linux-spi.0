From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: Check presence the of ->transfer[_xxx]() before
 registering a controller" to the spi tree
Date: Thu, 26 Apr 2018 13:37:17 +0100
Message-ID: <20180426123717.GF21755@sirena.org.uk>
References: <20180410224439.9260-2-boris.brezillon@bootlin.com>
 <E1f830e-0001Lz-Vf@debutante> <20180426141401.26748b74@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3603999463108695653=="
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Brian Norris <computersforpeace@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-spi@vger.kernel.org,
 Peter Pan <peterpansjtu@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180426141401.26748b74@bbrezillon>
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


--===============3603999463108695653==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Content-Disposition: inline


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 02:14:01PM +0200, Boris Brezillon wrote:

> I can't find this patch in any of your spi branches. Has it been
> intentionally dropped, and if it was, do you remember why?

No, not dropped intentionally.

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhx/wACgkQJNaLcl1U
h9DEJQgAhpMieT/HRPrpCkDMVcGzdQkjF9fMZipe8lkGt30i4GnO5WyRc8lY9e05
zUZeVyKO6zl+2k6Lp2MzbPcVg6SJiAQqWk8VgzFmxpPkO7lg15jUaj9TI3jELYL1
by7MR4zZXmdDOkixQrSZs7kM79o7RbyCxps4JbgrZ4vDZ/XTnING3ATivJVv03Mz
PWI2OYUjnkcoKKlLed38Di7co1pqE/aml5AVa2LRsrTYh9vQZC9hXu1HUP/J1Cqw
q0yTvbVJBFiXNC8HBWZ8k2gXxDBpxUOO5LO62LUV4HL1eguRcgf10k++sWav9a2k
ZJJS1VsAKla1NtJHn+MVtx87NhsHpQ==
=olQd
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--


--===============3603999463108695653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============3603999463108695653==--
