From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Activate resourses before deactivate them in
	suspend
Date: Fri, 12 Oct 2012 16:42:53 +0200
Message-ID: <CAPDyKFpa8XoEy-kq3nq0dbRtM=a1wJ7cx=OzCOqMY1PmXrXJYw@mail.gmail.com>
References: <1349423012-18048-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1349423012-18048-1-git-send-email-ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

Just a kind remember on this. Do you see any problem merging this?

Kind regards
Ulf Hansson

On 5 October 2012 09:43, Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> To be able to deactivate resourses in suspend, the resourses must
> first be surely active. This is done with a pm_runtime_get_sync.
> Once the resourses are restored to active state again in resume,
> the runtime pm usage count can be decreased with a pm_runtime_put.
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-pl022.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 9194641..c3590e0 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2350,6 +2350,8 @@ static int pl022_suspend(struct device *dev)
>                 dev_warn(dev, "cannot suspend master\n");
>                 return ret;
>         }
> +
> +       pm_runtime_get_sync(dev);
>         pl022_suspend_resources(pl022);
>
>         dev_dbg(dev, "suspended\n");
> @@ -2362,6 +2364,7 @@ static int pl022_resume(struct device *dev)
>         int ret;
>
>         pl022_resume_resources(pl022);
> +       pm_runtime_put(dev);
>
>         /* Start the queue running */
>         ret = spi_master_resume(pl022->master);
> --
> 1.7.10
>

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
