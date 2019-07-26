From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 6/6] dt-bindings: spi: sprd: Change the hwlock support to be optional
Date: Fri, 26 Jul 2019 15:20:53 +0800
Message-ID: <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Cc: weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

No need to add hardware spinlock proctection due to add multiple
msater channel, so change it to be optional in documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/spi/spi-sprd-adi.txt       |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
index 8de589b..2567c82 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
@@ -25,18 +25,23 @@ data by ADI software channels at the same time, or two parallel routine of setti
 ADI registers will make ADI controller registers chaos to lead incorrect results.
 Then we need one hardware spinlock to synchronize between the multiple subsystems.
 
+The new version ADI controller supplies multiple master channels for different
+subsystem accessing, that means no need to add hardware spinlock to synchronize,
+thus change the hardware spinlock support to be optional to keep backward
+compatibility.
+
 Required properties:
 - compatible: Should be "sprd,sc9860-adi".
 - reg: Offset and length of ADI-SPI controller register space.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-- hwlock-names: Reference to hwlock name strings defined in the same order
-	as the hwlocks, should be "adi".
 - #address-cells: Number of cells required to define a chip select address
 	on the ADI-SPI bus. Should be set to 1.
 - #size-cells: Size of cells required to define a chip select address size
 	on the ADI-SPI bus. Should be set to 0.
 
 Optional properties:
+- hwlocks: Reference to a phandle of a hwlock provider node.
+- hwlock-names: Reference to hwlock name strings defined in the same order
+	as the hwlocks, should be "adi".
 - sprd,hw-channels: This is an array of channel values up to 49 channels.
 	The first value specifies the hardware channel id which is used to
 	transfer data triggered by hardware automatically, and the second
-- 
1.7.9.5
