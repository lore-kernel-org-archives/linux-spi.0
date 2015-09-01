From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 4/9] Documentation: rockchip-i2s: add description of rockchip,i2s-broken-burst-len
Date: Tue,  1 Sep 2015 17:57:29 +0800
Message-ID: <1441101449-1506-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olofj@google.com>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Jianqun Xu <xjq@rock-chips.com>,
	Olof Johansson <olof@lixom.net>
To: Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Addy Ke <addy.ke@rock-chips.com>
cc: Jianqun Xu <xjq@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olof@lixom.net>
cc: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..9987787 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -22,6 +22,10 @@ Required properties:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
 
+Optional Properties:
+- rockchip,i2s-broken-burst-len: quirk for broken burst len on Rockchip platform.
+				 Add this property will force driver to set burst ONE.
+
 Example for rk3288 I2S controller:
 
 i2s@ff890000 {
-- 
2.3.7
