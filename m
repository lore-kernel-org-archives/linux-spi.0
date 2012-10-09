From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] spi:clk: preparation for switch to common clock
	framework
Date: Tue, 9 Oct 2012 17:07:17 +0530
Message-ID: <50740C6D.7070906@ti.com>
References: <1347900122-25101-1-git-send-email-m-karicheri2@ti.com>
	<1347900122-25101-2-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1347900122-25101-2-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 9/17/2012 10:12 PM, Murali Karicheri wrote:
> As a first step towards migrating davinci platforms to use common clock
> framework, replace all instances of clk_enable() with clk_prepare_enable()
> and clk_disable() with clk_disable_unprepare(). Until the platform is
> switched to use the CONFIG_HAVE_CLK_PREPARE Kconfig variable, this just
> adds a might_sleep() call and would work without any issues.
> 
> This will make it easy later to switch to common clk based implementation
> of clk driver from DaVinci specific driver.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
> Reviewed-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patch had to be applied manually and with some fuzz when I applied
it to latest linus/master. There were no conflicts though and once I
applied it, I was able to test SPI flash on DA850 EVM successfully using it.

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

I am hoping this patch can still go in v3.7. I realize we are in the
middle of the merge window though.

Thanks,
Sekhar

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
