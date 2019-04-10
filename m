From: Mark Brown <broonie@kernel.org>
Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 13:35:58 +0100
Message-ID: <20190410123558.GQ6106@sirena.org.uk>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
 <20190410122457.GP6106@sirena.org.uk>
 <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RCJLo13VlymhPcEi"
Cc: YueHaibing <yuehaibing@huawei.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
To: Naga Sureshkumar Relli <nagasure@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--RCJLo13VlymhPcEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 12:30:37PM +0000, Naga Sureshkumar Relli wrote:

> > Yeah, I'm surprised that builds...

> Sorry, I tested with CONFIG_SPI_MEM enabled. It's my bad.

I also see that I'd queued an earlier version for application.  I've
lost track of whatever issues there were with that, sorry - could one of
you please post an incremental patch for them?  IIRC they were nice to
haves and the patch that was applied fixes the correctness issue.

--RCJLo13VlymhPcEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt4y4ACgkQJNaLcl1U
h9B9aQf/eBwwfJiTcPbJnYZtslASErwcNR2MEum2BXjYAreK2uE99PbrinsbpvKk
zSnf0/RmnF2tw6ljGI16pca4Lq0yUAvbMu7DF1zTsE6PuXJG4c2dTM8jry9mpLkb
B1INtDU/5NL6trRgNXFMxnzPyScNm+rogCwf2etcku4dRZqJ1BAWg9mM0yN5d5I4
8dzEv/8m0BFJYZlcQSQT5rM1RGpzSStahNpz+bGd4OwcUa8z0BbXiec+5xQKh99c
tT+LuWWkDJ2ALYtcprfExQwlzUuGTEVXXv2RhyfChYiiGTghHlXeQAtp7vAlIbsX
Dppc57o/hcsHATMIediotGJZasG/6g==
=An3P
-----END PGP SIGNATURE-----

--RCJLo13VlymhPcEi--
