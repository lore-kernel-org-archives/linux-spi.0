From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 07/10] DMA: pl330: implement dmaengine_get_quirks hook
Date: Mon, 14 Sep 2015 07:49:10 +0800
Message-ID: <1442188150-6058-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olofj@lixom.net>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
To: Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

By adding this function, slave device can query quirks
from pl330 if they need special settings for dmaengine.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 drivers/dma/pl330.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3b9b426..bf01d24 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2156,6 +2156,14 @@ static int pl330_config(struct dma_chan *chan,
 	return 0;
 }
 
+static int pl330_quirks(struct dma_chan *chan)
+{
+	struct dma_pl330_chan *pch = to_pchan(chan);
+	struct pl330_dmac *pl330 = pch->dmac;
+
+	return pl330->quirks;
+}
+
 static int pl330_terminate_all(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
@@ -2928,6 +2936,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pd->device_tx_status = pl330_tx_status;
 	pd->device_prep_slave_sg = pl330_prep_slave_sg;
 	pd->device_config = pl330_config;
+	pd->device_get_quirks = pl330_quirks;
 	pd->device_pause = pl330_pause;
 	pd->device_terminate_all = pl330_terminate_all;
 	pd->device_issue_pending = pl330_issue_pending;
-- 
2.3.7
