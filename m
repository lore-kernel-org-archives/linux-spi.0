From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] spi: rspi: Constify platform_device_id
Date: Fri, 1 May 2015 17:37:58 +0100
Message-ID: <20150501163758.GI22845@sirena.org.uk>
References: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495047-31122-2-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S13E5aQrMqPdk4Os"
Cc: Kukjin Kim <kgene@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430495047-31122-2-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--S13E5aQrMqPdk4Os
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 12:44:05AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--S13E5aQrMqPdk4Os
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6vlAAoJECTWi3JdVIfQZ3IH/R8jKs68h/eWiIR885hfY40u
oNlk8RsEEXwPcJSYzZGapK8MX/DzEAfPmlGK92Ea+D0TWtDpR92qboRlnsKOJ4we
9xTkal3nbKU2tOinTnvHsiIOfyPLQHZLXTWAZtHrenEVjky+BJb1NaIHVpTXvEm0
imuv67OEjF0BEfEGiUi7n+S2Up9SHUMvCWrdmfE4pxm4RMWiHIOYcwz6KXypNgzk
9JDHbU3frgDNFbVXJdw8qf7yDY/FWhax8rX6yvXmcbI6Dt0239eHa+G++GUPSef3
CCrzkch85P/KgS/+ikM2k25vULepumHgTPK125QdEF7sWsoxtk8v7iUH/WdyA0g=
=Oq3N
-----END PGP SIGNATURE-----

--S13E5aQrMqPdk4Os--
