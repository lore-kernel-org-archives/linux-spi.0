From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: Add MXIC controller driver
Date: Wed, 19 Sep 2018 10:46:12 -0700
Message-ID: <20180919174612.GG2471@sirena.org.uk>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
 <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/zLL6W406Aotuby1"
Cc: tpiepho@impinj.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/zLL6W406Aotuby1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 17, 2018 at 03:16:18PM +0800, masonccyang@mxic.com.tw wrote:

> +static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
> +{
> +	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
> +
> +	if (!lvl) {
> +		if (mxic_spi_clk_setup(spi))
> +			return;
> +		if (mxic_spi_clk_enable(mxic))
> +			return;
> +		writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_EN,
> +		       mxic->regs + HC_CFG);
> +		writel(HC_EN_BIT, mxic->regs + HC_EN);
> +		writel(readl(mxic->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
> +		       mxic->regs + HC_CFG);

Like Boris says having the clock management in the chip select
operations is not good - it's not just redundant with runtime PM, it's
potentially broken if a device does something like using an inverted
chip select.  The chip select operation should just be managing the chip
select, nothing else.  If it does other things it's going to end up
being broken for some cases.

Otherwise this looks good.

--/zLL6W406Aotuby1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluii2MACgkQJNaLcl1U
h9D50Qf9G9sFzVoF5k2uw3dJxs3w76wu7spHMRRe/DRf1QSI/vHfzhuBGfCL8Xo6
Z78sgnpiC2Nqa2Uu/oKQdQ9+70SQlb9K3F+o5KwV2eIk6tZpFiMGRN6Y/YFoFvGw
aLrj/8ruutokwFGxibqEJdTAp/ErE+6ND6cdRln0SAH+VUW/4dzNZbB5LS8NtMJR
c32ZJaUeN90+UBqYalxG4tm8zSodDv2HqQ4DzfdBIl0KWZqM2g4qjVPbWeFH7KFW
JPAr35PWWnmTUeYWXrrdm17pAn7xfQMJLjrDDjcuRb3AjqL7XMRtAoxeFiaDcfQR
f/YWGn4PwtE2acggALgCrE/u0z669w==
=5LGp
-----END PGP SIGNATURE-----

--/zLL6W406Aotuby1--
