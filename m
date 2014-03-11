From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/3] spi/xtensa-xtfpga: add DT binding documentation
Date: Tue, 11 Mar 2014 16:44:50 +0400
Message-ID: <1394541891-26469-3-git-send-email-jcmvbkbc@gmail.com>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Max Filippov <jcmvbkbc@gmail.com>
To: linux-xtensa@linux-xtensa.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
new file mode 100644
index 0000000..b6ebe2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
@@ -0,0 +1,9 @@
+Cadence Xtensa XTFPGA platform SPI controller.
+
+This simple SPI master controller is built into xtfpga bitstreams and is used
+to control daughterboard audio codec.
+
+Required properties:
+- compatible: should be "cdns,xtfpga-spi".
+- reg: physical base address of the controller and length of memory mapped
+  region.
-- 
1.8.1.4
