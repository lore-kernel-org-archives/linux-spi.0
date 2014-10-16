From: addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/rockchip: fix bug that cause spi transfer timed
 out in DMA duplex mode
Date: Thu, 16 Oct 2014 17:26:02 +0800
Message-ID: <543F8F2A.9040904@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com> <1413372378-4309-1-git-send-email-addy.ke@rock-chips.com> <20141015130547.GE27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, amstan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, sonnyrao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org,
	zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wei.luo-TNX95d0MmH7DzftRWevZcw@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141015130547.GE27755-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi, Mark

The following changes is nessarry:(if tx complete, spi must be disabled too)
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 153269b..87bc16f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -418,8 +418,10 @@ static void rockchip_spi_dma_txcb(void *data)
        spin_lock_irqsave(&rs->lock, flags);

        rs->state &= ~TXBUSY;
-       if (!(rs->state & RXBUSY))
+       if (!(rs->state & RXBUSY)) {
+               spi_enable_chip(rs, 0);
                spi_finalize_current_transfer(rs->master);
+       }

        spin_unlock_irqrestore(&rs->lock, flags);
 }

Sorry for my mistake, I have not put these changes to this patch.

Do I need send patch v2 or a new patch to fix this issure?

On 2014/10/15 21:05, Mark Brown wrote:
> On Wed, Oct 15, 2014 at 07:26:18PM +0800, Addy Ke wrote:
>> In rx mode, dma must be prepared before spi is enabled.
>> But in tx and tr mode, spi must be enabled first.
> 
> Applied, thanks.
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
