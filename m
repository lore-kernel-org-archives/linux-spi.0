From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: pic32-sqi: add SPI driver for PIC32 SQI
 controller.
Date: Thu, 14 Apr 2016 06:55:46 +0100
Message-ID: <20160414055546.GA18024@sirena.org.uk>
References: <1460553778-1662-1-git-send-email-purna.mandal@microchip.com>
 <1460553778-1662-2-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460553778-1662-2-git-send-email-purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 06:52:58PM +0530, Purna Chandra Mandal wrote:

> +	enable = readl(sqi->regs + PESQI_INT_ENABLE_REG);
> +	status = readl(sqi->regs + PESQI_INT_STAT_REG);
> +	if (!status)
> +		return IRQ_NONE;
> +

For robustness the check should be if there was anything handled, not if
there was anything set.

> +static dma_addr_t pic32_sqi_map_transfer(struct pic32_sqi *sqi,
> +					 struct spi_transfer *transfer)
> +{
> +	struct device *dev = &sqi->master->dev;

Don't open code DMA mapping of the buffers, use the core support.

> +	reg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sqi->regs = devm_ioremap_resource(&pdev->dev, reg);
> +	if (!sqi->regs) {
> +		dev_err(&pdev->dev, "mem map failed\n");

devm_ioremap_resource() will log for you.

> +	clk_prepare_enable(sqi->sys_clk);
> +	clk_prepare_enable(sqi->base_clk);

Check the return value please.

> +	/* install irq handlers */
> +	ret = devm_request_irq(&pdev->dev, sqi->irq, pic32_sqi_isr,
> +			       0, dev_name(&pdev->dev), sqi);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "request-irq %d, failed ?\n", sqi->irq);
> +		goto err_free_ring;
> +	}

This will free before the clocks are disabled.  Are you sure that's
safe?  It's generally not good to mix devm_ and non-devm operations
especially things like these that aren't simple frees of data.  It is
safer to use a normal request_irq().

> +static int pic32_sqi_remove(struct platform_device *pdev)
> +{
> +	struct pic32_sqi *sqi = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(sqi->base_clk);
> +	clk_disable_unprepare(sqi->sys_clk);
> +
> +	/* release memory */
> +	ring_desc_ring_free(sqi);

This will free the descriptor ring before the interrupt...

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDzDhAAoJECTWi3JdVIfQknAH/1MsEpmid7fjfKax67PJ8ctZ
/5wyjYId6aa0HLavPxAqZhjSe5CRFYtk7f9V1wr1335xFA9jUIKqRd08/rifnnGK
yFrNuV36M/IacSfHrUbVDqVyN+TF5ttzKAwGZyUEI+33fUpN8seO07q1gEnWi5Ie
sX96rpwe0krNfZy1r+duyYtGdGcmXL+A1X7XRDJpoxDpG0tzRTDnK2oXmH3KMHIk
oxdkbFOVFn5UMKD2bDApHS8L1YD7i3r31+GFmo7zLqxijirETVr2EpI8ym3tVdJo
qXeRKndsy1VKWGx/WnJpkyN5jE0hn2Idfh9+43h09TZ1ethCZ9+p4X63g0w4+qo=
=V5EI
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
