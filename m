From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/18] mtd: spi-nor: Proposal for 8-8-8 mode support
Date: Fri, 19 Oct 2018 13:25:27 +0100
Message-ID: <20181019122527.GJ5895@sirena.org.uk>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9011056591577273314=="
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Julien Su <juliensu@mxic.com.tw>, Richard Weinberger <richard@nod.at>,
 linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 linux-mtd@lists.infradead.org, Mason Yang <masonccyang@mxic.com.tw>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181012084825.23697-1-boris.brezillon@bootlin.com>
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


--===============9011056591577273314==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
Content-Disposition: inline


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 12, 2018 at 10:48:07AM +0200, Boris Brezillon wrote:

> First question that might come to mind is why should we support such
> stateful modes? If you think about it, the gain of transmitting the
> opcode on 8 IO lines is rather small compared to the pain it is to
> teach the SPI NOR framework how to deal with that. The problem is,
> some SPI NOR manufacturers (Macronix for instance) only implement 1-1-1
> and 8-8-8 (or 8D-8D-8D), and they want to be able to use their NORs in
> 8-8-8 mode when the controller supports it.

The SPI framework changes definitely look OK to me, if everyone agrees
that this is a good way to go from a MTD point of view I'm happy to
apply them.  I have no strong opinion on the MTD bits of the series.

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJzTYACgkQJNaLcl1U
h9AHxgf+KPJafqQ5ZnA02BlSPDiXCiC0dgf/Ee+Vj5GA+bFoZ0CXyiYCBhX9wh2o
xK06Xd+OomhhMDFV7SX3yfR4s84xgS/x2mXtXTE+t5ED161LTi6frnRQWOQ/vAum
CceDRf41Hoj9QK75oBF/CYNJo2xrYrWXKHoRafZx/4gVTPz67KfykIvYAQ878hWf
p7cFCyFTXfrupDORGFZqo5XUBnPCFsgTchH2qg/TaxOlquaQYNVnYqozlWM+4VlL
EWaI6q+p+CPhk6fZe14Hxl+WyQfDhnmVzX8/Nys/36Wbzej1Re95ZSZ7bjz1AwBq
QCu0a3ARqjBqTUjlDOk+kYQgRcX9wg==
=qu6u
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--


--===============9011056591577273314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============9011056591577273314==--
