Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427129;
	b=WmsRRkDvUuc53gkRYKrQ4W0l1dJMVhAUwGMXaUKILfAUaimfASPE4K9At46z6aYHWIJp
	 un0Ut4fWmiFxrqChj/c1XG0TATaBS+ra0XvcfcBNuIBuLTZZEXs0AaOMBb0SWBJ6skK9G
	 YQV9K59A+L+6PTT7SFI96wZiZJtJ7iEvadcj3W2j4toh89+wALbu7S/og1DLyj5PAyuI3
	 OPo/H0uYamwWrHegucl0H8cQez8Dij6IC9IuQ0dRB03eu4aJOZmF8eRUMGUCSouF3Q00l
	 XCAbePNpZmyQ2f8yblvuBmRPu/N83qhvlLXWP2Rjezhjc71es3a8HgMlxuhLvbhqugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427129;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=y3UYMDoE62FnPRMaab0//uR3dPofijPadlX41Yz+0ZA=;
	b=rc6sAd4RI58+A/1DB29DyoNMuMCXpubWdKbfRFodTzhvG6Q6Dp6LhksnwnIaR/zxf+Bh
	 D1cAY5iDMZcwvgZWlvAFUqapMm5y0f9Y/UJkSDCjDyMIuWAjX67IBhIjn8WtANYmuV5Fn
	 yqonzVmLclRhLpQ5jMrBdUQZlg8eGKsRWWCeLaihiFcF+r/rvK0FZdBR1FopG1WY3fbPT
	 XKa4MTfh+gBrvrBott3m3oUW2wl7RJBRg81rGm1ZiLtGk77eTIMkKEkpU05tHbDVvk38P
	 vyMXeaWq6pFGy5GRMkzy9dekNf4vdUTLtF2Adghj3iKLiGSWRMmjCx0me53f3wavx6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B86606A32C;
	Mon, 23 Nov 2026 09:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8B86606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8Bxd7U3CwRrMTEiAA--.4000S3;
	Mon, 23 Nov 2026 17:45:27 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJCxPs80CwRrgNo2AA--.43474S3;
	Mon, 23 Nov 2026 17:45:27 +0800 (CST)
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
Subject: [PATCH 5/5] MAINTAINERS: Add myself as Loongson SPI maintainer
Date: Mon, 23 Nov 2026 17:45:17 +0800
Message-ID: <8612d33a00246e3049e4cb849ef303bb93622bb6.1795425389.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJCxPs80CwRrgNo2AA--.43474S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEACGsDnvwLCwAAsC
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr4UAw17GF1DGr47Gw4fCrX_yoW3GFb_A3
	Wxta1xWr1kAr17C3y8ZFn2vryaqayxC3WfC3ZrtwsrAa4Dtwn8tryqywnrG3WxCrZ8ur13
	ua17GryxurWxXosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb2kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

Add myself as a maintainer for the Loongson SPI driver. I have been
working on the Loongson SPI flash and SPI IO controller drivers and
would like to help review and maintain them.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70789ce6e507..8223f1b61348 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15738,6 +15738,7 @@ F:	include/dt-bindings/clock/loongson,ls2k-clk.h
 
 LOONGSON SPI DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
-- 
2.52.0

