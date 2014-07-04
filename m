From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
Date: Fri, 4 Jul 2014 19:32:49 +0100
Message-ID: <20140704183249.GC14896@sirena.org.uk>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404176639-3315-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 09:03:59AM +0800, addy ke wrote:
> In order to facilitate understanding, rockchip SPI controller IP design
> looks similar in its registers to designware. But IC implementation
> is different from designware, So we need a dedicated driver for Rockchip
> RK3XXX SoCs integrated SPI. The main differences:

This looks good overall, a nice clean driver.  I've applied it but there
are a few small issues that need fixing up which I've noted below, can
you please send followup patches dealing with these?

> +	 * static void spi_set_cs(struct spi_device *spi, bool enable)
> +	 * {
> +	 *		if (spi->mode & SPI_CS_HIGH)
> +	 *			enable = !enable;
> +	 *
> +	 *		if (spi->cs_gpio >= 0)
> +	 *			gpio_set_value(spi->cs_gpio, !enable);
> +	 *		else if (spi->master->set_cs)
> +	 *		spi->master->set_cs(spi, !enable);
> +	 * }
> +	 *
> +	 * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
> +	 */

So, the point here is that chip select is an active low signal by
default which means that if chip select is asserted we have a low logic
level and the parameter means "asserted" not "logic level for the
output".  It doesn't really matter but it might be clearer to say so
directly.

> +	if (spi->mode & SPI_CS_HIGH) {
> +		dev_err(rs->dev, "spi_cs_hign: not support\n");
> +		return -EINVAL;

Typo here (high).

> +static int rockchip_spi_unprepare_message(struct spi_master *master,
> +		struct spi_message *msg)
> +{
> +	unsigned long flags;
> +	struct rockchip_spi *rs = spi_master_get_devdata(master);
> +
> +	spin_lock_irqsave(&rs->lock, flags);
> +
> +	if (rs->use_dma) {
> +		if (rs->state & RXBUSY) {
> +			dmaengine_terminate_all(rs->dma_rx.ch);
> +			flush_fifo(rs);
> +		}
> +
> +		if (rs->state & TXBUSY)
> +			dmaengine_terminate_all(rs->dma_tx.ch);
> +	}

This initially looks wrong - the DMA should all be quiesced by the time
that we get to unpreparing the hardware, otherwise the transfer might be
ongoing while the chip select is deasserted.  However this is really
just error handling in case something went wrong which is sensible and
reasonable, a comment explaining this would help so can you please send
a followup patch adding one.

The error handling here is actually a good point - we should probably
add a callback for the core to use when it times out since the issue
also applies if there are further transactions queued with the hardware.
I'll look into that later unless someone does it first.

> +	/* Delay until the FIFO data completely */
> +	if (xfer->tx_buf)
> +		xfer->delay_usecs
> +			= rs->fifo_len * rs->bpw * 1000000 / rs->speed;

The driver shouldn't be doing this, if it needs a delay it needs to
implement it itself.  delay_usecs can be set by devices if they need a
delay between transfers, it should be in addition to the time taken for
the transfer to complete.

Please send a followup patch fixing this.

> +static bool rockchip_spi_can_dma(struct spi_master *master,
> +		struct spi_device *spi,
> +		struct spi_transfer *xfer)
> +{
> +	struct rockchip_spi *rs = spi_master_get_devdata(master);
> +
> +	return (xfer->len > rs->fifo_len);
> +}

We should factor this out into the core as well, just let the driver set
the minimum size for DMA since it's such a common pattern.  I'll look
into this as well.

> +	master = spi_alloc_master(&pdev->dev, sizeof(struct rockchip_spi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "No memory for spi_master\n");
> +		return -ENOMEM;
> +	}

No need to print an error message - OOM messags from the memory
management subsystem are already noisy enough as it is.

> +	dev_info(&pdev->dev, "Rockchip SPI controller initialized\n");

Please send a followup patch removing this, it's not really adding
anything and there's core debug messages that can be enabled - usually
these prints are done when there is some information that has been read
back from the hardware (eg, IP revisions).

> +static const struct of_device_id rockchip_spi_dt_match[] = {
> +	{ .compatible = "rockchip,rk3066-spi", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);

Your DT binding defined some additional compatible strings, please add
those to the driver.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtvNOAAoJELSic+t+oim9AZ0QAJTDMzcAA9zy8yPpNZCO/3qs
/60RdNNIAbrqWO2X4nl3ihEoCHflUtf0LgEhKhubvXSS21bVG0056Q6Bba69YaL6
4Z7DgBdHJ3Hx2h1HRZLtpXztJcd5hZa3+7mePGWE0ucXeyFbnTTpr7fEvyl3In71
5MapcJhM+rcFrOAbBCbMrBP89WVHCH1tK04NExPRivM8M3lAuJpDzIm93tbo8DMP
dYnvMYH3X0q4+qGY9kMXAD5pK5l6yCk/DGg9xcwBm4hzTkunQq7TniUo3xmsl+qt
0Fo8wSWk+wTnIJ0YRCwEwEzxiffY6PjroCAji4NY6CuVyuuLS1rCTiWcNWT0CgRc
8T7Kmv+u/p9OC78mKRdauhlCMgjMxY69X6Nb6swd8+hO0wAsPtC4OU+7GFnEVrEu
q35hpYz+tk/thx0JGV9QAfD37O/0IEeRq91ZVXBJJUaLhpj+3r5Y5r4vMtbAvHVX
ShVBCUXIQVOXrrkqFHKzgl9ZNmONOxHaee46/HrMIbUAn4Q0G5li9CSce0HerwFG
vqpoB40CYcETpsk3wc32aPym+1DsjjmaWNYkkpAyd6wzITaX7x+reZmKOSCVdYDa
itL+dUu2AYunV9qtmKc88N6eQ3QQYKo7QPiF2diB35gvmgxWhGAFytRzFtCwytgI
aS3y/2XspxVDHGu3epL0
=ZtBZ
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
