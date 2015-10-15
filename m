From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 02/10] Documentation: arm-pl330: add description of arm,pl330-broken-no-flushp
Date: Thu, 15 Oct 2015 09:35:23 +0800
Message-ID: <1444872923-2258-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olof@lixom.net>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>,
	Boojin Kim <boojin.kim@samsung.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
To: Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- add Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

Changes in v2:
- add Reviewed-by: Doug Anderson <dianders@chromium.org>

Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.

 Documentation/devicetree/bindings/dma/arm-pl330.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
index 2675658..db7e226 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
+++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
@@ -15,6 +15,7 @@ Optional properties:
     cells in the dmas property of client device.
   - dma-channels: contains the total number of DMA channels supported by the DMAC
   - dma-requests: contains the total number of DMA requests supported by the DMAC
+  - arm,pl330-broken-no-flushp: quirk for avoiding to execute DMAFLUSHP
 
 Example:
 
-- 
2.3.7
