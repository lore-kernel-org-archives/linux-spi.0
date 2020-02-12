From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re:
Date: Wed, 12 Feb 2020 11:30:51 +0200
Message-ID: <b3397374-0cb8-cf6c-0555-34541a1c108c@linux.intel.com>
References: <20200211223400.107604-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, rajatxjain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        evgreen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        porselvan.muthukrishnan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Rajat Jain <rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200211223400.107604-1-rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

+ Andy

On 2/12/20 12:34 AM, Rajat Jain wrote:
> From: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> 
> Date: Wed, 29 Jan 2020 13:54:16 -0800
> Subject: [PATCH] spi: pxa2xx: Add CS control clock quirk
> 
This patch subject is missing from mail subject.

> In some circumstances on Intel LPSS controllers, toggling the LPSS
> CS control register doesn't actually cause the CS line to toggle.
> This seems to be failure of dynamic clock gating that occurs after
> going through a suspend/resume transition, where the controller
> is sent through a reset transition. This ruins SPI transactions
> that either rely on delay_usecs, or toggle the CS line without
> sending data.
> 
> Whenever CS is toggled, momentarily set the clock gating register
> to "Force On" to poke the controller into acting on CS.
> 
Could you share the test case how to trigger this? What's the platform 
here? I'd like to check does this reproduce on other Intel LPSS 
platforms so is there need to add quirk for them too.

> Signed-off-by: Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Rajat Jain <rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/spi/spi-pxa2xx.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 4c7a71f0fb3e..2e318158fca9 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -70,6 +70,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
>   #define LPSS_CAPS_CS_EN_SHIFT			9
>   #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
>   
> +#define LPSS_PRIV_CLOCK_GATE 0x38
> +#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK 0x3
> +#define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON 0x3
> +
>   struct lpss_config {
>   	/* LPSS offset from drv_data->ioaddr */
>   	unsigned offset;
> @@ -86,6 +90,8 @@ struct lpss_config {
>   	unsigned cs_sel_shift;
>   	unsigned cs_sel_mask;
>   	unsigned cs_num;
> +	/* Quirks */
> +	unsigned cs_clk_stays_gated : 1;
>   };
>   
>   /* Keep these sorted with enum pxa_ssp_type */
> @@ -156,6 +162,7 @@ static const struct lpss_config lpss_platforms[] = {
>   		.tx_threshold_hi = 56,
>   		.cs_sel_shift = 8,
>   		.cs_sel_mask = 3 << 8,
> +		.cs_clk_stays_gated = true,
>   	},
>   };
>   
> @@ -383,6 +390,22 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
>   	else
>   		value |= LPSS_CS_CONTROL_CS_HIGH;
>   	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
> +	if (config->cs_clk_stays_gated) {
> +		u32 clkgate;
> +
> +		/*
> +		 * Changing CS alone when dynamic clock gating is on won't
> +		 * actually flip CS at that time. This ruins SPI transfers
> +		 * that specify delays, or have no data. Toggle the clock mode
> +		 * to force on briefly to poke the CS pin to move.
> +		 */
> +		clkgate = __lpss_ssp_read_priv(drv_data, LPSS_PRIV_CLOCK_GATE);
> +		value = (clkgate & ~LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK) |
> +			LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON;
> +
> +		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, value);
> +		__lpss_ssp_write_priv(drv_data, LPSS_PRIV_CLOCK_GATE, clkgate);
> +	}
>   }
>   
I wonder is it enough to have this quick toggling only or is time or 
actually number of clock cycles dependent? Now there is no delay between 
but I'm thinking if it needs certain number cycles does this still work 
when using low ssp_clk rates similar than in commit d0283eb2dbc1 ("spi: 
pxa2xx: Add output control for multiple Intel LPSS chip selects").

I'm thinking can this be done only once after resume and may other LPSS 
blocks need the same? I.e. should this be done in drivers/mfd/intel-lpss.c?

Jarkko
