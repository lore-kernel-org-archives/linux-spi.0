From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/6] spi: tegra20-slink: Make of_device_id array const
Date: Wed, 07 May 2014 16:52:36 +0900
Message-ID: <01e001cf69c9$4ff7b310$efe71930$%han@samsung.com>
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
 drivers/spi/spi-tegra20-slink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index e3c1b93..0b9e32e 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1001,7 +1001,7 @@ static const struct tegra_slink_chip_data tegra20_spi_cdata = {
 	.cs_hold_time = false,
 };
 
-static struct of_device_id tegra_slink_of_match[] = {
+static const struct of_device_id tegra_slink_of_match[] = {
 	{ .compatible = "nvidia,tegra30-slink", .data = &tegra30_spi_cdata, },
 	{ .compatible = "nvidia,tegra20-slink", .data = &tegra20_spi_cdata, },
 	{}
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
