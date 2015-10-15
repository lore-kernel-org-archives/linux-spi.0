From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 07/10] DMA: pl330: add max burst for dmaengine
Date: Thu, 15 Oct 2015 09:36:14 +0800
Message-ID: <1444872974-2466-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
 alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Boojin Kim <boojin.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
 Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
 Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch add max burst capability for dmaengine and
limit burst capability to one for PL330_QUIRK_BROKEN_NO_FLUSHP

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v6:
- remove expose quirks and add max_burst for dmaengine

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/dma/pl330.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 008408d..1b0453b 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -33,6 +33,7 @@
 #define PL330_MAX_CHAN		8
 #define PL330_MAX_IRQS		32
 #define PL330_MAX_PERI		32
+#define PL330_MAX_BURST         16
 
 #define PL330_QUIRK_BROKEN_NO_FLUSHP BIT(0)
 
@@ -2938,6 +2939,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->dst_addr_widths = PL330_DMA_BUSWIDTHS;
 	pd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	pd->max_burst = ((pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP) ?
+			 1 : PL330_MAX_BURST);
 
 	ret = dma_async_device_register(pd);
 	if (ret) {
-- 
2.3.7
