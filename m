From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 01/10] DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit
Date: Sun,  6 Sep 2015 09:11:47 +0800
Message-ID: <1441501907-13743-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olofj@google.com>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, Boojin Kim <boojin.kim@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Olof Johansson <olof@lixom.net>
To: Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch adds to support burst mode for dev-to-mem and
mem-to-dev transmit.

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olof@lixom.net>

Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
- amend the author
- reorder the patches suggested by Doug
- add Reviewed-by: Doug Anderson <dianders@chromium.org> for
  rk3288.dtsi patch and arm-pl330.txt patch

Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.
- add From original author.
- remove Sunny's tag

 drivers/dma/pl330.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index ecab4ea0..0d544d2 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1141,10 +1141,13 @@ static inline int _ldst_devtomem(unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond;
+
+	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
 
 	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
-		off += _emit_LDP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
+		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
+		off += _emit_LDP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_ST(dry_run, &buf[off], ALWAYS);
 		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
 	}
@@ -1156,11 +1159,14 @@ static inline int _ldst_memtodev(unsigned dry_run, u8 buf[],
 		const struct _xfer_spec *pxs, int cyc)
 {
 	int off = 0;
+	enum pl330_cond cond;
+
+	cond = (pxs->desc->rqcfg.brst_len == 1) ? SINGLE : BURST;
 
 	while (cyc--) {
-		off += _emit_WFP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
+		off += _emit_WFP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_LD(dry_run, &buf[off], ALWAYS);
-		off += _emit_STP(dry_run, &buf[off], SINGLE, pxs->desc->peri);
+		off += _emit_STP(dry_run, &buf[off], cond, pxs->desc->peri);
 		off += _emit_FLUSHP(dry_run, &buf[off], pxs->desc->peri);
 	}
 
@@ -2557,7 +2563,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 
 		desc->rqtype = direction;
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->bytes_requested = period_len;
 		fill_px(&desc->px, dst, src, period_len);
 
@@ -2702,7 +2708,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		}
 
 		desc->rqcfg.brst_size = pch->burst_sz;
-		desc->rqcfg.brst_len = 1;
+		desc->rqcfg.brst_len = pch->burst_len;
 		desc->rqtype = direction;
 		desc->bytes_requested = sg_dma_len(sg);
 	}
-- 
2.3.7
