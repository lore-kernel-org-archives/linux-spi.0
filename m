Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D891DDC33;
	Mon,  6 Jul 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783308813; cv=none; b=Y8w8ZGjhajEoMKTtBC/1MDMcms3PqrWT1ceBajwp8joi1fTnAa/RpbfO1xm/lzwxFJ8fb7+ZCJpeScjaFgpgrGD6tc+OwOD5agP17TS4or4ac0jM5ckFEVb1nVzePBcl+99GciW+oYBUEqGJ+tQX62SMJqfUsSHAUa4t3TVGxKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783308813; c=relaxed/simple;
	bh=FKmMdN17Jx0VF2soxt6ZB7Ht9zbYjXZTnGKZxNKY+7w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XAPaZz90/FI2XJwTQYP4BNj6it3PLilzsksJSDAkqCP4XdfpPb5RHIRr/WVtpfgdQfXwJ6JrOtLboMwlF1YHRJqQre/hAwqjbn0BLZQebojdVmgFkXy5SZ1Qlully+PSqw4HwxxR68i6K+hJdr9iZeHF63skgHukjGB5/pGeXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rjSo9nIW; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rjSo9nIW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783308802; bh=bioJpcP2GTM8ZX+6dHtVbF8kRkNnyExRdTo/AMIysWg=;
	h=From:To:Cc:Subject:Date;
	b=rjSo9nIW+p9V5mkcCRdHXOkcSOCYJz+xcCzOfna6PiiZm80jB4AkY8eXfiS0aKZJu
	 JPE3aaBQTJLcVtni9OSyz68BiGvULGmDOisRsIB7Y6C+reJREuYpNPYnDlmurfjLsY
	 1+A+ekavAIf4hzfl9utnDAjINZSE0Fnr7UuQoK4I=
Received: from wayne.localdomain ([183.16.130.95])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 8540F2BE; Mon, 06 Jul 2026 11:33:20 +0800
X-QQ-mid: xmsmtpt1783308800t9nyyiyxh
Message-ID: <tencent_4EA7B5C94669ED4C38A5F6C1C9126E5D9106@qq.com>
X-QQ-XMAILINFO: MgApn56nkUA5uuIR0lmop0dMPU3MTHWs86Tw3VpY3q8R21+YnGSvSFtkKU0Gp/
	 1UtsQtBlSu8PInF/kD6gAredI7ChBs6QuZVxBQcvyxOoT5+tFFprTTCf9MFZWMKlxeaAcyYf6b1B
	 xj5U7bHhkbH7allgcr7phu6bDBwzsagByUXn8VjkTxfVvpASI0jiw0gMw7HpChrCYwdgYeeYYbe6
	 nds3bcVn+kCkPxgy9ch/6cBNXH4Y9kf+lSTGgew7IP8OIkr+Bexzgv1zFSxXThfrFWG4YMe+B7ih
	 dgU9N7PufkteV+cBRnYUVn0mbqvN0zb2Fr92gP1VB7Rge6W0LT4lUluOUIoS44NHI+IcYM5vGShk
	 3+waSP5b3Sxsx+kR4R2yXeRlwJ/OWPgFwtMPXLoLDKP3tDra1Jsm6F4joeGvzsH6qMXmkAnHe82n
	 IetmAlQhAPchVG/H6aux+1nX5qZCsAlZWLIyHCFJLXE8XfTXYyVqZoBSFHEtGJumDgHauq9xdvrZ
	 661yOukr+iYHWVQYNHlIFr+/pZdskYVqFJ0oGLjfgfYv0USWbk9PMF5cZv3fPKUGmSYm0OXood44
	 FTbyXr52NQ4p1XRsS+LZaRSF5Sz+67fQB+QA8/cuazCNrec1ICgXp3LrdMtCht13N4fjf6wA8fV3
	 BoFkYPekldoheOq1N6RBgFuplldCClPHBnvPAXPEMXwxzUyXKnFHpm63AS3YWD1BddBgpmEGtxIX
	 j8/tfxYlcpSNAV/AD9QG8veEPt1wPEAkr/wEmHc5aPiJ9HQpOIS3+dyM3lg4CMEIbN6THP8H+sif
	 wLrOe5q+WVn79Kn8lpObjojHjCuN/R/FdGgVGCdiPO0EpRWFxwBlYsXm21Vu6TDNlIWw/p7W22YG
	 gl5O5JrGSk1KpzOPJIdm//Zs3HD4l7kJ+6bm+g14+2jtKk4RtHIMXgScSI4yy63oWq+oDr6V8seF
	 Nh1Nygh+huKvL4c7lg52H/aub9AlRahTGHDxKaxn+JPeDrgKdrSfyZnrs/9n3kBXpBe4noI67OCo
	 gEjc9Yj5dv8O2KW6HCM0gkSL3Y28owsS1wm4OV2yB7X37H7DZqdg1T7uYriPw01HOTVW3VlA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Wang YuWei <1973615295@qq.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang YuWei <1973615295@qq.com>
Subject: [PATCH] spi: dw-dma: Wait for controller idle before completing Tx
Date: Mon,  6 Jul 2026 11:33:13 +0800
X-OQ-MSGID: <20260706033313.1528757-1-1973615295@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw_spi_dma_wait_tx_done() polls dw_spi_dma_tx_busy(), which only checks
DW_SPI_SR_TF_EMPT. An empty TX FIFO merely means the last data word has
been moved into the shift register; the transfer is not complete on the
bus until DW_SPI_SR_BUSY is also cleared. As a result the wait can
return while the controller is still shifting out the final word.

Any caller that tears down or reconfigures the controller right after
the transfer can then lose the tail of the transfer.

The memory-operation path in spi-dw-core.c already waits for both
DW_SPI_SR_BUSY == 0 and DW_SPI_SR_TF_EMPT == 1. Use the same completion
condition in the DMA path so the transfer is guaranteed to be finished
on the bus before the wait returns.

Signed-off-by: Wang YuWei <1973615295@qq.com>
---
 drivers/spi/spi-dw-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index bd70a7ed8067..f7d848fec9ab 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -282,7 +282,8 @@ static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 
 static inline bool dw_spi_dma_tx_busy(struct dw_spi *dws)
 {
-	return !(dw_readl(dws, DW_SPI_SR) & DW_SPI_SR_TF_EMPT);
+	return (dw_readl(dws, DW_SPI_SR) &
+		(DW_SPI_SR_BUSY | DW_SPI_SR_TF_EMPT)) != DW_SPI_SR_TF_EMPT;
 }
 
 static int dw_spi_dma_wait_tx_done(struct dw_spi *dws,
-- 
2.34.1

