From: vipul kumar samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 1/3] Revert "spi/pl022: fix spi-pl022 pm enable at probe"
Date: Fri, 28 Sep 2012 17:15:53 +0530
Message-ID: <50658DF1.2000409@st.com>
References: <1348831266-16721-1-git-send-email-ulf.hansson@stericsson.com>
	<1348831266-16721-2-git-send-email-ulf.hansson@stericsson.com>
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
In-Reply-To: <1348831266-16721-2-git-send-email-ulf.hansson-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Ulf,

On 9/28/2012 4:51 PM, Ulf HANSSON wrote:
> From: Ulf Hansson<ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This reverts commit 6887237cd7da904184dab2750504040c68f3a080.
>
> Signed-off-by: Ulf Hansson<ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/spi/spi-pl022.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index f8568b4..3f2f36c 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2188,6 +2188,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
>   	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
>   	       adev->res.start, pl022->virtbase);
>
> +	pm_runtime_enable(dev);

Before calling spi-pl022 probe, amba_probe enables runtime pm. Is it 
requires to re-enable it in spi-pl022 probe??

Regards
Vipul Samar

------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
