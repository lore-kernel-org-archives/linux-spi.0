From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/10] spi: Extend the framework to generically
 support memory devices
Date: Tue, 17 Apr 2018 11:57:13 +0100
Message-ID: <20180417105713.GC8973@sirena.org.uk>
References: <20180410224439.9260-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1900722782764160481=="
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
In-Reply-To: <20180410224439.9260-1-boris.brezillon@bootlin.com>
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


--===============1900722782764160481==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 11, 2018 at 12:44:29AM +0200, Boris Brezillon wrote:

> In this v2, I think I addressed all the comments I had except the
> advanced direct memory mapping stuff mentioned by Cyrille, but I don't
> think any of the work done in this series prevents us from adding this
> feature later on.

I'm pretty much OK with this, there's a few small bits to be addressed
it seems but it looks good overall.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrV0wkACgkQJNaLcl1U
h9CZoQf/a+SZVy8o3vQ6NykHLZMDfH66KJMqpQq+Din8bbLl4p/n8GH50hU4AbK/
YOq/KfcWLFw9ql5+JGV5dqdHL1rgQDx0LQA0yDw3RDY9yijF4EgevTD8jmUK4iIN
Imme9bHaZFwADAazz3bxuDfjADzLXZkgHQ8r2CQ3mWGPJU+wfcoA1b+koEQLtlMt
xZ62m/bXWQv5pXBNMATIUyRUQnFnuWVU/SInmxDxaj3VBxJnNd3C/bb1YmdY5v/b
IM8/6wu7PVMbCD9Xh1nz54+Wl0sB11a9jSGLLUhwLReBexhOpEj3IMFi78P4HE51
6ckZH1NtvoCYQLlJNUFyl7fzsDwuog==
=iUuM
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--


--===============1900722782764160481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1900722782764160481==--
