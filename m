From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 17:01:01 +0100
Message-ID: <20131015160101.GS2443@sirena.org.uk>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
 <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
 <525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
 <525D2BB3.4020705@ti.com> <20131015124656.GM2443@sirena.org.uk>
 <525D41E2.30206@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA23446@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4887488867150894910=="
Cc: Peter Korsgaard <peter@korsgaard.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "Balbi,
 Felipe" <balbi@ti.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "Poddar,
 Sourav" <sourav.poddar@ti.com>, Trent Piepho <tpiepho@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
To: "Gupta, Pekon" <pekon@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA23446@DBDE04.ent.ti.com>
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


--===============4887488867150894910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DvkZXeeOEg7hUvqr"
Content-Disposition: inline


--DvkZXeeOEg7hUvqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2013 at 03:33:19PM +0000, Gupta, Pekon wrote:

> Problem here..
> spi_sync() is not blocking, that means it would just add a spi_message
> to queue and return. And it depends on kthread_worker when it pumps
> this spi_message to QPSI controller driver for actual configuration.
> So this is actually a race-condition. You cannot use spi_sync() to configure.

No, spi_sync() is blocking - spi_async() is non-blocking.

--DvkZXeeOEg7hUvqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXWa5AAoJELSic+t+oim9bCkP/3kCaIkVLPBWvKFYVh4iUTFi
XepDkvJfU6+3h2RvvYJODth9MV/GGU0tZtrXhpKw1CoE9IW22lwpvOqrs3QqxZox
G0Svltp13+btRQb7egW0TM9Wy3lNSF0XV8EDS4XVc2ov0cxgpZL++nfEmsC+Vdnp
Bf7/Cf03fSWv/h+erFDGzH44SX2L9bVVzYn0WZJYkbM9F3wSw8klGbsa7COyfojA
Se5e49lUbm3LItAYD3oRGcxg0U31Lbw3f2t9qR0XlEO4QgKA7/Dx0KhXWZknKl9u
95thjWgtLBu9zBOalBCKQe6XbdaC3oAMRjmDglNeLE88SMVj1vIiGM/l7CN9vkuc
yDzSFVkPM6pX4QIPVqCePY5hGgQ17eakMWEjhBmhzPZCB/qlXjMZAnwW7BxZphYt
HByZ6fjNfMeGgmkSdXC1rwcwUb9CJbaRls2hnu0aH5JVXchsTkz66qBA57vjsAyu
Lb/l4PaayryFgNTjrpfwVN5n1isOntD26QAuM8bM3aq5AXeB6AVmakXAkuBZlCYK
ShpBLOmbm39us1TMbmAmQEFA1riD+fZW9idkXYWv6mm/BM1r8hyv8lejL6D2AL5J
/F48lFv3Awg6OXlzW0n42RtzP8TLENS/SFG0Anw0CJoEKvJkbIDdmFWgJ1OtG6qZ
H6VaTEuShWzVeFaeHVlR
=+Qe6
-----END PGP SIGNATURE-----

--DvkZXeeOEg7hUvqr--


--===============4887488867150894910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4887488867150894910==--
