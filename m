From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 9/9] ASoC: rockchip_i2s: modify DMA max burst to 1
Date: Tue,  1 Sep 2015 17:59:24 +0800
Message-ID: <1441101564-1765-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441101381-1329-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Test with command -
arecord -D hw:0,0 /tmp/a.wav, there are the error dump:
[  134.899396] dma-pl330 ffb20000.dma-controller: fill_queue:2251 Bad Desc(7)

This error is happening when no a multiple of burst size * burst length are
coming in. The root cause is pl330 dma controller on Rockchips' platform cannot
support DMAFLUSHP instruction which make dma to flush the req of non-aligned or
non-multiple of what we set before. The saftest way is to set dma max burst to 1.

Signed-off-by: Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Fixes: 4495c89fc ("ASoC: add driver for Rockchip RK3xxx I2S")
Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
cc: Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
cc: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 sound/soc/rockchip/rockchip_i2s.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index acb5be5..5d35b2c 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -457,13 +457,19 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->regmap);
 	}
 
+	if (of_property_read_bool(np, "rockchip,i2s-broken-burst-len")) {
+		i2s->playback_dma_data.maxburst = 1;
+		i2s->capture_dma_data.maxburst = 1;
+	} else {
+		i2s->playback_dma_data.maxburst = 4;
+		i2s->capture_dma_data.maxburst = 4;
+	}
+
 	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
 	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->playback_dma_data.maxburst = 4;
 
 	i2s->capture_dma_data.addr = res->start + I2S_RXDR;
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->capture_dma_data.maxburst = 4;
 
 	i2s->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, i2s);
-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
