From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for Atmel QSPI controller
Date: Mon, 24 Aug 2015 13:03:51 +0200
Message-ID: <201508241303.52066.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com> <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bf368fc101f38db231131b69eff0863210f2b01c.1440410236.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
> This driver add support to the new Atmel QSPI controller embedded into
> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
> controller.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Hi,

[...]

> +/* Register access macros */

These are functions, not macros :)

btw is there any reason for these ? I'd say, just put the read*() and
write*() functions directly into the code and be done with it, it is
much less confusing.

Also, why do you use the _relaxed() versions of the functions ?

> +static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> +{
> +	return readl_relaxed(aq->regs + reg);
> +}
> +
> +static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> +{
> +	writel_relaxed(value, aq->regs + reg);
> +}
> +
> +static inline u16 qspi_readw(struct atmel_qspi *aq, u32 reg)
> +{
> +	return readw_relaxed(aq->regs + reg);
> +}
> +
> +static inline void qspi_writew(struct atmel_qspi *aq, u32 reg, u16 value)
> +{
> +	writew_relaxed(value, aq->regs + reg);
> +}
> +
> +static inline u8 qspi_readb(struct atmel_qspi *aq, u32 reg)
> +{
> +	return readb_relaxed(aq->regs + reg);
> +}
> +
> +static inline void qspi_writeb(struct atmel_qspi *aq, u32 reg, u8 value)
> +{
> +	writeb_relaxed(value, aq->regs + reg);
> +}

[...]

> +static int atmel_qspi_run_command(struct atmel_qspi *aq,
> +				  const struct atmel_qspi_command *cmd)
> +{
> +	u32 iar, icr, ifr, sr;
> +	int err = 0;
> +
> +	iar = 0;
> +	icr = 0;
> +	ifr = aq->ifr_width | cmd->ifr_tfrtyp;
> +
> +	/* Compute instruction parameters */
> +	if (cmd->enable.bits.instruction) {
> +		icr |= QSPI_ICR_INST(cmd->instruction);
> +		ifr |= QSPI_IFR_INSTEN;
> +	}
> +
> +	/* Compute address parameters */
> +	switch (cmd->enable.bits.address) {
> +	case 4:
> +		ifr |= QSPI_IFR_ADDRL;
> +		/*break;*/ /* fallback to the 24bit address case */

What's this commented out bit of code for ? :-)

> +	case 3:
> +		iar = (cmd->enable.bits.data) ? 0 : cmd->address;
> +		ifr |= QSPI_IFR_ADDREN;
> +		break;
> +	case 0:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

[...]

> +no_data:
> +	/* Poll INSTRuction End status */
> +	sr = qspi_readl(aq, QSPI_SR);
> +	if (sr & QSPI_SR_INSTRE)
> +		return err;
> +
> +	/* Wait for INSTRuction End interrupt */
> +	init_completion(&aq->completion);

You should use reinit_completion() in the code. init_completion()
should be used only in the probe() function and nowhere else.

> +	aq->pending = 0;
> +	qspi_writel(aq, QSPI_IER, QSPI_SR_INSTRE);
> +	if (!wait_for_completion_timeout(&aq->completion,
> +					 msecs_to_jiffies(1000)))
> +		err = -ETIMEDOUT;
> +	qspi_writel(aq, QSPI_IDR, QSPI_SR_INSTRE);
> +
> +	return err;
> +}

[...]

Hope this helps :)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
