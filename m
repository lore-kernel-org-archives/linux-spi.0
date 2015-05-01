From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] spi: imx: Constify platform_device_id
Date: Fri, 1 May 2015 17:37:35 +0100
Message-ID: <20150501163735.GH22845@sirena.org.uk>
References: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lzmAV/UDz8M1R67T"
Cc: Kukjin Kim <kgene@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--lzmAV/UDz8M1R67T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2015 at 12:44:04AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.

--lzmAV/UDz8M1R67T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6vPAAoJECTWi3JdVIfQIj8H/ja69wEkubAD/4XVc9slGrx7
lMP2hlRP3/aEWcBv5tcK85gLQbtOYDi4C5nM09Nt/Gfb62VMW8k2oVopla4XCZYF
0AwWc5DOaVX+OwRz7/xkvalF1ZAMUrtxb0HjZFtq28dwKMm1TFPtcIvbGcbw7q6J
4LxoyK4HUjvt8rlUuuffes9sEFIfIabZtLb8COoIiS2wUQDaf3L/+uzYDbawo3ja
VlHJXhUMas4hqKwtqLQR2bvbE+0AxfDUX80EoPFVxGHbgtjGfbwleI+wS2sBlQuJ
zbDoc84P4SVsyDs9jzbFaIHNOamsNJaCr9DfSs+J0jlBEe/Hix5yZ4YchMO54Zk=
=nrP8
-----END PGP SIGNATURE-----

--lzmAV/UDz8M1R67T--
