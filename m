From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 7 Nov 2016 19:01:12 +0100
Message-ID: <2255968d-b97c-2b9c-4e4d-7f3717a748e3@denx.de>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>,
        atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org,
        geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478486962-26794-3-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/07/2016 03:49 AM, Joel Holdsworth wrote:
> The Lattice iCE40 is a family of FPGAs with a minimalistic architecture
> and very regular structure, designed for low-cost, high-volume consumer
> and system applications.

[...]

> +static int ice40_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> +				     const char *buf, size_t count)
> +{
> +	struct ice40_fpga_priv *priv = mgr->priv;
> +	struct spi_device *dev = priv->dev;
> +	struct spi_message message;
> +	struct spi_transfer assert_cs_then_reset_delay = {.cs_change = 1,
> +		.delay_usecs = ICE40_SPI_FPGAMGR_RESET_DELAY};

Should be this way for the sake of readability, fix globally:

	struct spi_transfer assert_cs_then_reset_delay = {
		.cs_change	= 1,
		.delay_usecs	= ICE40_SPI_FPGAMGR_RESET_DELAY
	};

Also I believe this could be const.

> +	struct spi_transfer housekeeping_delay_then_release_cs = {
> +		.delay_usecs = ICE40_SPI_FPGAMGR_HOUSEKEEPING_DELAY};

Don't we have some less hacky way of toggling the nCS ? Is this even nCS
or is this some control pin of the FPGA ? Maybe it should be treated
like a regular GPIO instead ?

[...]

> +static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr, u32 flags)
> +{
> +	struct ice40_fpga_priv *priv = mgr->priv;
> +	struct spi_device *dev = priv->dev;
> +	const u8 padding[ICE40_SPI_FPGAMGR_NUM_ACTIVATION_BYTES] = {0,};

The comma is not needed.

> +
> +	/* Check CDONE is asserted */
> +	if (!gpiod_get_value(priv->cdone)) {
> +		dev_err(&dev->dev,
> +			"CDONE was not asserted after firmware transfer\n");
> +		return -EIO;
> +	}
> +
> +	/* Send of zero-padding to activate the firmware */
> +	return spi_write(dev, padding, sizeof(padding));
> +}

[...]

> +	/* Check board setup data. */
> +	if (spi->max_speed_hz > 25000000) {
> +		dev_err(dev, "Speed is too high\n");
> +		return -EINVAL;
> +	}
> +
> +	if (spi->max_speed_hz < 1000000) {
> +		dev_err(dev, "Speed is too low\n");
> +		return -EINVAL;
> +	}

Do you have some explanation for this limitation ?

[...]

-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
