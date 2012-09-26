From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: get/put resources on suspend/resume
Date: Wed, 26 Sep 2012 17:23:00 +0200
Message-ID: <CAPDyKFpdNX1h2-h_nwi5kvDb+JrbrTCKYyNEQd_ACHE-GTW1eQ@mail.gmail.com>
References: <1348672133-5837-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348672133-5837-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I can agree with the code as such. One issue remains though.

You will have compile warnings when not having CONFIG_SUSPEND and
CONFIG_RUNTIME_PM, due to unused code/functions.

Otherwise you have my ack.

Kind regards
Ulf Hansson


On 26 September 2012 17:08, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
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
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
> Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> ---
> Vipin: can you confirm that this approach works for your
> case with only suspend/resume but no runtime PM?
>
> Question: can I be sure that the above semantics is taken
> care of by runtime PM, or will I have to add kludges to
> the ordinary suspend/resume hooks to make sure that the
> device is out of runtime suspend before suspending?
> ---
>  drivers/spi/spi-pl022.c | 64 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 15737bc..63cd7c6 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2300,6 +2300,43 @@ pl022_remove(struct amba_device *adev)
>         return 0;
>  }
>
> +/*
> + * These two functions are used from both suspend/resume and
> + * the runtime counterparts to handle external resources like
> + * clocks, pins and regulators when going to sleep.
> + */
> +static void pl022_suspend_resources(struct pl022 *pl022)
> +{
> +       int ret;
> +
> +       clk_disable(pl022->clk);
> +
> +       /* Optionally let pins go into sleep states */
> +       if (!IS_ERR(pl022->pins_sleep)) {
> +               ret = pinctrl_select_state(pl022->pinctrl,
> +                                          pl022->pins_sleep);
> +               if (ret)
> +                       dev_err(&pl022->adev->dev,
> +                               "could not set pins to sleep state\n");
> +       }
> +}
> +
> +static void pl022_resume_resources(struct pl022 *pl022)
> +{
> +       int ret;
> +
> +       /* Optionaly enable pins to be muxed in and configured */
> +       if (!IS_ERR(pl022->pins_default)) {
> +               ret = pinctrl_select_state(pl022->pinctrl,
> +                                          pl022->pins_default);
> +               if (ret)
> +                       dev_err(&pl022->adev->dev,
> +                               "could not set default pins\n");
> +       }
> +
> +       clk_enable(pl022->clk);
> +}
> +
>  #ifdef CONFIG_SUSPEND
>  static int pl022_suspend(struct device *dev)
>  {
> @@ -2311,6 +2348,7 @@ static int pl022_suspend(struct device *dev)
>                 dev_warn(dev, "cannot suspend master\n");
>                 return ret;
>         }
> +       pl022_suspend_resources(pl022);
>
>         dev_dbg(dev, "suspended\n");
>         return 0;
> @@ -2321,6 +2359,8 @@ static int pl022_resume(struct device *dev)
>         struct pl022 *pl022 = dev_get_drvdata(dev);
>         int ret;
>
> +       pl022_resume_resources(pl022);
> +
>         /* Start the queue running */
>         ret = spi_master_resume(pl022->master);
>         if (ret)
> @@ -2336,36 +2376,16 @@ static int pl022_resume(struct device *dev)
>  static int pl022_runtime_suspend(struct device *dev)
>  {
>         struct pl022 *pl022 = dev_get_drvdata(dev);
> -       int status = 0;
> -
> -       clk_disable(pl022->clk);
> -
> -       /* Optionally let pins go into sleep states */
> -       if (!IS_ERR(pl022->pins_sleep)) {
> -               status = pinctrl_select_state(pl022->pinctrl,
> -                               pl022->pins_sleep);
> -               if (status)
> -                       dev_err(dev, "could not set pins to sleep state\n");
> -       }
>
> +       pl022_suspend_resources(pl022);
>         return 0;
>  }
>
>  static int pl022_runtime_resume(struct device *dev)
>  {
>         struct pl022 *pl022 = dev_get_drvdata(dev);
> -       int status = 0;
> -
> -       /* Optionaly enable pins to be muxed in and configured */
> -       if (!IS_ERR(pl022->pins_default)) {
> -               status = pinctrl_select_state(pl022->pinctrl,
> -                               pl022->pins_default);
> -               if (status)
> -                       dev_err(dev, "could not set default pins\n");
> -       }
> -
> -       clk_enable(pl022->clk);
>
> +       pl022_resume_resources(pl022);
>         return 0;
>  }
>  #endif
> --
> 1.7.11.3
>

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
