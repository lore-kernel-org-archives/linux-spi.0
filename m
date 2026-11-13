Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548566;
	b=Fio81I3r33lnP/EZ7HA6s64xNx7kNa0V1KxMW/ncw7iIhYBQ1JLzt5hqqesxXOcHrZvX
	 izMKxZ9w/j2MmgvKmtzANRt90xpnNasOXnk8CV9OrssQRutczRdOongCFNrHejODB3sm9
	 Gsc2fjasc4CsMwGwtlMUoqpgTEqeU8q3yTqm+UPRuJ2qLRwTNj2lFYUnl9vqFkjQFnmNu
	 9xBtERryUipZgi8h75F0W2P02tB6II/0lnRJx91MYNgR8B83ecD/ggrQEl6WadIfoJ0xw
	 6AkjxuQOv5PMUw1+VQkz1gXCbjSEUBio2Hr0zkjO4csGNrSWSfPNqkcMycrtXL98EFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548566;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=hpfwxkMNlo+7YincGJQVuDLj3jP1gmXE6ucfT+jTToU=;
	b=EsXXPby69yNjrmx0TiCQNQgNJUxNqOa9wAsjaS38Y3MzvDOe2FX5v46F3EVnQfSEcN7D
	 mYSNBog7AMjOl8N5EdoPRXbEq/T7P0DrMZ7Zg221IS+ME/OjOLUuWkwa7ixb9M8UHKxDU
	 6uLamFOfEvvzd+abwtE1XnhZbrJzJBtCZvdZqIfoaXqPBQRQFMb40n5e5IWpDR6b7yDAA
	 hdTz1H51bAm47cRQvZQgX9H6Mtx5xylIvjVdLGpSe027hXjEwp/lj5Cr0WqitrnIBe2xt
	 oMkfKDIJRT3ItDw5WfubGRk8spGACk2Q9bwDoTHVvVmHa/Iugk0B/in3kK4HW64Ii3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1555606A323
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1555606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8Bxn9FMo_ZqxB4fAA--.23424S3;
	Fri, 13 Nov 2026 13:42:36 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAx3c5Ho_ZqLSg0AA--.40410S4;
	Fri, 13 Nov 2026 13:42:36 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Mark Brown <broonie@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-spi@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 2/7] spi: loongson: Drop redundant CS deassert in setup()
Date: Fri, 13 Nov 2026 13:42:23 +0800
Message-ID: <b64464fbd2cfef301b83a7a36e30a6aecdc12307.1794538736.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1794538736.git.zhoubinbin@loongson.cn>
References: <cover.1794538736.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3c5Ho_ZqLSg0AA--.40410S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEKCGr2f-4BuAAAsl
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF1ruFW8Jr48Cw1Dtw4DWrX_yoWDXrg_ua
	yIvr1xGw4rCr47Ga4UW3WrZF9FvFW5Xa4F9Fn7KrWfXw15tr15Zrn5AFnrGa47Zr45Ar15
	ur4fWw4xAryxCosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

loongson_spi_setup() calls loongson_spi_set_cs(spi, true) to idle the
chip select, but set_cs() receives the physical pin level after the
core applied SPI_CS_HIGH, so true asserts an active-high device.
The core also calls spi_set_cs(spi, false, true) after ->setup()
returns, making the manual call both wrong and redundant.

Remove the manual call.

Fixes: 6c7a864007b6 ("spi: loongson: add bus driver for the loongson spi controller")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index e95a9af94772..bd4289022519 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -99,7 +99,6 @@ static int loongson_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 
 	loongson_spi->hz = 0;
-	loongson_spi_set_cs(spi, true);
 
 	return 0;
 }
-- 
2.52.0

