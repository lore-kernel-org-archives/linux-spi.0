From: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/9] spi/tegra: add clk_prepare/clk_unprepare
Date: Fri, 1 Jun 2012 14:42:45 +0530
Message-ID: <1338541968-7961-7-git-send-email-pgaikwad@nvidia.com>
References: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1338541968-7961-1-git-send-email-pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

This patch should go through Tegra tree since other patches to port Tegra
to generic clock framework are dependent on it. Posting here to get ack from
the maintainers.

Signed-off-by: Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra.c b/drivers/spi/spi-tegra.c
index ae6d78a..7f99ff3 100644
--- a/drivers/spi/spi-tegra.c
+++ b/drivers/spi/spi-tegra.c
@@ -261,7 +261,7 @@ static void spi_tegra_start_transfer(struct spi_device *spi,
 		clk_set_rate(tspi->clk, speed);
 
 	if (tspi->cur_speed == 0)
-		clk_enable(tspi->clk);
+		clk_prepare_enable(tspi->clk);
 
 	tspi->cur_speed = speed;
 
@@ -373,7 +373,7 @@ static void tegra_spi_rx_dma_complete(struct tegra_dma_req *req)
 			spi = m->state;
 			spi_tegra_start_message(spi, m);
 		} else {
-			clk_disable(tspi->clk);
+			clk_disable_unprepare(tspi->clk);
 			tspi->cur_speed = 0;
 		}
 	}
-- 
1.7.4.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
