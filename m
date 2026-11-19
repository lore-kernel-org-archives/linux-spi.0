Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082787;
	b=KddqlHCuYJ7vkQ+y6jZVDd1UfdAh/CWnqICu/0WMKjrtlU38nj+zx9FdbKbJPjVJE7mg
	 M5EXZ78uFpDInXJT0pnsT3cYkzVml4Md6LzHCmaPDZwJO3CJjEr2KEnQa7wq5gOJzsmsg
	 goc/yZiPWE86CUQbcJOl4jaAK8qaM2/rh6v+TdnWvXAWR/T6ZxrJjdgQzo902mn55RgtT
	 tyXpHVpvOPw2yo0YgyWlvWoYBlos1KpLDhE+KbBLHo/JxQPuParvQRFP7lJlvJica2X5s
	 h+LXppOW7tOf/UJN8Su4Qlz7HJu8blWw8Fq/0eZfi9ha7L2ubX2mGuBIW6FyAuVS9wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082787;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=u1xaWwAsHhJ/zZRtSvfhv8ha9UhsTVPVWphAIXjStNI=;
	b=pZCdZowqJZKKoJDuY26iedDGXTJ18S9MdNZVKwKsQtGElGxcjmu+ET1nejbDypoNor5c
	 OpZN9YBeru8irK6J6B7sYqa2jRqhC6r+svHDpnvKWA1rmNvqVEoKZ8pyZMuNF2KKp7/Gm
	 Sngyh+m9BWoztb0DOFzjEgdsez8BzvGqiIbRnvYudlTMrAmXCKBgm51wwtw24MvMLGh4y
	 fOb948kgKYrJCPbjKmRNCdKf9+ebJYTH1HeEJ+DVRUTW4S5mA+kJOPI4/o/GTck9wPiWO
	 f/7SIRoCvwo4ltIV1Joep7jpBOPhx8xCTO5c+jN9F+glm/UMqRuxlUGu/Htb4/EebQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=GT24AQBk;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=MOTvhZ5h;
	arc=none smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB89B606A320;
	Thu, 19 Nov 2026 10:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB89B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=GT24AQBk;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=MOTvhZ5h
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9QvSA1362221;
	Thu, 19 Nov 2026 02:06:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pfptdkimsnps; bh=u1xaWwAs
	HhJ/zZRtSvfhv8ha9UhsTVPVWphAIXjStNI=; b=GT24AQBkCyre+7uy9Oh/RPAd
	YkVeoM948hfolQUBEKZml+o8Am0ThAIJZI6wNaS8ffOZN0Lo0oXEpR4qFNbNxDC4
	cw7B2aBHj1B8ADhPsnJsJIZZhrfMXHeEqwSLOc5SLJ6m2PCFgxWmJdsNmHsKlTXX
	iqai+mGIMQd3iPM5qkB4FgjXDTxiOGJjyT3XpI0iPqMCjJrrvwgZcLnCGTVFwy4V
	vqOPkgjApeehjZzMKmMJAQupjwEEKzKDvsBAwZRGr64ncBLS/Vn3ZpwsNxVVc3xv
	dbXpKuS/dhlHA7uEJl7H7iS8B1DNtSZToQi6oGFdgWuGIvP29AwL3+cu7PB/kQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4j1p42jx0t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1795082777; bh=vgAbQfyzOIJcLoE4i7FIFNswQrah2PY6Rv3WsEhOOsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOTvhZ5hnM3OWTrGrlqv5WCipZeBEX5p6ImW/OewfWIq7Xlpri+cxKgkHIWuuBnZS
	 EtfmR1FhQiD1/iEPklEYRV7N/1Khaf/ZUY84LhQ6xPJnElgoezFkq9ak9vqjwWzm3h
	 tC2Y1yCV7RJKBtSRJWecMzuHxH/jtg4NgxUYrQbprkKcgREtqFL+cttLjL9Bx7ATuh
	 9BoWAz7Z12TLcPI7BBUCO8IrThfGb7qInMIFWxVt6z0xQ3vm92K+4E8yasWjzPtoQ1
	 R8MUUmFxDMh3fDweEOjbxPcBEmw2eC/QHLlYhe+vhTWDqBqGZNulRGMtGUZRREE3ru
	 /GMFuU+/EcuyQ==
Received: from mailhost.synopsys.com (eudc-mailhost1.synopsys.com [10.213.161.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5F5A1401DC;
	Thu, 19 Nov 2026 10:06:17 +0000 (UTC)
Received: from prakriti-VM.internal.synopsys.com (unknown [10.150.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id A734FC17EA;
	Thu, 19 Nov 2026 10:06:12 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: [PATCH 1/6] dt-bindings: spi: Add Synopsys DWC SSI v2.02a binding
Date: Thu, 19 Nov 2026 15:35:08 +0530
Message-Id: <20261119100513.433044-2-prakriti@synopsys.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119100513.433044-1-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Zv94uN7G c=1 sm=1 tr=0 ts=6afeca1a cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22 a=gEfo2CItAAAA:8
 a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8 a=VtNJ17bmlGCbkX8FLg4A:9
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX3y380A2d/UsC
 cFPKSO2ZyuUsB6hLQwpEwumffc2pqOiYL8MXG0BmOwMEbzyClzv0w6Ev3yKgWkjsgJWVnTTiOiM
 mqtpvRVI+dr+5SeDYjJtWj60oo6Tv4zY/v53hV3KYJoxt46PKuUO8GRwwrAUY+V4u54Dhy6Usyq
 1DeozIB3cXDXDpkXKGWd2kznRNm+PAU5nfpJrxriWrsMRoJmsJ2JezVkMem+Mmfl4YNd2S4FIi3
 b5Ks/oyvlAAQ0eniXeUlA3oPLvcTCmsT1kqiheAkXRqlZFD5Jem0gQEBaSYSpHN9g4kzB6+ooae
 lwQtbCXB589fLQGccp/ExHhYw2p+3Gheyi8TpRkhHJfT7iBawR1lEnmauQ3z9FXiUHvuFR8de8C
 2SWm62j+on84Hz9FWeMhG1be9PynzrHjz3qHluGF+E8UAYYxja9iiEtEH/KopCHRFS24a8Y7psx
 N3tUlEPtyyoYnBOEINw==
X-Proofpoint-ORIG-GUID: kYKhu7fx0XgmX50JRxz22AirHGmd9d_B
X-Proofpoint-GUID: kYKhu7fx0XgmX50JRxz22AirHGmd9d_B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX7XLsXNH7Da+a
 YoqAwTmR5WQIYYdSNECfWIU9bvd22DKAShrc0usX//QuU2BE0wJlBWS3No/Mwj0WqAtW7VneMnU
 ESrr9XZ/HPnQsDZA+o8U3BYkUo/VynA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611190040

From: Siddhant Kumar <sidkumar@synopsys.com>

Add a binding for the Synopsys DesignWare Synchronous Serial Interface
(DWC_ssi v2.02a). The controller has a per-chip-select register map
and dedicated chip-select control.

Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>
---
 .../bindings/spi/snps,dwc-ssi-2.02a.yaml      | 144 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml

diff --git a/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml b/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
new file mode 100644
index 000000000000..7cccd627f809
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/snps,dwc-ssi-2.02a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare SSI Gen2 SPI Controller
+
+maintainers:
+  - Siddhant Kumar <sidkumar@synopsys.com>
+  - Prakriti Sharma <prakriti@synopsys.com>
+
+description: |
+  The Synopsys DesignWare SSI Gen2 (DWC_ssi v2.02a) is an enhanced SPI
+  controller featuring per-chip-select register banks, dedicated CS control,
+  and support for Standard/Dual/Quad/Octal SPI modes with DDR capability.
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: snps,dwc-ssi-2.02a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The DWC SSI Gen2 IP exposes per-source interrupt outputs alongside a
+      combined ssi_intr. SoC integrators may route either the combined line,
+      the individual lines, or any subset. Provide either a single combined
+      IRQ, or one entry per declared name in interrupt-names (matching order).
+    minItems: 1
+    maxItems: 4
+
+  interrupt-names:
+    description: |
+      Optional. Naming for each physical IRQ line when the SoC breaks the
+      controller's interrupt output into multiple wires. Each name is gated
+      by its corresponding ISR bit in the controller:
+        "rxf"  - RX FIFO threshold  (SSI_RXF_INTR, ISR.RXFI)
+        "txe"  - TX FIFO threshold  (SSI_TXE_INTR, ISR.TXEI)
+        "txaf" - TX FIFO almost full (ssi_txaf_intr, ISR.TXAFI)
+        "wsf"  - Write status fail   (spi_wr_status_fail_intr, ISR.SPIWSFI)
+      Omit this property if the SoC combines all sources onto one wire.
+    minItems: 1
+    maxItems: 4
+    items:
+      enum: [rxf, txe, txaf, wsf]
+
+  clocks:
+    minItems: 1
+    items:
+      - description: SSI controller reference clock
+      - description: APB interface clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: ssi_clk
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  num-cs:
+    minimum: 1
+    maximum: 4
+    description:
+      Number of chip selects supported by the controller.
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  rx-sample-delay-ns:
+    default: 0
+    description: |
+      Default value of the rx-sample-delay-ns property.
+      This value will be used if the property is not explicitly defined
+      for a SPI slave device.
+
+      SPI Rx sample delay offset, unit is nanoseconds.
+      The delay from the default sample time before the actual sample of the
+      rxd input signal occurs. The "rx_sample_delay" is an optional feature
+      of the designware controller, and the upper limit is also subject to
+      controller configuration.
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    $ref: spi-peripheral-props.yaml
+    additionalProperties: true
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+      rx-sample-delay-ns:
+        description:
+          Per-device Rx sample delay override, in nanoseconds.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - clocks
+
+examples:
+  - |
+    spi@20100000 {
+      compatible = "snps,dwc-ssi-2.02a";
+      reg = <0x20100000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      interrupts = <0 42 4>;
+      clocks = <&spi_clk>;
+      clock-names = "ssi_clk";
+      num-cs = <2>;
+      dmas = <&dma0 10>, <&dma0 11>;
+      dma-names = "tx", "rx";
+      rx-sample-delay-ns = <3>;
+
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        reg = <0>;
+        spi-max-frequency = <50000000>;
+        spi-rx-bus-width = <4>;
+        spi-tx-bus-width = <4>;
+        rx-sample-delay-ns = <7>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index ce1b9e514e08..e68a4337a651 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27304,6 +27304,13 @@ S:	Supported
 F:	Documentation/admin-guide/perf/dwc_pcie_pmu.rst
 F:	drivers/perf/dwc_pcie_pmu.c
 
+SYNOPSYS DESIGNWARE SSI GEN2 SPI DRIVER
+M:	Prakriti Sharma <prakriti@synopsys.com>
+M:	Siddhant Kumar <sidkumar@synopsys.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
+
 SYNOPSYS HSDK RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Supported
-- 
2.34.1

