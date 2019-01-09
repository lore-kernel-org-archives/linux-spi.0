From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] spi: lpspi: add the error info of transfer speed
 setting
Date: Wed, 9 Jan 2019 12:43:57 +0000
Message-ID: <20190109124357.GC10405@sirena.org.uk>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
 <20190107074639.6336-7-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107074639.6336-7-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 07, 2019 at 07:47:45AM +0000, Clark Wang wrote:
> Add a error info when set a speed which greater than half of per-clk of
> spi module.

This (and it turns out the subsequent patch which I said I'd apply)
doesn't apply against current code, please check and resend.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw17IwACgkQJNaLcl1U
h9Dpkgf8C0s+n1XGV5l9HeB+IWNq5DrE0cPLhOfoiIouE2WQ+RMBcjl2xbCk66ar
ZPaxLULyiPo+E8aYpRLfuGOskB/biToeFzLdpJ0i8heneVSwfQify+ce2JmXsniM
uElXHf71XYRMPJK0MYAEsnssZdlxiFSisVc/Ear6PSkTYHcO2JP3xh51gMeADaSw
jxcyvfBiFj55g3HlpakvpNt//Fpj5bAGrQeW4MktGbVLopx+PFLFduBDYblqcbqC
fLba3Ib/WqQVctnEJ+zf+U3FEV9ae3mfWBhl9OqZOCRm6HrS2m1CbbXv5gZaVuDo
A2L60N1v3NaGwbaz13N9vdiZJFcJ5g==
=owl/
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
