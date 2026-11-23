Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427113;
	b=bopWFVi8I4DHi6zy3P8YepBg7KJ0iP7KU3etMMFivAONmzIi4+1jpcjNCC2F2uuIKHr/
	 EExR65WuctbLtmcC7qL3xejAzaxoo2SkJ0aEsZTDnfEbO9zYBVkGs4KB5uGfP+VPvOcSM
	 QlFGscrFGxDA4K/dd/WQ7U805N3nccuYFe2MyZ0W0+6Vc3m/MId3W5YW1I3gVCohyx8b7
	 +TmzB45rJ2KNvhmQd1qAaYJOyMVOK3HiDp4AjEwYiZjD2bQxl8IHavPQIgThpCcXm3jo3
	 77zPeHR0ypBQ5X8k+Ugc3co7M5bJkHGcWxhXPRDcg/kY5fG9nvDKdo2Wkqvd0O6YdZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427113;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=yn36Mkpi/X9k7obbI5fyLF0Pe6QqiXuOva9oIQ9Cepc=;
	b=yOqKCr9LLsBVYIDsrmEev5F4/XpH+ITkS7LeiPidWlwbK840cT0NYgTQuREuiKSX0Kax
	 1k6PzaR2J2sE97XnL6eiGnbScuV4d2DQsjU0GWVncwl/LlH+EBtDQkj0z2WGf0FfqMByZ
	 tlck99RAIMufUmvXXFHXDXFrYvFWMmPKo1vmxvZ0WCDOlNwRWrQD4hCvUYiMuUeudOlcR
	 nDE2dw+TeU6LI5m57xwjfHsipK25uFRu30HKbLmAYz/ubsKY26/a8GYOoc7y2GjhWj+Xw
	 0N4bkkw7I09TcbGwZcZKMqwE8OyRTRc77chCOo40Q4RRYRxV/63NBFh/vJ5j6GUXOCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF2606A32A;
	Mon, 23 Nov 2026 09:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3EF2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8Cxf9MmCwRr4zAiAA--.31919S3;
	Mon, 23 Nov 2026 17:45:10 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJDxTs8jCwRrW9o2AA--.44054S4;
	Mon, 23 Nov 2026 17:45:10 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Mark Brown <broonie@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bingxiong Li <libingxiong@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 2/5] spi: dt-bindings: loongson,ls2k-spi: Document loongson,ls2k0300-spi-io compatible
Date: Mon, 23 Nov 2026 17:44:47 +0800
Message-ID: <f4b1bbc084281212070f4aacd19fafbaaff11b42.1795425389.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795425389.git.zhoubinbin@loongson.cn>
References: <cover.1795425389.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxTs8jCwRrW9o2AA--.44054S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGsDnvwK9QAAs9
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWUZr15JF1rGr1fGFyxXrc_yoW8ZryDpF
	9xCr1fGrW8tF17Cws8ta48Aa1fZr93Z3ZrCFZ2yF47Ga9YgayUXw43KFn0qa1fGF4DXFy5
	ZF4kKrW5Ga47urcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	co7KUUUUU

Loongson-2K0300 integrates a new SPI-IO controller with enhanced
registers and extended capabilities (interrupt, DMA, larger FIFO, etc.)
which is distinct from the legacy SPI flash controller.

Define the new compatible `loongson,ls2k0300-spi-io` and require the
associated DMA and interrupt properties for this variant.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
index 8a36dbece788..b113d10c5bd9 100644
--- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - loongson,ls2k0300-spi-io
           - loongson,ls2k1000-spi
       - items:
           - enum:
@@ -32,6 +33,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
 required:
   - compatible
   - reg
@@ -39,6 +48,23 @@ required:
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: loongson,ls2k0300-spi-io
+
+then:
+  required:
+    - dmas
+    - dma-names
+    - interrupts
+
+else:
+  properties:
+    dmas: false
+    dma-names: false
+
 examples:
   - |
     spi0: spi@1fff0220{
@@ -48,3 +74,18 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+
+    spi@1610c000 {
+        compatible = "loongson,ls2k0300-spi-io";
+        reg = <0x1610c000 0x2000>;
+        clocks = <&clk LS2K0300_CLK_DEV_GATE>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <6 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&dma_router 14 1 0x8e>,
+               <&dma_router 14 0 0x8e>;
+        dma-names = "tx", "rx";
+    };
-- 
2.52.0

