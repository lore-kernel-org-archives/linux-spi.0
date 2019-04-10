From: Mark Brown <broonie@kernel.org>
Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 13:24:57 +0100
Message-ID: <20190410122457.GP6106@sirena.org.uk>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24/piotZLKF/SXqU"
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, michal.simek@xilinx.com,
        nagasuresh12@gmail.com
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--24/piotZLKF/SXqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 08:22:29PM +0800, YueHaibing wrote:
> On 2019/4/10 19:57, Naga Sureshkumar Relli wrote:

> > +static inline bool spi_mem_default_supports_op(struct spi_mem *mem,
> > +				 const struct spi_mem_op *op);

> Here miss a Function body, right?

Yeah, I'm surprised that builds...

--24/piotZLKF/SXqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt4JgACgkQJNaLcl1U
h9AGvAf/XvkuIdQl1Bjc7+gX1oHtpDMd0YFPPdANYn+UGWHXzXOP3QmvT3oacxsl
bBAr/e5cZ0mJi04HGMcPm+SOFXw1uNkvVtZ9c/HCs/pCVxX3p4S4eDiKbWoxoVA8
WBNee0/MIPhDqXGy/3X8JIgj11WSKMAFzpy/D1AplqgkTswcncFwED7bsFGw+knk
5V3ccPAmcGTX+0cR5Yutgofz2E4nvQsdNM9u7HwsNTZuB5XSVxhOKnK4ya4bw8/6
AyIKtBeV801HJ7TLGZpuYFC6OgO2v/s9nhahFGrwMEPu5xUNtDvqHajYhCbGoVDr
KJhz+3dpLvTbGk7UjN9lcbkbV6EBbQ==
=eX1p
-----END PGP SIGNATURE-----

--24/piotZLKF/SXqU--
