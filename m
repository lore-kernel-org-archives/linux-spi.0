From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 7/9] ARM: dts: Add arm,pl330-broken-no-flushp quirk for rk3xxx platform
Date: Tue,  1 Sep 2015 17:58:06 +0800
Message-ID: <1441101486-1631-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Cc: Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olofj@google.com>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Olof Johansson <olof@lixom.net>
To: Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Pl330 integrated in rk3xxx platform doesn't support
DMAFLUSHP function. So we add arm,pl330-broken-no-flushp quirk
for it. And add rockchip,spi-broken-burst-len for spi.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Doug Anderson <dianders@chromium.org>
cc: Olof Johansson <olof@lixom.net>

---

Changes in v3: None
Changes in v2: None
Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.

 arch/arm/boot/dts/rk3xxx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index a2ae9f3..ae15a81 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -79,6 +79,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA1>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 
 		dmac1_ns: dma-controller@2001c000 {
@@ -89,6 +90,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA1>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 			status = "disabled";
 		};
 
@@ -100,6 +102,7 @@
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMA2>;
 			clock-names = "apb_pclk";
+			arm,pl330-broken-no-flushp;
 		};
 	};
 
@@ -398,6 +401,7 @@
 		#size-cells = <0>;
 		dmas = <&dmac2 10>, <&dmac2 11>;
 		dma-names = "tx", "rx";
+		rockchip,spi-broken-burst-len;
 		status = "disabled";
 	};
 
@@ -411,6 +415,7 @@
 		#size-cells = <0>;
 		dmas = <&dmac2 12>, <&dmac2 13>;
 		dma-names = "tx", "rx";
+		rockchip,spi-broken-burst-len;
 		status = "disabled";
 	};
 };
-- 
2.3.7
