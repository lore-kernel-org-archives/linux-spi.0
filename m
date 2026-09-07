Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2D4E80CD;
	Mon,  7 Sep 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788831; cv=none; b=T0yCxN4Q2H+EW2xzexjN0vOx2AOn0zY4FLmokVeuGRtnFOjDjs92YAiZOy8TuGo0ycxex9J1t0DcG8nEjp40HhiKATSwL8kjYn43XOAgg2uGcWDQY/aFWQRyfHhAzV2V3fKhw/PlDlsOs9BSveqZ0fv+eqZOGZkKM6h+wF+Ee/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788831; c=relaxed/simple;
	bh=kbbIYku2jDxALVuBt8IOwMMSyMY7ylnMQtiOc9f5haE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqJrcRigw6/WgaFcEFloZhyq2kdqAFQ2KHTyd8srxG+tCf+jST7aWVOHvjsTssUZO6YA1DKIaHaYaKZscsb9EKVxUjM5OV5XlXL/GZfJq6koWI31PwEgajOw9UbOTVUPONqxVdO295l83rvRGbPpKEzk2z9FNI8PHSct2S4AyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOneXm87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOneXm87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B601F00A3A;
	Mon,  7 Sep 2026 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788788826;
	bh=HUVDPKeZ74v3BFh7Tch9+2MMZc+U1E5RK2oiY040Eqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HOneXm8779L8HUKFMz3jGOwAR+G8YWowOIGjJgb3gM2Gorz0NaGHwcpGXqt5Uia6r
	 tjUTuFoXElGPrgvY9oZZ05+81BlT+aYhvSBYlx5IqlKimEVU+VHAlm32u6sxDSllxu
	 U6Jmf/i+7yaerkv6URPqLpb2TIqVo08uNzPniTNk96njFZrmTWcb+Y+GCDy/i+GynZ
	 eB+a6hdSfgVQ/0qPHEe5o0XUso51oC1lsboPoOAbe556pfyIam5RXUo2CFCgiKU25m
	 c1YkGZpIl77b7ISWG/ULpNu+uIwQ5Dn52r/NYRCfDSAGfn0MbYYEZGv1x1I/KNoNxM
	 V9uBMhvpJQR6Q==
Date: Mon, 7 Sep 2026 14:47:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jyanchou@realtek.com, p.zabel@pengutronix.de, afaerber@suse.com,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, james.tai@realtek.com,
	cy.huang@realtek.com, stanley_chang@realtek.com
Subject: Re: [PATCH v2 2/2] spi: spi-mem: Add Realtek SPI flash controller
 driver
Message-ID: <0752aad9-7ed1-407e-951d-18a61d945119@sirena.org.uk>
References: <20260906145755.1230079-1-eleanor.lin@realtek.com>
 <20260906145755.1230079-3-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XtWmWUqLPiPGDe5b"
Content-Disposition: inline
In-Reply-To: <20260906145755.1230079-3-eleanor.lin@realtek.com>
X-Cookie: Who's on first?


--XtWmWUqLPiPGDe5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 06, 2026 at 10:57:55PM +0800, Yu-Chun Lin wrote:

> Add a spi-mem driver for the SPI Flash Controller (SFC) found on Realtek
> DHC SoC. SFC supports Dual I/O.

>  drivers/spi/Makefile      |   1 +
>  drivers/spi/spi-rtk-nor.c | 637 ++++++++++++++++++++++++++++++++++++++

Are we sule Realtek won't have more flash controllers?

> @@ -0,0 +1,637 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Realtek SPI Nor Flash Controller Driver (SFC)
> + *
> + * Copyright (c) 2024-2026 Realtek Technologies Co., Ltd.
> + */

Please make the entire comment block a C++ one so things look more
intentional.

> +static int rtk_spi_do_write_and_cmds(struct rtk_spi_host *host, const struct spi_mem_op *op)
> +{

> +	} else {
> +		readb(host->iobase);
> +
> +		/*
> +		 * For pure commands that require internal state synchronization
> +		 * (such as Chip Erase), poll the flash status.
> +		 */
> +		ret = rtk_spi_read_status(host);
> +	}

Shouldn't this be done by the spi-nor core if it's needed?  There's also
some timeout logic there which this will override.

> +static int rtk_spi_dma_transfer(struct rtk_spi_host *host, loff_t offset,
> +				size_t len, bool is_read)
> +{

> +	writel(DMA_W_EN | DMA_START, host->mdbase + MD_FDMA_CTRL1);
> +	udelay(1);

> +	ret = readl_poll_timeout(host->mdbase + MD_FDMA_CTRL1, val,
> +				 !(val & DMA_START), 100, timeout_us);
> +	if (ret) {
> +		dev_err(host->dev, "DMA transfer timed out\n");
> +		return ret;
> +	}

Don't we need to turn off the hardware here?

> +static int rtk_spi_runtime_resume(struct device *dev)
> +{
> +	struct spi_controller *ctlr = dev_get_drvdata(dev);
> +	struct rtk_spi_host *host = spi_controller_get_devdata(ctlr);
> +	int ret;
> +
> +	ret = clk_prepare_enable(host->clk);
> +	if (ret < 0) {
> +		dev_err(dev, "clk_prepare_enable failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	reset_control_assert(host->rstc);
> +	usleep_range(10, 20);
> +	reset_control_deassert(host->rstc);
> +
> +	rtk_spi_init(host);
> +
> +	return 0;
> +}

rtk_spi_init() doesn't handle 4 byte mode does it?

--XtWmWUqLPiPGDe5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqewFQACgkQJNaLcl1U
h9BIvgf9GrIUJa8zL++BdHo3crKhybLo0SdrvyVM138OfNSr4bdlA4EWSQBCs7cy
52MJYlgf0bi6UFTURjWlPvzzfhcqbq0id/i1n/cVGtuIvW9cbAWiyIEEFOMSgp/z
o+36KVqBHume+PXDNL2YmgrPx69SoTHScMDbIM1maQHKrCXFpisxCpC3i8g6LMqI
DEkW/NQnYJ409mEAz+shwmvvNCVk5mV9QdV+yGGxsj82CeFqAHCGWTSUGe3JdcB/
3kFNRyxzNO/pLX6Ni+POiBDBgHC08BGVvRMIB9T+CWdJWi1fHk9lsaz2S2Klk9FU
ZCrlwCGeuc2d/RF5NORIB+Fzjcyywg==
=xTSe
-----END PGP SIGNATURE-----

--XtWmWUqLPiPGDe5b--
