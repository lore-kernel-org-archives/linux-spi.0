Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9514AF9E9;
	Mon,  5 Oct 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214663; cv=none; b=BgpKBqqP4N7WAB1KKHOsXkBdWqmUmiYsGjU8CdgPgxIvvmjpnvr5C/mvsotKg5GwF2vLG1Tiw8JRp93hp/QAajX8v15MXjNDZAvqvKREgzi0AwgoinIQB1gP6RKXiHRJ3ln3kSYhk48pKghNOVD/8xuPc2vOOmv3KVIC90SXDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214663; c=relaxed/simple;
	bh=Ri7OISMqDdfTVywpOfKiONnQAm0l4vxnF6psraa8U/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/NNIjCe5HST2xO0akQEYQlnY9e7iJWCFQOCDGcnxJjBECSysTwTG41a2jrluJRo78OU8KKF9nJSlAlFfU4QYNA+qmiFqCoqW6/yqS5/dXa6mk3B9d+BcTGYMc5jPcR/JoGmGyQKE+wt/5JpJj3g0oxrIFQobJC2vFL5Nxu5Z94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrO4pDHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrO4pDHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE8B1F00898;
	Mon,  5 Oct 2026 15:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214660;
	bh=E3TIrWcFn0saJdshzenrg1yxPW2LRolj3QcvShl9LR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrO4pDHPmp1ZcJkiLya5wFc9D14jhH5HLtBh+HutLJ4FyQ6A1hUmhrqxOjUp5Xad3
	 RnlYJqQYt0HwX6f9JcCzNyMaC4jJyYA9n+tURml134kIV+elRmUPWQNaNcAQZtVNDF
	 gtCYmddrXXicUw9uvnCgM2epv8PiwaokvkLtSPnc8Z75mi69J6i9ZHYheXI2UukSl5
	 tfzJw9M7/8VRqXlhrUEMLSTgddj/kAGph9sQ3sUg37ryeYMwt42jlDZOBEvj12VALD
	 q4fPtKUKJnbP0HS1eP8UFZDrmsHGmjOIHriS4f/A/WjErw/hfYhRaobTVNn3kk60wv
	 HaFxOKd77lOzQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] spi: dw: remove useless dws->transfer_handler check
Date: Mon,  5 Oct 2026 23:17:36 +0800
Message-ID: <20261005151739.25233-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261005151739.25233-1-jszhang@kernel.org>
References: <20261005151739.25233-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

transfer_handler is initialized before any DW SPI interrupt is
unmasked. While the IRQ is registered but the handler is NULL,
dw_spi_hw_init() has all DW SPI interrupts disabled. Therefore
dw_spi_irq() cannot observe a DW SPI interrupt with a NULL
transfer_handler.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 1f0e93800908..f5a80105ceeb 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -280,8 +280,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 	if (!irq_status)
 		return IRQ_NONE;
 
-	if (!dws->transfer_handler ||
-	    (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler)) {
+	if (!ctlr->cur_msg && dws->transfer_handler == dw_spi_transfer_handler) {
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-- 
2.53.0

