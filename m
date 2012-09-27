From: vipul kumar samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH v2] spi/pl022: get/put resources on suspend/resume
Date: Thu, 27 Sep 2012 09:57:49 +0530
Message-ID: <5063D5C5.2050303@st.com>
References: <1348675582-11538-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Linus WALLEIJ <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348675582-11538-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 9/26/2012 9:36 PM, Linus WALLEIJ wrote:
> This factors out the resource handling in runtime
> suspend/resume and also calls it from the ordinary suspend
> and resume hooks.
>
> The semantics require that ordinary PM op suspend is called
> with runtime PM in resumed mode, so that ordinary suspend
> can assume that it will e.g. decrease the clock reference
> counter to 0, runtime resume having previously increased it
> to 1.
>
> Cc: Vipul Kumar Samar<vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
> Cc: Viresh Kumar<viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Ulf Hansson<ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Linus Walleij<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> ---
> ChangeLog v1->v2:
> - Add more #ifdef for the case where we have neither normal
>    PM nor runtime PM.
> ---
>   drivers/spi/spi-pl022.c | 66 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 44 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 15737bc..9194641 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2300,6 +2300,45 @@ pl022_remove(struct amba_device *adev)
>   	return 0;
>   }
>
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_PM_RUNTIME)
> +/*
> + * These two functions are used from both suspend/resume and
> + * the runtime counterparts to handle external resources like
> + * clocks, pins and regulators when going to sleep.
> + */
> +static void pl022_suspend_resources(struct pl022 *pl022)
> +{
> +	int ret;
> +
> +	clk_disable(pl022->clk);
> +
> +	/* Optionally let pins go into sleep states */
> +	if (!IS_ERR(pl022->pins_sleep)) {
> +		ret = pinctrl_select_state(pl022->pinctrl,
> +					   pl022->pins_sleep);
> +		if (ret)
> +			dev_err(&pl022->adev->dev,
> +				"could not set pins to sleep state\n");
> +	}
> +}
> +
> +static void pl022_resume_resources(struct pl022 *pl022)
> +{
> +	int ret;
> +
> +	/* Optionaly enable pins to be muxed in and configured */
> +	if (!IS_ERR(pl022->pins_default)) {
> +		ret = pinctrl_select_state(pl022->pinctrl,
> +					   pl022->pins_default);
> +		if (ret)
> +			dev_err(&pl022->adev->dev,
> +				"could not set default pins\n");
> +	}
> +
> +	clk_enable(pl022->clk);

What happen in case clk_enable returns an error??

Rest all is fine.

Regards
Vipul Samar

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
