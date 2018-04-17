From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] spi: spi-s3c64xx: Do not ignore timeout errors in
 polling I/O mode
Date: Tue, 17 Apr 2018 11:02:24 +0100
Message-ID: <20180417100224.GA8973@sirena.org.uk>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154130epcas1p492c86e911db645acf32d960281e8b297@epcas1p4.samsung.com>
 <20180416154021.25626-4-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5735650673605830508=="
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 krzk@kernel.org, linux-spi@vger.kernel.org, kgene@kernel.org, andi@etezian.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180416154021.25626-4-s.nawrocki@samsung.com>
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


--===============5735650673605830508==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 05:40:19PM +0200, Sylwester Nawrocki wrote:
> Currently timeout errors in polling I/O mode transfer are silently ignored.
> Fix it by returning an error when we time out waiting on the RX FIFO level
> to reach the transfer length.

This would probably have been better sent as a fix before the cosmetic
updates.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrVxi8ACgkQJNaLcl1U
h9Br1wf/cVTNByWAkkqPG+ebbVz8qq1XOZOQ7eWZ/N2fzOlfN6fy+AVoE17xmj+g
Kfjvu/+53KYRnB3hvXr3b8yVpfJLK1WIT1pdy5R3lK9t5nFUeyujigcD6pkKpU54
0KFm5R0hpCJhII5g66yDFIwdcrzLR+SdtpLlNtzfMF1K9U20Kv8DnP8HmU0J3Je7
Eurx2Awr3upyn8mLaClL0c6Nv/4rnycK9KljHoePv7gFoROSqkLchFH0HU0hjXAl
fk9zBx55+rL9m5l1uK+j2+CIZcdpfFGc4GB5I99wfes7fD9J3fEbjI7WPcHd4dyQ
l9Y9I0S+c1qwHBJxGbo5ehxSjRMGHg==
=SMQh
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


--===============5735650673605830508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5735650673605830508==--
