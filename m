From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v5 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
Date: Mon, 14 Sep 2015 07:49:42 +0800
Message-ID: <1442188182-6181-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
 Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
 Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
 dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olofj-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
 Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
 Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1442187923-5736-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

From: Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Test with command -
arecord -D hw:0,0 /tmp/a.wav, there are the error dump:
dma-pl330 ffb20000.dma-controller: fill_queue:2251 Bad Desc(7)

This error is happening when no a multiple of burst size * burst
length are coming in. The root cause is pl330 dma controller on
Rockchips' platform cannot support DMAFLUSHP instruction which make
dma to flush the req of non-aligned or non-multiple of what we set
before. The saftest way is to set dma max burst to 1.

Signed-off-by: Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Fixes: 4495c89fc ("ASoC: add driver for Rockchip RK3xxx I2S")
Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
cc: Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
cc: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---

Changes in v5:
- use switch statement for dma_quirk's manipulation

Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 sound/soc/rockchip/rockchip_i2s.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index acb5be5..543d0c0 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -23,6 +23,8 @@
 
 #define DRV_NAME "rockchip-i2s"
 
+#define ROCKCHIP_I2S_BROKEN_BURST_LEN (1<<0) /* broken burst len */
+
 struct rk_i2s_dev {
 	struct device *dev;
 
@@ -418,6 +420,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	struct rk_i2s_dev *i2s;
 	struct resource *res;
 	void __iomem *regs;
+	int dma_quirk;
 	int ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
@@ -489,6 +492,24 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		goto err_pcm_register;
 	}
 
+	dma_quirk = snd_dmaengine_pcm_get_quirks(&pdev->dev);
+	switch (dma_quirk) {
+	case ROCKCHIP_I2S_BROKEN_BURST_LEN:
+		/*
+		 * Unfortunately, we find broken burst len here,
+		 * just have to limit maxburst to ONE in order to avoid
+		 * non-multiple burst len access fail the dmaengine if
+		 * it can't support flush peripheral function.
+		 */
+		i2s->playback_dma_data.maxburst = 1;
+		i2s->capture_dma_data.maxburst = 1;
+		break;
+	default:
+		dev_info(&pdev->dev, "Default no dma_quirk!\n");
+		break;
+	}
+
 	return 0;
 
 err_pcm_register:
-- 
2.3.7
