From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] spi: imx: support to set watermark level via DTS
Date: Thu, 5 Jan 2017 17:58:54 +0000
Message-ID: <20170105175854.gj5xr5drk5tddzyz@sirena.org.uk>
References: <20170105061015.7816-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dclseucz4ab2fjfw"
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105061015.7816-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--dclseucz4ab2fjfw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 05, 2017 at 03:10:15PM +0900, Jiada Wang wrote:

> Previously watermark level is configured to fifosize/2,
> DMA mode can be used only when transfer length can be divided
> by 'watermark level * bpw', which makes DMA mode not practical.

> This patch adds new DTS property 'dma-wml', user can configure
> DMA watermark level, by specify 'dma-wml' in corresponding ecspi
> node.

Doesn't this just move the problem around a bit - can we not have the
driver figure out a more sensible watermark for each transfer rather
than fixing one in the DT?

--dclseucz4ab2fjfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhuiV0ACgkQJNaLcl1U
h9BgsQf9G86DrtVKwDrU3yvqDio7tK4keAsM9CFqG7SkHJwZW11g1DUwOms45LhA
D7EwEAWDVXQToZk3Wub0hQtS/rNKnI8IF3qwGp9Bihz60uoGUa4E0bq81RTLRIjj
oI0Kd8S0Gy4cNSIOi8ah9WMcP7y4qHeclCgdWiwvZ8G0V6UIk5pFWgcIWSBdn9UV
UnAo2CQH0qirTX1J4Hmn8maXsPCVi+1RMly34W5fiEApn7u99vPKLJXamnudEj8n
Rt0qJ7XzHMpGouWmoiZWDm5i+y7ITnSbwrA0PpFtx5JnvgJ8q63pVNSJ5SXLmz+W
HyDxkFg7F4UgHJysu1EkKih7hwRFFg==
=1fpZ
-----END PGP SIGNATURE-----

--dclseucz4ab2fjfw--
