Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD051AED4;
	Wed, 30 Sep 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792610; cv=none; b=akA/pom6vjHhuLTj8gjBuuHFMFOUEBa5PL3fBEfDL6IdS+Gnmz45FGpCUvdFyqRYuxKTtEyvF89rJkzVrJyvwXLKwstn4htfISLlILQdm8DNXMSXJCnV5qyKgIG1CPgK8q7uqQYP/mXb4W5f15xmORhis+C+OAyygNsldgOhRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792610; c=relaxed/simple;
	bh=0iLC8BIgKk5AA9uzN6MMajbopvNsghfdMp9lC5YR7M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxMRjcPkt78raxKosw4M5nHCTmAXE2yIchGX2MqBhOvloN3vHueJe2fleAfT68LvvOJ844N5WjF+lF9kNsFUfKspVatB+I/5fbxfOPMFxUCiJO5JyqfrZ29MNojOOorpUCSXpF6N6n2XRxD9a3Jl6BHr5AXemo+pEye3TzATJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-01 (Coremail) with SMTP id qwCowAAHofR9U71q8y58CQ--.14027S6;
	Thu, 01 Oct 2026 02:23:05 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Thu, 01 Oct 2026 02:22:53 +0800
Subject: [PATCH v2 4/4] riscv: dts: sophgo: Limit SG2042 SPI NOR to 12.5
 MHz
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-fix-sg204xspi-v2-4-014dbaf22b5e@iscas.ac.cn>
References: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
In-Reply-To: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>, Longbin Li <looong.bin@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Han Gao <rabenda.cn@gmail.com>, Hangfan Li <lihangfan@iscas.ac.cn>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:qwCowAAHofR9U71q8y58CQ--.14027S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF48XrWkWw4UArykZF4fZrb_yoW5GF48pa
	n5urW3CaySgrnYyay3tFyFgr43JrW8u3W7Kr1rC34UJw4kZayDt3y7Xw13Jr17Za1Yq393
	Wrn5G3s5Gr1aqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4U
	JVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxV
	A2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
	cSsGvfC2KfnxnUUI43ZEXa7sRiHUDtUUUUU==
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiCRIGDGq9GDh3AgAAsT

Use 12.5 MHz on the SG2042 EVBs and Milk-V Pioneer to match the vendor
kernel. The existing 50 MHz limit raises SCK once the driver starts
honoring spi-max-frequency.

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts        | 4 ++--
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts        | 2 +-
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
index b116dfa904cd982dc41c8cffdc770d4d0f81e0a7..9f403e564694eae14913f6ab23080a6333df15ae 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
@@ -256,7 +256,7 @@ &spifmc0 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <50000000>;
+		spi-max-frequency = <12500000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
@@ -268,7 +268,7 @@ &spifmc1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <50000000>;
+		spi-max-frequency = <12500000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
index b2ceae2d8829ec16c99c2ea2b040c433b819093e..d8c5814f22581076e6b5114f762d4fd090681b80 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
@@ -244,7 +244,7 @@ &spifmc1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <50000000>;
+		spi-max-frequency = <12500000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ecf8c1e290792c3a27651040eae3c603741cd0c7..4f39eb56b364894f17b97d482b6d9d867a32ad2e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -177,7 +177,7 @@ &spifmc0 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <50000000>;
+		spi-max-frequency = <12500000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
@@ -189,7 +189,7 @@ &spifmc1 {
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <50000000>;
+		spi-max-frequency = <12500000>;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};

-- 
2.47.3

