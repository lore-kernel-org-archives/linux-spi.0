Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937AD5187EB;
	Wed, 30 Sep 2026 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792611; cv=none; b=ntiFiy0nSvtawYX+icxHuo373lrWm6K9mkMMddD062uJx3uFuDhUR3T3AtCUt1WcIJtZMJ+K4t95tUrErE1qATRYvcrIh+oattEP3/QUHhphZXfG0rGK9S5jsoBdMrdTXkd6nKCdUsvWSWH70rUtrBbTjTua2Rm5sRg+YQ+GIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792611; c=relaxed/simple;
	bh=MAoTJpfR9sQ+sH6Mer8E0bQLsExiA9OmKfJdD4rVNUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hhBPepeNLC1NVnADe64duemAIftzoIAqhhbSn24XF1VMFkEk+UIFJePWgzWghxR/Zu8sFyrju/vARdiwhUWRiSnp0u/OdJJM5pHQlTXKBlULVY1k5CGUIxUJOiHPYLmVp8w2bKVA1ilTO8Wc+sSTY2H7s/A6vMt1NEIhZszsAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-01 (Coremail) with SMTP id qwCowAAHofR9U71q8y58CQ--.14027S2;
	Thu, 01 Oct 2026 02:23:02 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH v2 0/4] spi: sophgo: Fix SPI NOR errors and clock limits
Date: Thu, 01 Oct 2026 02:22:49 +0800
Message-Id: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHlTvWoC/3WMQQ6CMBBFr0JmbUk7AWxdeQ/Dok4rzAZIxzQY0
 rtb2bt8P/+9AyQmjgK35oAUMwuvSwW8NECzX6aoOFQG1DhoZ67qxbuSCXW3y8Yq+IB2cGifhqA
 6W4r1cPYeY+WZ5b2mz5nP5rf+K2WjtOrJ9cFTh87bOwt5aT21tMBYSvkCO/ZeBqwAAAA=
X-Change-ID: 20260917-fix-sg204xspi-dad286928b1c
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
X-CM-TRANSID:qwCowAAHofR9U71q8y58CQ--.14027S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xGF4DKFW3WrWkur17Wrg_yoW8WF4UpF
	4xAanxtw1xGryfAaySqrW2gF93Gr95GF1UJr13Ww4rZwsFvry8WryIkr4IgF9rXr48J348
	KrZxJFyrCrnFvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiCRQGDGq9GDh2-QAAsr

The SG204x SPI NOR driver ignores transfer errors and clock limits.
Fix both, enable SPI NOR on SRD3-10, and use 12.5 MHz on SRD3-10 and
SG2042 to match EDK2 and the vendor kernel, respectively.

Tested on SRD3-12 at 12.5 MHz: both flashes identify correctly, SFDP
reads succeed, and two full 64 MiB reads per flash match.

The SRD3-10 patch supersedes the earlier submission [1]. Please disregard
that version, which used a 133 MHz flash clock limit.

[1] https://lore.kernel.org/all/20260902-sg2044-dts-v1-1-aa1fd1a4ec0d@iscas.ac.cn/

Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
Changes in v2:
- Advertise the controller maximum speed and use the fastest divider when
  the optional maximum speed is omitted (Mark Brown).
- Rebase onto Linux v7.3-rc5.
- Link to v1: https://lore.kernel.org/r/20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn

---
Han Gao (3):
      spi: sg2044-nor: Return transfer errors
      spi: sg2044-nor: Honor SPI clock limits
      riscv: dts: sophgo: Limit SG2042 SPI NOR to 12.5 MHz

Hangfan Li (1):
      riscv: dts: sophgo: Enable SPI NOR on SRD3-10

 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts       |  4 +-
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts       |  2 +-
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |  4 +-
 .../boot/dts/sophgo/sg2044-sophgo-srd3-10.dts      | 24 ++++++++++
 drivers/spi/spi-sg2044-nor.c                       | 56 ++++++++++++++++++----
 5 files changed, 77 insertions(+), 13 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260917-fix-sg204xspi-dad286928b1c

Best regards,
-- 
Han Gao <gaohan@iscas.ac.cn>

