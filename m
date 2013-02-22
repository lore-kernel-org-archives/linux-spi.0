From: Boojin Kim <boojin.kim@samsung.com>
Subject: [PATCH v2 4/4] ASoC: samsung: add to configure dma maxburst size
Date: Fri, 22 Feb 2013 17:10:10 +0900
Message-ID: <001c01ce10d4$088ea3c0$19abeb40$%kim@samsung.com>
Cc: 'Vinod Koul' <vinod.koul@intel.com>, 'Dan Williams' <djbw@fb.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Mark Brown' <broonie@opensource.wolfsonmicro.com>,
	'Rob Herring' <rob.herring@calxeda.com>,
	'Sangbeom Kim' <sbkim73@samsung.com>
To: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	alsa-devel@alsa-project.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds to configure dma maxburst size.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 sound/soc/samsung/dma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 21b7926..bd4faa0 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -172,6 +172,7 @@ static int dma_hw_params(struct snd_pcm_substream *substream,
 			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK
 			? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
 		config.width = prtd->params->dma_size;
+		config.maxburst = 1;
 		config.fifo = prtd->params->dma_addr;
 		prtd->params->ch = prtd->params->ops->request(
 				prtd->params->channel, &req, rtd->cpu_dai->dev,
--
1.7.5.4
