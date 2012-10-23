From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
Date: Tue, 23 Oct 2012 12:31:06 +0200
Message-ID: <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
	<1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1349452272-4002-2-git-send-email-ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

It seems like this patch did not get applied together with:
[PATCH 1/2] Revert "spi/pl022: fix spi-pl022 pm enable at probe"

The problem was likely my fault, since there were a lot of resends.
Anyway, it should still be possible to apply.

Kind regards
Ulf Hansson


On 5 October 2012 17:51, Ulf Hansson <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This reverts commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99.
>
> This patch introduced runtime PM issues and is not needed at all.
> Thus we should revert it.
>
> Conflicts:
>
>         drivers/spi/spi-pl022.c
>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-pl022.c |    4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 5cf0643..a1db91a 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2186,9 +2186,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>         printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
>                adev->res.start, pl022->virtbase);
>
> -       pm_runtime_enable(dev);
> -       pm_runtime_resume(dev);
> -
>         pl022->clk = devm_clk_get(&adev->dev, NULL);
>         if (IS_ERR(pl022->clk)) {
>                 status = PTR_ERR(pl022->clk);
> @@ -2293,7 +2290,6 @@ pl022_remove(struct amba_device *adev)
>
>         clk_disable(pl022->clk);
>         clk_unprepare(pl022->clk);
> -       pm_runtime_disable(&adev->dev);
>         amba_release_regions(adev);
>         tasklet_disable(&pl022->pump_transfers);
>         spi_unregister_master(pl022->master);
> --
> 1.7.10
>

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
