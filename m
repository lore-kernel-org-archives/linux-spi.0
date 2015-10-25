From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 6/7] spi: pxa2xx: Add support for multiple LPSS chip select signals
Date: Sun, 25 Oct 2015 13:02:14 +0100
Message-ID: <87bnbnkvg9.fsf@belgarion.home>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>
	<1445521485-2029-6-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-6-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
	(Jarkko Nikula's message of "Thu, 22 Oct 2015 16:44:44 +0300")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> LPSS SPI devices in a successor of Intel Sunrisepoint can have up to 4 chip
                   is ?
> selects per port. SPI capabilities register bits 12:9 tell which are
> enabled. For simplicity we assume chip selects are enabled one after
> another without disabled chip selects between. For instance CS0 | CS1 | CS2
> but not CS0 | CS1 | CS3.
>
> This patch adds support for detecting the number of enabled chip selects
> and adds output control to those LPSS SPI ports that have more than one
> chip select signal.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/spi/spi-pxa2xx.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 672963653d3b..6851649d1b15 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -13,6 +13,7 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> @@ -64,6 +65,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
>  #define GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
>  #define SPI_CS_CONTROL_SW_MODE			BIT(0)
>  #define SPI_CS_CONTROL_CS_HIGH			BIT(1)

> +#define SPI_CS_CONTROL_CS_SEL_SHIFT		8
> +#define SPI_CS_CONTROL_CS_SEL_MASK		(3 << SPI_CS_CONTROL_CS_SEL_SHIFT)
> +#define SPI_CAPS_CS_EN_SHIFT			9
> +#define SPI_CAPS_CS_EN_MASK			(0xf << SPI_CAPS_CS_EN_SHIFT)
This is intel specific, not pxa oriented, right ?
If so, I'd like to have it namespaced, with LPSS or whatever you see fit.

> @@ -103,6 +111,7 @@ static const struct lpss_config lpss_platforms[] = {
>  		.reg_general = -1,
>  		.reg_ssp = 0x20,
>  		.reg_cs_ctrl = 0x24,
> +		.reg_capabilities = 0xfc,
Immediate value ? I suppose a defines usage was not possible here ?

> @@ -271,15 +280,34 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
>  static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
>  {
>  	const struct lpss_config *config;
> -	u32 value;
> +	u32 value, cs;
>  
>  	config = lpss_get_config(drv_data);
>  
>  	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
> -	if (enable)
> +	if (enable) {
> +		cs = drv_data->cur_msg->spi->chip_select;
> +		cs <<= SPI_CS_CONTROL_CS_SEL_SHIFT;
> +		if (cs != (value & SPI_CS_CONTROL_CS_SEL_MASK)) {
> +			/*
> +			 * When switching another chip select output active
> +			 * the output must be selected first and wait 2 ssp_clk
> +			 * cycles before changing state to active. Otherwise
> +			 * a short glitch will occur on the previous chip
> +			 * select since output select is latched but state
> +			 * control is not.
> +			 */
> +			value &= ~SPI_CS_CONTROL_CS_SEL_MASK;
> +			value |= cs;
> +			__lpss_ssp_write_priv(drv_data,
> +					      config->reg_cs_ctrl, value);
> +			ndelay(1000000000 /
> +			       (drv_data->master->max_speed_hz / 2));
That ndelay() looks weird, why delay and not sleep ?
And wouldn't that be targeted at another patch ? If I got it right, this patch
deals with capabilites, not chip select timings, doesn't it ?

Cheers.

-- 
Robert
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
