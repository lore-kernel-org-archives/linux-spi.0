From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: pxa: Remove unused clock_enable field from struct
 pxa2xx_spi_master
Date: Sat, 19 Sep 2015 07:47:31 -0700
Message-ID: <20150919144731.GO12027@sirena.org.uk>
References: <1442560481-26008-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ILYFnOLy4m9XaNPx"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Philipp Zabel <philipp.zabel@gmail.com>,
	Paul Parsons <lost.distance@yahoo.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Marek Vasut <marek.vasut@gmail.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442560481-26008-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ILYFnOLy4m9XaNPx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2015 at 10:14:41AM +0300, Jarkko Nikula wrote:
> Use for struct pxa2xx_spi_master clock_enable field was removed years ago
> from the pxa2xx-spi driver by the commit 2f1a74e5a2de ("[ARM] pxa: make
> pxa2xx_spi driver use ssp_request()/ssp_free()").

Acked-by: Mark Brown <broonie@kernel.org>

--ILYFnOLy4m9XaNPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/XWDAAoJECTWi3JdVIfQCOcH/A1wkTYys/rOPuXB89QT7oyS
rccwwSPLIherHrVUdzmo+xiYPEzHaHzwUzuv1RB63qYFstRAlDGuh+UnTD2nxW5y
lnLH8zHLHA2XM6SNrXsVz7ECoBI7v7EXF6TER5Xf8BRCNR+n5vi9GbJOwMAi2fRm
7bHnD74uQP+OWpSjuT92dpq01tvd+8YCMzkM1pJhgT4NLXL2z5e84FO7260gwKcL
7CVC/jDHIOGt+XWSvsuM3/Qq8hWsTv4qIt/k/Wp5Fasj7AetbH9H8C0dMkKzazWt
3hwOR/ySyA1c6WFgEaEDOx9USNSNPxcmhXfKeKL67uFIDGVPSRPdB6PoYjGD8jg=
=ikcI
-----END PGP SIGNATURE-----

--ILYFnOLy4m9XaNPx--
