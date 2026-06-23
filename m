Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D037F75B;
	Tue, 23 Jun 2026 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223126; cv=none; b=YPrHdif14SO/XM9RcgluXKnAIUA+NMWAKtNJdem1jNtdjqM9Q0Cs5ebq5j6GuVuOPJzpAjdobpWFoSi8121bnI9gx+/3UYDog3sgMTMVw4nQ07WcpXn6UhLYr1yG2mGKHTgQdwauvfyEi5MfunBeG9umMhyW4gpQKczr+NBxJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223126; c=relaxed/simple;
	bh=FerDE/PLUv23gL0JeRb+OcxAUFlWtwBFRWFfaba3e3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/BFgYvmuWcxjq/Nh6oT/okNBH6MytFjGRcsE80f0su24/d/tIBkRPKp58IWGY2BYLOGOgQJ1Us9Zo97p6qUK1Zc/iSXUu5AFcAfuaQkHeuTMj896wtFQuvI5MAfmcI/hjjTE7BgvtJbNtDxs43iEUIjuRSx2n4pvGgAc1Ox6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3RMgKkTpq4kTYFA--.16237S2;
	Tue, 23 Jun 2026 21:58:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Mark Brown <broonie@kernel.org>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sh-msiof: abort transfers when reset times out
Date: Tue, 23 Jun 2026 21:58:34 +0800
Message-ID: <20260623135834.55442-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3RMgKkTpq4kTYFA--.16237S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy7Cr43GF4xtr13XF13Arb_yoW8CrWDpF
	48ur1UZwsYyr4qkF4xAw4Uu3WYyF93K3ykG34xJws3Aa98X3yqvF1jkF18KF15tF48G345
	Za1jyFZ3ua45ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjZNVP
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

sh_msiof_spi_reset_regs() asserts TX/RX reset and polls until the reset
bits clear, but the poll result is ignored. sh_msiof_transfer_one() can
therefore continue programming a transfer after the controller did not
leave reset.

Return the reset poll result from the helper and abort the transfer on
timeout, matching the existing transfer path's error-return style.

Fixes: fedd6940682a ("spi: sh-msiof: Add reset of registers before starting transfer")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/spi/spi-sh-msiof.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index f23db85a1..1aeab7ec0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -114,7 +114,7 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void sh_msiof_spi_reset_regs(struct sh_msiof_spi_priv *p)
+static int sh_msiof_spi_reset_regs(struct sh_msiof_spi_priv *p)
 {
 	u32 mask = SICTR_TXRST | SICTR_RXRST;
 	u32 data;
@@ -123,8 +123,8 @@ static void sh_msiof_spi_reset_regs(struct sh_msiof_spi_priv *p)
 	data |= mask;
 	sh_msiof_write(p, SICTR, data);
 
-	readl_poll_timeout_atomic(p->mapbase + SICTR, data, !(data & mask), 1,
-				  100);
+	return readl_poll_timeout_atomic(p->mapbase + SICTR, data,
+					 !(data & mask), 1, 100);
 }
 
 static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
@@ -834,7 +834,9 @@ static int sh_msiof_transfer_one(struct spi_controller *ctlr,
 	int ret;
 
 	/* reset registers */
-	sh_msiof_spi_reset_regs(p);
+	ret = sh_msiof_spi_reset_regs(p);
+	if (ret)
+		return ret;
 
 	/* setup clocks (clock already enabled in chipselect()) */
 	if (!spi_controller_is_target(p->ctlr))
-- 
2.50.1 (Apple Git-155)

