From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Sun, 18 Dec 2016 21:18:02 +0200
Message-ID: <2e32e0b2-6671-8ba3-39ae-23cd0388c654@mentor.com>
References: <1482039234-21335-1-git-send-email-joel@airwebreathe.org.uk>
 <1482039234-21335-3-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>,
        <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>,
        <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <marex-ynQEQJNshbs@public.gmane.org>, <linux-fpga-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1482039234-21335-3-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Joel,

On 12/18/2016 07:33 AM, Joel Holdsworth wrote:
> This patch adds support to the FPGA manager for configuring the SRAM of
> iCE40LM, iCE40LP, iCE40HX, iCE40 Ultra, iCE40 UltraLite and iCE40
> UltraPlus devices, through slave SPI.
> 
> Signed-off-by: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
> Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
> Acked-by: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> ---

[snip]

> +
> +static int ice40_fpga_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct device_node *np = spi->dev.of_node;

struct device_node *np = dev->of_node?

And actually I don't see why local variable 'np' is needed in the function,
see the next comment.

> +	struct ice40_fpga_priv *priv;
> +	int ret;
> +
> +	if (!np) {
> +		dev_err(dev, "No Device Tree entry\n");
> +		return -EINVAL;
> +	}

I would suggest to remove this check completely, I don't see a good
reason why it is needed.

> +
> +	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = spi;
> +
> +	/* Check board setup data. */
> +	if (spi->max_speed_hz > ICE40_SPI_MAX_SPEED) {
> +		dev_err(dev, "SPI speed is too high, maximum speed is "
> +			__stringify(ICE40_SPI_MAX_SPEED) "\n");
> +		return -EINVAL;
> +	}
> +
> +	if (spi->max_speed_hz < ICE40_SPI_MIN_SPEED) {
> +		dev_err(dev, "SPI speed is too low, minimum speed is "
> +			__stringify(ICE40_SPI_MIN_SPEED) "\n");
> +		return -EINVAL;
> +	}
> +
> +	if (spi->mode & SPI_CPHA) {
> +		dev_err(dev, "Bad SPI mode, CPHA not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set up the GPIOs */
> +	priv->cdone = devm_gpiod_get(dev, "cdone", GPIOD_IN);
> +	if (IS_ERR(priv->cdone)) {
> +		dev_err(dev, "Failed to get CDONE GPIO: %ld\n",
> +			PTR_ERR(priv->cdone));
> +		return -EINVAL;

You should do 'return PTR_ERR(priv->cdone)' here, this will allow
to handle at lease -EPROBE_DEFER correctly.

> +	}
> +
> +	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(priv->reset)) {
> +		dev_err(dev, "Failed to get CRESET_B GPIO: %ld\n",
> +			PTR_ERR(priv->reset));
> +		return -EINVAL;

Same as above.

> +	}
> +
> +	/* Register with the FPGA manager */
> +	ret = fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
> +				&ice40_fpga_ops, priv);
> +	if (ret) {
> +		dev_err(dev, "Unable to register FPGA manager");
> +		return ret;

I would suggest to do just 'return fpga_mgr_register(dev, ....);' here,
if the driver is not registered, the core will let the user know about it.

> +	}
> +
> +	return 0;
> +}
> +

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
