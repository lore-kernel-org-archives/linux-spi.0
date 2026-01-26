Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D342356D9;
	Mon, 26 Jan 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449860; cv=none; b=Q49Q1BlqJUocaXsaolVmq3OnvFP2j8lUAXGJyuLkuQ53ryikT7r46geElJltBD5GLc5+9pHUfxbAB1lpJWPxLExGLjqE9+wCOkBUTFKze2rmNSCS5PXltrSAj4INQklYMj8OIOpO9ZdnoJxOYSKyfGpfYjAB8tnlevx1O6oZsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449860; c=relaxed/simple;
	bh=jhglVcCYKNk1yxuXd4lmljJAcYgPjLfokj86rWqQZXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hlvay0JlZNyt14pDisDsSr/PBgLnKtcTeOIAioJ6hCYa/jUyaXlhwXPwa7u1jNaJrUwXW1Ecr0zJ6doejeMfV4UQRYo6xbIJzoFJn/Y8UGO7uuhG8eoWWLZwytzAEglL4YwiQ7fEpZxkSAaYxls2Pz4opzfQfhmUmSv9uIRipHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=m5bGaF4Y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="m5bGaF4Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=KlzDJdzqhY36z/fITAC1mxUSIs0bgWkuhmstoha/ZOg=; b=m5bGaF4Y/70hlWvHvdRh1mFyVb
	PzGhFApBAPekp8VOSSZPu+Pqb4+O1/5Yt27xMCu75x/hVMw51E8uK3rKiydqZemauJVF8DY2MqxzR
	pHT8todRoiK8Z96doiIUs+GMEyDy5gV7HuvklB5VlRe7LUwYN2FPz9azADBrLKPeQIcTF3ZmdYsPH
	sRR/Ea7OUDQOncmXR9iej4cbtk57J7yQs8y/g5MgWmVBguFNcUwO2311kgnx5Iwhg2qyYPOXnVacZ
	XEQ4zpgQT9jEWpJAQncw9A07ML0GK1nAMjjavxdCCQ74leKJNaUQ9hFWDifApFI3WGVmnA3LgGcsQ
	0EZDTttA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkQjm-00GLZH-KU; Mon, 26 Jan 2026 17:50:54 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 09:50:27 -0800
Subject: [PATCH v2 2/6] spi: tegra210-quad: Move curr_xfer read inside
 spinlock
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-tegra_xfer-v2-2-6d2115e4f387@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=leitao@debian.org;
 h=from:subject:message-id; bh=jhglVcCYKNk1yxuXd4lmljJAcYgPjLfokj86rWqQZXg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd6lvAd2TE5CEr+p+wM4p86h6527QDFlAkLeBo
 tvzAFaHZXSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXepbwAKCRA1o5Of/Hh3
 bdEtD/9SIUrlc+GG7KEEmOf2yLvKkQzbm7YA04bL+sUdaL+vVRhyd/BASfE1Rj1OydlnR3m4LSx
 o0qPZIaZ9vOvW6bPRLIFlB9eiffKjz22ll6KqIcgIA9Omybc+bF9xcVAZC0+LBnN595Ez3HDujx
 ZBx/7clH/78QRzqe1qzoYxtbw0fwcKt06T5T/1p1mnF42sASLb7uj/ADDurIMpE9HfKtepZVR6N
 KUEGX1h/a2W5fvG+4YmjTDtia1nd3nr5kdYU32irRouuxhX1QSQYTMkeXP9aEbR7uKwGeb7LZ5C
 XJ+nFrAyx3uB9btcaTgu58T05dPAWhDRIxOtoefd0yTNHFl/cIXg6d5XMrm+4tFI2K5h+ycnbM1
 TN8S7a7TdFkRTUQAuZT64XIzEIyPrDzpNq0MdxvOL+fo7ykpB44Q0WkfF9FDN2WrMjB3k5oESYI
 I5G6vTygWAc8s7ySeFng4TjBAHEbDZCC3SKeaCdrwMTzDk9DrNJGKJpTqMFv369sSxXwyk1ADVc
 sWRghxJ33rrGpZ6bF9XLGbpb2giESMVhQx3L67nXoLAy4EKXWujK3nG1utxR8lAnJqHoJxfz2p7
 CO7EFcVtOnI2VcwXcvoUJKbm46VAQkq2RndqlGUHo15srSDzMVBVqct9jMnj0FooX9fE8VOn8Bh
 ShVLduj+5/lhb0A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Move the assignment of the transfer pointer from curr_xfer inside the
spinlock critical section in both handle_cpu_based_xfer() and
handle_dma_based_xfer().

Previously, curr_xfer was read before acquiring the lock, creating a
window where the timeout path could clear curr_xfer between reading it
and using it. By moving the read inside the lock, the handlers are
guaranteed to see a consistent value that cannot be modified by the
timeout path.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index f0408c0b4b981..ee291b9e9e9c0 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1440,10 +1440,11 @@ static int tegra_qspi_transfer_one_message(struct spi_controller *host,
 
 static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 {
-	struct spi_transfer *t = tqspi->curr_xfer;
+	struct spi_transfer *t;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tqspi->lock, flags);
+	t = tqspi->curr_xfer;
 
 	if (tqspi->tx_status ||  tqspi->rx_status) {
 		tegra_qspi_handle_error(tqspi);
@@ -1474,7 +1475,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 
 static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 {
-	struct spi_transfer *t = tqspi->curr_xfer;
+	struct spi_transfer *t;
 	unsigned int total_fifo_words;
 	unsigned long flags;
 	long wait_status;
@@ -1513,6 +1514,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	}
 
 	spin_lock_irqsave(&tqspi->lock, flags);
+	t = tqspi->curr_xfer;
 
 	if (num_errors) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);

-- 
2.47.3

