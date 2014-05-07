From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/6] spi: tegra114: Make of_device_id array const
Date: Wed, 07 May 2014 16:51:02 +0900
Message-ID: <01de01cf69c9$179aaef0$46d00cd0$%han@samsung.com>
References: <01db01cf69c8$584cd640$08e682c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Stephen Warren' <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	'Laxman Dewangan' <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <01db01cf69c8$584cd640$08e682c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Make of_device_id array const, because all OF functions
handle it as const.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-tegra114.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 4006495..e4a85ad 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1012,7 +1012,7 @@ static irqreturn_t tegra_spi_isr(int irq, void *context_data)
 	return IRQ_WAKE_THREAD;
 }
 
-static struct of_device_id tegra_spi_of_match[] = {
+static const struct of_device_id tegra_spi_of_match[] = {
 	{ .compatible = "nvidia,tegra114-spi", },
 	{}
 };
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
