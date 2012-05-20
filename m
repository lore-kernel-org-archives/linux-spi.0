From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 6/6] spi: s3c64xx: add device tree support
Date: Sat, 19 May 2012 23:10:26 -0600
Message-ID: <20120520051026.77D0C3E03B8@localhost>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org> <1337333613-6216-7-git-send-email-thomas.abraham@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	kgene.kim@samsung.com, jaswinder.singh@linaro.org,
	broonie@opensource.wolfsonmicro.com
To: Thomas Abraham <thomas.abraham@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1337333613-6216-7-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 18 May 2012 15:03:33 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Add support for device based discovery.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

... but one nitpick below...

> +#ifdef CONFIG_OF
> +static const struct of_device_id s3c64xx_spi_dt_match[] = {
> +	{ .compatible = "samsung,exynos4210-spi",
> +			.data = (void *)EXYNOS4_SPI_PORT_CONFIG,

This looks completely backwards.  EXYNOS4_SPI_PORT_CONFIG casts a
pointer to a kernel_ulong_t, and this casts it right back to a
pointer.  The cast should be removed entirely from the macro, and the
platform_device_id table should have the cast from pointer to ulong.

g.
