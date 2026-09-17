Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4D59480B;
	Thu, 17 Sep 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655383; cv=none; b=JKuAD3w6vGREKzey9AMfx+RV6E8PEFJgYoTvD/w+QhLYyV/V9C+G9BxXzJB4OvD2R7ibEWMJYhQrm6RjjklKbJZD5KZNEeCidRmgd4LacpLGCvObcoyFR3eDkyFXTOPmJivGh70TyE2A+4m7fE7TrqEEFSWc8VHvUVGU/snbQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655383; c=relaxed/simple;
	bh=0iLC8BIgKk5AA9uzN6MMajbopvNsghfdMp9lC5YR7M4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YIG1nmzLlmolWriOZjn6Q/ZSf8npxpaZ3iAUksdASwTpfjtOOt5I+jfPLJzanXfKE2Ba/QHiEsX4IJjHQOrDTxCur+C0EXZf81PjmHtRl0RViOPL7F2Spm/1TiqloLxJzx8uxDCJfNoUG9UiwbIDrCye3aI/mjBDya6zws6K2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-05 (Coremail) with SMTP id zQCowABHtD5A+atqNnqCCA--.4692S6;
	Thu, 17 Sep 2026 22:29:27 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Date: Thu, 17 Sep 2026 22:29:22 +0800
Subject: [PATCH 4/4] riscv: dts: sophgo: Limit SG2042 SPI NOR to 12.5 MHz
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-fix-sg204xspi-v1-4-5c95dac429a8@iscas.ac.cn>
References: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
In-Reply-To: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>, Longbin Li <looong.bin@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowABHtD5A+atqNnqCCA--.4692S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF48XrWkWw4UArykZF4fZrb_yoW5GF48pa
	n5urW3CaySgrnYyay3tFyFgr43JrW8u3W7Kr1rC34UJw4kZayDt3y7Xw13Jr17Za1Yq393
	Wrn5G3s5Gr1aqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRRyxRDUUUU
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiDAQNDGqr9nAGugAAsy

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

