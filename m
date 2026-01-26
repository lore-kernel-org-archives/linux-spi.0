Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6322356D9;
	Mon, 26 Jan 2026 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449865; cv=none; b=UGOyz+40afXdHVrgBaJbtFAkzCyEckDY4KjTxWFeBs/AFk98moPKFYvjCponmDRBKcYskPhCEyoCz5qvctZqsAjK7DK6dVA4WiJ2LobswY5UUN3DakDuxL+BeK7myJt880FPummkeFdBympYdZfGaSwB271YxAYXVH1UDgbsbTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449865; c=relaxed/simple;
	bh=H+Ndq8xyNh/axb2xX29smVYLN27vuMbWxkyvn8Sgxec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaBpA0zQuQts1nswUWZWGY6aKcsVYRJ7hJpzPXx57Qb97W6q1shS0eKWbmMI7xCHobuNbYYYZiSYbCcvVCaoC0tKpVaEckf10/4sgVqXttopcbEeI26RxtLXda62m1PABl11DMmVStT5PKuN6jYAXUWUZpMXlLbCxdItAt3Hu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=V4XazW1K; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="V4XazW1K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=v+IMqYPuPVmNe5aFHbSgO8W8b+6niWJ/Zo4VDfQC4bg=; b=V4XazW1KLpmcC0t8w6d7J5x6yl
	PXt2L0KHEVQ9XXLGBtxcvi8DIZCV1yuoy0yXfOba9ubkPjDoplgmfMbByDf6Fn16RTgiqNPjRtuHo
	2oy2amFFPKOLvV4iejYUo0WrY6X/i0JzIebLSRTFa9YuhSn71wnJby9PBr7b8aLL7PdFlueGehExm
	52F862dfsc7OqSg9s00+25tF4BeB6yaL253XWivpd6sGyuZOLbnB6WFDp6q1+JsyYzK5k4vBkjESt
	Fel3VOCKPdS505uZe/wweanj1q986XfnkFituu8Zr8v3Cry5Q1Vwi5Y6Qyp764TEbMh0EUfcO3P1Q
	A2Dy1QPw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkQjq-00GLZZ-LV; Mon, 26 Jan 2026 17:50:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 09:50:28 -0800
Subject: [PATCH v2 3/6] spi: tegra210-quad: Protect curr_xfer assignment in
 tegra_qspi_setup_transfer_one
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-tegra_xfer-v2-3-6d2115e4f387@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=leitao@debian.org;
 h=from:subject:message-id; bh=H+Ndq8xyNh/axb2xX29smVYLN27vuMbWxkyvn8Sgxec=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd6lv++vxRUI/7L0769UMjw0LrUXjeKTwp9poi
 bCw3dkWb8OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXepbwAKCRA1o5Of/Hh3
 bTwAEACvSgM5hPznk65yYsApQqkFqZwojRsGbJSzueWu6kV2i9fSgOnUWAdLLkFCcAepVG1qFqY
 ipKpkLRinfOsBs4LHldFCw8gc7A73yeuwMljQG7wYF3Y+QEt5GsPt6uhLgxQwYyEoiioCaa0Tai
 wkkazvLmM4oDaKZY6xoL+11VMKi3vN6gLbWHxEzfjMV4gyJrRQGoCFdmV+WFcXbql4rLFN8hm4O
 YkbTDMFBVrV/4VfzP2ILHupF0wKOeYd6Upaac4ci8tJpcmctenNlQfQBzs/UerpMkY+PgCqoEMf
 68+xvLbE6sPyo8X03XadIGBPD7H5jTXN9eJUUzxidUpc4jwYsIZQFhvgYa8JoG6crw/EgP8N4QE
 l2cBfpaa8dbeplP99WkljV25SQXabwPUU84k9vXWnmeDTYZ3GMTtqjXFq1Fn3JfxKD7zSyQCf+b
 PQySsTBFVg2RTArPepP3YnfHjt0J/lk2fb7+9wP8EABd1VqQwTSzx5PFeEB3AY+ls2SlDc3gdUv
 bgJOPgK4ah0Oh9uoq1sIr2Jmd3pNsgqq9HfmIombS2339sxBSdHMS0+UmMrOOmJzKndLD2W62cz
 ShwlIkciWPKBo5hIN+08eOZTpccX93q33lCz0IDXT8q1FvMPIGJ6Cg5aHlRhjuZ0saOuciPvy4b
 rLyaFPxqYMx/hdA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

When the timeout handler processes a completed transfer and signals
completion, the transfer thread can immediately set up the next transfer
and assign curr_xfer to point to it.

If a delayed ISR from the previous transfer then runs, it checks if
(!tqspi->curr_xfer) (currently without the lock also -- to be fixed
soon) to detect stale interrupts, but this check passes because
curr_xfer now points to the new transfer. The ISR then incorrectly
processes the new transfer's context.

Protect the curr_xfer assignment with the spinlock to ensure the ISR
either sees NULL (and bails out) or sees the new value only after the
assignment is complete.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index ee291b9e9e9c0..15c110c00aca5 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -839,6 +839,7 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 	u32 command1, command2, speed = t->speed_hz;
 	u8 bits_per_word = t->bits_per_word;
 	u32 tx_tap = 0, rx_tap = 0;
+	unsigned long flags;
 	int req_mode;
 
 	if (!has_acpi_companion(tqspi->dev) && speed != tqspi->cur_speed) {
@@ -846,10 +847,12 @@ static u32 tegra_qspi_setup_transfer_one(struct spi_device *spi, struct spi_tran
 		tqspi->cur_speed = speed;
 	}
 
+	spin_lock_irqsave(&tqspi->lock, flags);
 	tqspi->cur_pos = 0;
 	tqspi->cur_rx_pos = 0;
 	tqspi->cur_tx_pos = 0;
 	tqspi->curr_xfer = t;
+	spin_unlock_irqrestore(&tqspi->lock, flags);
 
 	if (is_first_of_msg) {
 		tegra_qspi_mask_clear_irq(tqspi);

-- 
2.47.3

