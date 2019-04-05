From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 16/20] spi-summary: document set_cs_timing
Date: Thu, 4 Apr 2019 17:14:15 -0700
Message-ID: <1554423259-26056-16-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch documents set_cs_timing SPI master method.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/spi/spi-summary | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 1721c1b570c3..1a63194b74d7 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -572,6 +572,12 @@ SPI MASTER METHODS
 	0: transfer is finished
 	1: transfer is still in progress
 
+    master->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles,
+			      u8 hold_clk_cycles, u8 inactive_clk_cycles)
+	This method allows SPI client drivers to request SPI master controller
+	for configuring device specific CS setup, hold and inactive timing
+	requirements.
+
     DEPRECATED METHODS
 
     master->transfer(struct spi_device *spi, struct spi_message *message)
-- 
2.7.4
