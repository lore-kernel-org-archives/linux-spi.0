From: Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: [PATCH v10 1/3] of: Add vendor prefix for Lattice Semiconductor
Date: Sat, 17 Dec 2016 22:33:52 -0700
Message-ID: <1482039234-21335-1-git-send-email-joel@airwebreathe.org.uk>
Cc: Joel Holdsworth <joel@airwebreathe.org.uk>
To: atull@opensource.altera.com, moritz.fischer@ettus.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        marex@denx.de, linux-fpga@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Lattice Semiconductor Corporation is a manufacturer of integrated
circuits and IP products, including low-power FPGAs, video connectivity
devices and millimeter wave wireless products.

Website: http://latticesemi.com

Signed-off-by: Joel Holdsworth <joel@airwebreathe.org.uk>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Alan Tull <atull@opensource.altera.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 64fdc8c..7a87932 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -158,6 +158,7 @@ kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
 lacie	LaCie
 lantiq	Lantiq Semiconductor
+lattice	Lattice Semiconductor
 lenovo	Lenovo Group Ltd.
 lg	LG Corporation
 linux	Linux-specific binding
-- 
2.7.4
