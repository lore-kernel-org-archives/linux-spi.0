From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] spi: mediatek: support large PA
Date: Wed, 11 Sep 2019 11:03:07 +0100
Message-ID: <20190911100307.GR2036@sirena.org.uk>
References: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
 <1568195731-3239-4-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="By57YlnFViWR/M0S"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
To: Luhua Xu <luhua.xu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568195731-3239-4-git-send-email-luhua.xu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--By57YlnFViWR/M0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 05:55:31AM -0400, Luhua Xu wrote:

> +	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(addr_bits));
> +	if (ret)
> +		dev_notice(&pdev->dev, "SPI dma_set_mask(%d) failed, ret:%d\n",
> +			   addr_bits, ret);

Not sure why you picked dev_notice() over dev_err() here?
Otherwise this looks good so I'll go ahead and apply.

--By57YlnFViWR/M0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14xlsACgkQJNaLcl1U
h9BbAwf/WPyI6V+J0eXXtuhrkDPyjT7RRzxv1xzvLZx1r1SL66BLPAJce+D1yrmY
VNBKLZ8pS9tW6rmkDJEQVeeFJ+vQRJGca0DJxgiww9332H2aacH7gkw21eM/Zmi5
b1ziPC3WDTN4LAjDaGmPUq91NcXI3yzc1u+mUAsUEk/3oy/WzrqduSq1K8O2eBhV
vAAKEn+rE33sTz2BYQzMx8LbHaflmHYKxqT+HK111Cbq+ecGEOke7ItpZx/zVrFU
nJS3vxD35VwGQstEMIMgeXWsNGtD4y+sf2d2T/7DejwYWX9adSmPRdGSkyhCDLBG
hWBq3cFtRpYeF/ox+P+R1Zqr+y/J+w==
=+5QQ
-----END PGP SIGNATURE-----

--By57YlnFViWR/M0S--
