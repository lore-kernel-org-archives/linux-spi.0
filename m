From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/18] mtd: spi-nor: Proposal for 8-8-8 mode support
Date: Sun, 21 Oct 2018 14:36:00 +0100
Message-ID: <20181021133600.GE8554@sirena.org.uk>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
 <20181019122527.GJ5895@sirena.org.uk>
 <20181019145920.43f9d5ec@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5954474173847264477=="
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Julien Su <juliensu@mxic.com.tw>, Richard Weinberger <richard@nod.at>,
 linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 linux-mtd@lists.infradead.org, Mason Yang <masonccyang@mxic.com.tw>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181019145920.43f9d5ec@bbrezillon>
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


--===============5954474173847264477==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 02:59:20PM +0200, Boris Brezillon wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > The SPI framework changes definitely look OK to me, if everyone agrees
> > that this is a good way to go from a MTD point of view I'm happy to
> > apply them.  I have no strong opinion on the MTD bits of the series.

> Actually, Yogesh posted similar patches before me, so maybe you can
> look at this series [1]. The spi/spi-mem side of things is rather
> uncontroversial. Feel free to apply them if you think they're good
> enough to go in.

Ugh, unfortunately he didn't send me them so I'll have to try to find
them on the list and it looks like there's been no review from any of
the other MTD people.  It'd be good to get some consensus, yours seems a
bit more complete so my inclination would be to go that way.

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvMgL0ACgkQJNaLcl1U
h9DZ6wf/cnQtBWcvGvsEUyUogeZOm9SrDiC4eCgj+xC1bxOYdJChmLpSpZIC0npZ
iVBUmJ3EXQFQ6XhYFW3WcfprR187gdCaibG2nUnk5MZvbsXmaWIOcBKo06XejpHR
59sbMO9ODLCK3u7KZHW7AhnOysU7O+/bnHTwc8aTyRhKvBIw6fSC7+qT7O/DNzOJ
T3C4VlwcFL4b4iTc3Awe4Sj2Nxm76eqn6L0I7d110XwFKEpDEOKjooSk5BGoXCtQ
WwV5GMbBMKVJDHi6tdSB1PmnmDHP5Ov6Kf2nUHsao5Us/SHS0Ob8HI0q3K9iVE2f
NO9tBwp9VxBaSkDkmdMv63eUHVOMnA==
=XkDj
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--


--===============5954474173847264477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============5954474173847264477==--
