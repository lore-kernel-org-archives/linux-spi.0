From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 19/26] DT bindings: spi: add spi client device properties
Date: Tue, 26 Mar 2019 22:56:40 -0700
Message-ID: <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
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
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds below cs timing properties to allow SPI master configuring
setup, hold and time interval between two SPI transactions to meet specific
SPI client device requirements.
 CS setup time
 CS hold time
 CS inactive delay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1553666253; bh=TbJVgRAIkjok3TkKNkfcvYc4WGyZhOpiH6sUZvadGrQ=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	 Content-Type;
	b=Tud9guY5XCzkjKA2k2n0+xO/vTfMTNhH1e0viAyYmlgoG/j+uSBAAmOeZucVUlmEa
	 rwqxlSm+rkYMUfgSWqmJXqEjgRIAqMhA32FOJmhgpblGwYUR22hnbdhbk4TcqMNsIO
	 mXBgiIq3sOB7dKCDIv4+YSUreRrnXrvrDN0NE9zN7D+AQWYLF5dI4v+UDalNYJU2hz
	 TusNrURxuHgtpModvYVQRPgPDv+nJ2QE6L7yZH/M6XP7jYprtQHWnHAiMwqqSXBcrf
	 8vlhV96anQSaGkioOUTp8ThlHSwBKLRFHRofVlrhT53K0xvTCvVst4aHvA1aq3QPw0
	 sVr25yohIPq7w==

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 9ba7c5a273b4..6167c5234b64 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -23,6 +23,13 @@ Required properties:
 Recommended properties:
 - spi-max-frequency: Definition as per
                      Documentation/devicetree/bindings/spi/spi-bus.txt
+
+spi-client device controller properties:
+- nvidia,cs-setup-clk-count: CS setup timing parameter.
+- nvidia,cs-hold-clk-count: CS hold timing parameter.
+- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock between
+  transfers.
+
 Example:
 
 spi@7000d600 {
-- 
2.7.4
