Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78385947FD;
	Thu, 17 Sep 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655384; cv=none; b=Q1LzfGSYxUOIQ5j/ZH/8K1FSzRqFDrQKuXwe12gDyM7FNrFoVLinwZrM0X5gc9hxg/Jv/grUkdzmI+oHUGkG59/15QMPhav/Opi4ALehIR7j0HLPgG0+2NuwUfwV5YOpQ6tVBmwoi9HxPW1TxQiXNH7OwhBJsQLRCB6zKd4Vris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655384; c=relaxed/simple;
	bh=pqi4GC9Nj6hhPcqPXeWCSwqxD+5oWHRCT236VBj+1vk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JTYxoBOHCTpVhxGhyG3xRTHOBVpJt2GRwhFSC1U+gE9wPiLI3Bggy6u4bsrscKxkoG3fFjLg/H55UJV0y2W9RcuJBPoqux6qBn09IewyZiySMZ+ra74UDMBSnc4msjmwv4fydYDdYuu4x3E9tDYTtEZ2ki9a2g5G/Bbt54/MB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.1.1] (unknown [223.166.93.127])
	by APP-05 (Coremail) with SMTP id zQCowABHtD5A+atqNnqCCA--.4692S2;
	Thu, 17 Sep 2026 22:29:25 +0800 (CST)
From: Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 0/4] spi: sophgo: Fix SPI NOR errors and clock limits
Date: Thu, 17 Sep 2026 22:29:18 +0800
Message-Id: <20260917-fix-sg204xspi-v1-0-5c95dac429a8@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD75q2oC/x2MQQqAIBAAvxJ7TtAlKvtKdDDdai8mLoQg/T3pO
 DAzFYQyk8DSVcj0sPAdG5i+A3+5eJLi0BhQ46itmdTBRcmJeiiSWAUXcB4tzrvx0JqUqQn/b93
 e9wMVhb6AXwAAAA==
X-Change-ID: 20260917-fix-sg204xspi-dad286928b1c
To: Mark Brown <broonie@kernel.org>, Longbin Li <looong.bin@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Han Gao <gaohan@iscas.ac.cn>, Hangfan Li <lihangfan@iscas.ac.cn>
X-Mailer: b4 0.14.2
X-CM-TRANSID:zQCowABHtD5A+atqNnqCCA--.4692S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xGF4DKFW3WrWkur17Wrg_yoW8Gr43pF
	4xCanxtr1xGFyfAaySq3yIgF93Gr95GFW5Gr13Ww4ruw4qvryxGr92kF1xWF9rXr4rJ34v
	krnxJFyrGw42vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRiSdgUUUUU=
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiDAMNDGqr9nAGrAAAsj

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
 drivers/spi/spi-sg2044-nor.c                       | 52 ++++++++++++++++++----
 5 files changed, 73 insertions(+), 13 deletions(-)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260917-fix-sg204xspi-dad286928b1c

Best regards,
-- 
Han Gao <gaohan@iscas.ac.cn>

