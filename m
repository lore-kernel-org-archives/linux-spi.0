From: vipul kumar samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/3] Revert "spi/pl022: enable runtime PM"
Date: Fri, 28 Sep 2012 17:20:41 +0530
Message-ID: <50658F11.5010405@st.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
	<1348831266-16721-3-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Ulf HANSSON <ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348831266-16721-3-git-send-email-ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello ulf,

On 9/28/2012 4:51 PM, Ulf HANSSON wrote:
> From: Ulf Hansson<ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This reverts commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99.
>
> Signed-off-by: Ulf Hansson<ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/spi/spi-pl022.c |    4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 3f2f36c..05cfb61e 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2188,9 +2188,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>   	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
>   	       adev->res.start, pl022->virtbase);
>
> -	pm_runtime_enable(dev);
> -	pm_runtime_resume(dev);
> -
>   	pl022->clk = clk_get(&adev->dev, NULL);
>   	if (IS_ERR(pl022->clk)) {
>   		status = PTR_ERR(pl022->clk);
> @@ -2303,7 +2300,6 @@ pl022_remove(struct amba_device *adev)
>   	clk_disable(pl022->clk);
>   	clk_unprepare(pl022->clk);
>   	clk_put(pl022->clk);
> -	pm_runtime_disable(&adev->dev);
>   	iounmap(pl022->virtbase);
>   	amba_release_regions(adev);
>   	tasklet_disable(&pl022->pump_transfers);

sorry..Now i got it you revert complete rumtime patch.

Regards
Vipul Samar

------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
