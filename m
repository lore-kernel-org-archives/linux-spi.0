From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: omap2-mcspi: remove duplicated include from spi-omap2-mcspi.c
Date: Wed, 14 Nov 2012 15:54:27 +0000
Message-ID: <20121114155427.957923E0B1A@localhost>
References: <CAPgLHd_rNn_bJ8BJOwcq8EmEi-BQcoakHmQpHG+NdOdDgPSMpQ@mail.gmail.com>
Cc: yongjun_wei@trendmicro.com.cn,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, rob.herring@calxeda.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPgLHd_rNn_bJ8BJOwcq8EmEi-BQcoakHmQpHG+NdOdDgPSMpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, 7 Oct 2012 21:29:21 +0800, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.

Applied, thanks.

> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)

Since I have to manually remove the above cruft from commit logs, can
you please omit it from the commit text when posting patches?

Thanks,
g.

> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/spi/spi-omap2-mcspi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 474e217..b8b2f03 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -39,7 +39,6 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/pinctrl/consumer.h>
> -#include <linux/err.h>
>  
>  #include <linux/spi/spi.h>
>  
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
