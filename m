From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 10/20] Documentation: devicetree: spi: add spi-lsbyte-first propery
Date: Thu, 4 Apr 2019 17:14:09 -0700
Message-ID: <1554423259-26056-10-git-send-email-skomatineni@nvidia.com>
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

spi-lsbyte-first optional property allows SPI slaves to choose byte
order of little endian for transfers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f787ef..b455c24a80df 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -71,6 +71,7 @@ All slave nodes can contain the following optional properties:
 		    active high.
 - spi-3wire       - Empty property indicating device requires 3-wire mode.
 - spi-lsb-first   - Empty property indicating device requires LSB first mode.
+- spi-lsbyte-first - Empty property indicating device requires LSByte first mode.
 - spi-tx-bus-width - The bus width (number of data wires) that is used for MOSI.
 		    Defaults to 1 if not present.
 - spi-rx-bus-width - The bus width (number of data wires) that is used for MISO.
-- 
2.7.4
