From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: remove completely broken Tegra driver
Date: Mon, 1 Oct 2012 15:11:41 +0530
Message-ID: <50696555.1050509@nvidia.com>
References: <1348848948-21795-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348848948-21795-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 28 September 2012 09:45 PM, Stephen Warren wrote:
>
> 2) The downstream driver is significaly different from the current
>     code. I believe a patch to re-add the downstream driver (with
>     appropriate cleanup) will be much simpler to review if it's a new
>     file rather than randomly interspered with essentially unrelated
>     existing code.
>
> Signed-off-by: Stephen Warren<swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Mark,
>
> If this can be taken through the SPI tree for 3.7 that'd be great. If
> it needs to be deferred to 3.8, we will need to start talking dependencies,
> since I'd like to take a patch through the Tegra tree to delete mach/dma.h
> in 3.8.
> ---

Acked by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

It will be great if this goes in k3.7 so that we can post the new driver 
on K3.8.
Definitely it will easy to review along with multiple bug fixes which is 
done in driver for interfacing different devices like camera/ touch etc.
Having all these changes on top of existing one will create more than 10 
patches and complicate the review. Also after these many patches, the 
new driver will be look different than the existing one.





------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
