From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 06/10] dmaengine: add API for getting dma controller's quirk
Date: Mon, 14 Sep 2015 07:48:59 +0800
Message-ID: <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
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

Add dmaengine_get_quirks API for peripheral devices to query
quirks if they need it to make special workaround due to broken
dma controller design.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 include/linux/dmaengine.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e2f5eb4..5174ca4 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -704,6 +704,7 @@ struct dma_device {
 
 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
+	int (*device_get_quirks)(struct dma_chan *chan);
 	int (*device_pause)(struct dma_chan *chan);
 	int (*device_resume)(struct dma_chan *chan);
 	int (*device_terminate_all)(struct dma_chan *chan);
@@ -723,6 +724,14 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 	return -ENOSYS;
 }
 
+static inline int dmaengine_get_quirks(struct dma_chan *chan)
+{
+	if (chan->device->device_get_quirks)
+		return chan->device->device_get_quirks(chan);
+
+	return -ENOSYS;
+}
+
 static inline bool is_slave_direction(enum dma_transfer_direction direction)
 {
 	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
-- 
2.3.7
