Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B993009D4;
	Mon, 26 Jan 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449856; cv=none; b=ToAkc2TGZMIBl8Q7qU3m1LFwi6svIRR7KS2WZ9W8BsU/L7QbrjInHaEq0dreftGbvT4dpCka2i2wxt24awCQ2D8YiZrGsPsVG3+3aIwU+Cs6mEy/23cFien9o3mOgxlXxbxrq5hfmZShuoJ48AZHieBKCr2vBKyPEF9L+VlVwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449856; c=relaxed/simple;
	bh=u8osWnqm4Fzbf1671rwr9CIaGAGYnZg18KtK6a+DeD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOXXd0oHIB/2Y3udVuC1LUF1RnKt4vKzb+cH9mkTPv/3187E19EtZWitUZf1myylxbw75T1MDn7p9sZKIHMvyrLNK/bAgccRDcbSPWrTDfcKdFoX3YjE1LclSzHUFS7ti9xsVQO1s0GNxvcTBsyH/t5DCdATJjZGDk267xruy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eN05+p7N; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eN05+p7N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=HiQ/X63XB//SaCYFumcRm/UIBGFzLcRj6KzHW1F1Jow=; b=eN05+p7NnI7Xwf8v4/cg1TiN/7
	Gbn08yJ/nQnY8At43elh2s6dqzgsEkILymVkTy/4hwE/U9ctw1ki0ITNlms5ZTknTp71SvrttCfAz
	liLcuQc2dnUTGrgt7NZwNVnOs70+gUlccZqqs6ZbCXal9SRvMFJi/0VFtyeAGc+1GKAeHA53DT8Vu
	vuNHCPYmN4GKll0jMjJWM1UZ+LmJT6oZL3UzKyXFU8pNZl+ii4Zpy+qd5upXYRIpZ8uutCiMY8P2K
	dRC2ZKWiNHMUVyxiZCFRKQU/SFWSlanbdUuCuPkYoTE+7JEkfJz0iazJkJN22Ga53n+h9xulG22KB
	HGpQme6w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkQji-00GLZ9-39; Mon, 26 Jan 2026 17:50:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 09:50:26 -0800
Subject: [PATCH v2 1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout
 already processed transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-tegra_xfer-v2-1-6d2115e4f387@debian.org>
References: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
In-Reply-To: <20260126-tegra_xfer-v2-0-6d2115e4f387@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, soto@nvidia.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=leitao@debian.org;
 h=from:subject:message-id; bh=u8osWnqm4Fzbf1671rwr9CIaGAGYnZg18KtK6a+DeD4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd6lvRJG84VHkqhFRCNeoUDT9DFSZ4N2VcriGG
 lZXZmpXgICJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXepbwAKCRA1o5Of/Hh3
 bTF5D/99KGc9bLfLDzqU5Y6QN1IBDxP4S+a2zgf8le9q5JpD4dZ1/fKLad+y8r4Pu+Eiz/GN9kw
 mn8emwWpHbBq22HQFkHjc/cbmF4tRaD1wtzvfLMDiJZGtjWPTZ2U0QnrtOfPK9M0qggfZFFUD6K
 KU0cwhYVo54dobIwz+uJcUxbn1+as3VKgkWQW5cZMg16ob+56JHqMe05rNkpSF5U9EVU+ammBWj
 wgDjJMHlFY+NBsHr6byMrQQhEF5ZsyHTID4DLInc3eHJStyoeqMDfD2nLczg3QRF43lHJtL3/5X
 cE0yMktVr7TN5GTLWFLokdFmgccCn812aL2raZoYCeQPMwaBYnUJAkGhV7927ohvgyGEItwMzbE
 gkEkIGZlJkbhgKysv7nizEkn/UFCNzVT/yGfIUvcFT0nM1+JWU5fS0E7//+MX9rjZLLSGQ5vebE
 Ebkskk9nAa6PHmPdFAAjNYxN2qckwXfePH0bfJu9wwqiDPUhjVUQjgDHdG8Odyed1oarnK8hLqV
 RPzt+WC7R1dfDNAF4qfuzPgAKXULyn9cyd7WacuJEr4d0xvTVlae88zDwp2F9bWUtFpXZ/AC6oD
 6cCfRmEC+CkUiH1mRYqGgyyXHPm5gkla0uLxCu+61g/jAJyKMMFJbzRUT8EFAn3Yit4yrzU3Mbj
 JqXclJ508ocinsw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

When the ISR thread wakes up late and finds that the timeout handler
has already processed the transfer (curr_xfer is NULL), return
IRQ_HANDLED instead of IRQ_NONE.

Use a similar approach to tegra_qspi_handle_timeout() by reading
QSPI_TRANS_STATUS and checking the QSPI_RDY bit to determine if the
hardware actually completed the transfer. If QSPI_RDY is set, the
interrupt was legitimate and triggered by real hardware activity.
The fact that the timeout path handled it first doesn't make it
spurious. Returning IRQ_NONE incorrectly suggests the interrupt
wasn't for this device, which can cause issues with shared interrupt
lines and interrupt accounting.

Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index cdc3cb7c01f9b..f0408c0b4b981 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1552,15 +1552,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
+	u32 status;
+
+	/*
+	 * Read transfer status to check if interrupt was triggered by transfer
+	 * completion
+	 */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
 
 	/*
 	 * Occasionally the IRQ thread takes a long time to wake up (usually
 	 * when the CPU that it's running on is excessively busy) and we have
 	 * already reached the timeout before and cleaned up the timed out
 	 * transfer. Avoid any processing in that case and bail out early.
+	 *
+	 * If no transfer is in progress, check if this was a real interrupt
+	 * that the timeout handler already processed, or a spurious one.
 	 */
-	if (!tqspi->curr_xfer)
-		return IRQ_NONE;
+	if (!tqspi->curr_xfer) {
+		/* Spurious interrupt - transfer not ready */
+		if (!(status & QSPI_RDY))
+			return IRQ_NONE;
+		/* Real interrupt, already handled by timeout path */
+		return IRQ_HANDLED;
+	}
 
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 

-- 
2.47.3

