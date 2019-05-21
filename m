From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: sun6i: Add default address and size
 cells for SPI
Date: Tue, 21 May 2019 16:29:25 +0200
Message-ID: <20190521142925.bryspvr7gtits5yl@flea>
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
 <622e3d2ece14e5b84a7975026bb1a981228ee3ab.1558363790.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1690917841433595883=="
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <622e3d2ece14e5b84a7975026bb1a981228ee3ab.1558363790.git-series.maxime.ripard@bootlin.com>
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


--===============1690917841433595883==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hidp36y4x4lmbvra"
Content-Disposition: inline


--hidp36y4x4lmbvra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 04:50:36PM +0200, Maxime Ripard wrote:
> The SPI controller bindings require an address cell size of 1, and a size
> cell size of 0. Let's put it at the DTSI level to make sure that's properly
> enforced.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied for 5.3

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hidp36y4x4lmbvra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOQLRQAKCRDj7w1vZxhR
xa4tAP90agmm4bwpSelFojJE/k2pi16ny4VH2dp4uVgB35fCdAD/WErlps7dg9uQ
517cMenZoCTA7hr+o7V2P9I/TKr9cQs=
=7tJA
-----END PGP SIGNATURE-----

--hidp36y4x4lmbvra--


--===============1690917841433595883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1690917841433595883==--
