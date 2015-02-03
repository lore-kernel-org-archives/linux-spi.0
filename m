From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] spi: imx: use pio mode for i.mx6dl
Date: Tue, 3 Feb 2015 12:18:10 +0000
Message-ID: <20150203121810.GJ21293@sirena.org.uk>
References: <1422930353-4339-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ce8zlQhVsmlNj00H"
Cc: l.stach@pengutronix.de, shawn.guo@linaro.org,
	Frank.Li@freescale.com, Fabio.Estevam@freescale.com, hs@denx.de,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Robin Gong <b38343@freescale.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422930353-4339-1-git-send-email-b38343@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ce8zlQhVsmlNj00H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 10:25:53AM +0800, Robin Gong wrote:
> For TKT238285 hardware issue which may cause txfifo store data twice can only
> be caught on i.mx6dl, we use pio mode instead of DMA mode on i.mx6dl.

Applied, thanks.

--ce8zlQhVsmlNj00H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0LyCAAoJECTWi3JdVIfQOeIIAIVDhfe0eBkE+EGSjuOuXMP+
QR83ewVcxHqqVKxdyNPHLm5lUk28zy5p6brWt6MB5DTZNvLwz98cL4feTQCdQwhD
/t0I145s1NhAJslGV+140HvuvyeoZU9CtbeDtKIADLeJYruXUVaEDT5Q92eznM4H
VYP59f53TZr4dUlJoNznfQf4bokYDyFnCIBgsjS8NtO/iPtKamt6PSNQ89MuxLcB
tR5YfK4j4h4VE81Zlj1/yxppH4NllueSn4hVuSvYWZbOmYSV8iY5pEOlRlDykXx9
4JDuGzze5y9vCd7QfrEpVGz6dEVRXGphi3SFcZxb4nx5XqwrLK86eH5XeiMlLGQ=
=4QG1
-----END PGP SIGNATURE-----

--ce8zlQhVsmlNj00H--
