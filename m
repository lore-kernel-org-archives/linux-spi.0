Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CD563FBD;
	Wed,  9 Sep 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965805; cv=none; b=spFb1nLw1tyYsJdM+ys24jmJCKk0mXuk7LZ3IDeaMIl7M/Bby9oNQNEWt6k57XiVHSx6yo5RCmWfPn7yhnSwD9Uj704gjWXl9HQ05l//YXsOLLmPJiJ8gjYCUyDmfxExcBq5pY/i1/pDpWu+NFHd9vzqlVixGi5wwX2w2avPZVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965805; c=relaxed/simple;
	bh=KFTyLKUyX4zP8QpdqjlR7ZkyMKM4k7B/cpIbOdWCqCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6CzVnVDboRnehMz7Fvg5KPAKnAGQiPq5/sKIiNguJjCCPN4eCzBas5r56Kczr+8WAIrcZ/kZHfetEIb1MBN3xEx2MTtbRENd0xZ7lqstgkYlXE78NmTEXyJUKxSurmCtdXZbAuvr9UnkWsB4A0O6BablAgODbWFzMB6FsEK3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwZuxalJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwZuxalJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818831F00A3A;
	Wed,  9 Sep 2026 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965804;
	bh=neytlIQXdUaSH2YGaKdqCIIZLNyrglaw5V1+1H8MeMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwZuxalJOizp6Rwky6Uq1LIhAyZFma2S9Kd2qprue/tsdbnJjNpBGWoZW97Hd9lb6
	 niD3hTtJXRsZyfzLYimoac1G7ub1y29xFqepS0Gn6TImOi43bH7xzx/ZrubpukFvxq
	 LTB7Z1o4kak8wX0l/d6yQLqfOgeehsvzbqCQ2MdRF5tfSv4Ov2a0SH0ZfVhtHgQYEh
	 8WIhlVMyF8wO+KtoEucN7u6wQK+1m2hm8ccHGTo/8WGAFERKifvuJwLDd3MoMuD8cY
	 nMJPrtGw+JblBHVBRId0Cjg5K+Z/KFv8kZuWMLqL1T9Fuiml83MT+U7rV00Ur127/2
	 KvP2lc0v4/EEw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
Date: Wed,  9 Sep 2026 22:36:50 +0800
Message-ID: <20260909143652.9234-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260909143652.9234-1-jszhang@kernel.org>
References: <20260909143652.9234-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw_spi_irq() need not handle enhanced-transfer's "!rx_len && !tx_len"
case as that state is already handled by dw_spi_enh_handler()

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index f4c4e9dae25e..91de357f97f3 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -284,12 +284,6 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-	if (dws->transfer_handler == dw_spi_enh_handler &&
-	    !dws->rx_len && !dws->tx_len) {
-		dw_spi_mask_intr(dws, 0xff);
-		spi_finalize_current_transfer(ctlr);
-		return IRQ_HANDLED;
-	}
 
 	return dws->transfer_handler(dws);
 }
-- 
2.53.0

