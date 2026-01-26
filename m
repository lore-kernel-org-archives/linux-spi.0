Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144823446A9;
	Mon, 26 Jan 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449874; cv=none; b=eD59x9V2Asz+5YhdMNKXhIN5VQe0vtOyTd9fwR/f2SUk6P8wu9OPBUgmTRyFSA6iEl4YY5JPfqxuH5dktvcmF0p3c0mgR9EHB2jvYq8uxNRwEAh7fgLfT8MrwwMXBiuRPnm5eLXmtYzqo1QlhA4SDQL+77pYHteqFu3VsBEMVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449874; c=relaxed/simple;
	bh=oHsppgOVm1uTJGTIRuD2JidFIMjUWIGBXVikALrCcfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHOqBASIuZHWxGH3M/RLR9q41hTPWeS/yQt1HbusYCIbNPbn4tPKUrq+tu5NHoSJK32dKdPtILqB2IAxFWpkoxTykhGD+RCt6EJCtlo9mEtVnb4O7uo7OnZ3BnxZYx8APKCObb8XTUIS3yc7zAg0AB3TlG+fq3vlvjgufhFQK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kHYCkL45; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kHYCkL45"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=A059W1k9gqtnhjYsvn/29VQuXXtuzYg592TH9tdDDeU=; b=kHYCkL45uTnFoLwEXfyhsG9HoN
	KQXLQ1GNvnZUPy+GB/37t0qhNt7YX9N1eQOZkPKnCmz4yXEBNYkFffI+HFbi4oTReWi8BURq6GzPU
	TMQQecS9CgehCJi98j0RLvNIQ6C1tjk/xFQQnpzdOWEpv3B8ZDavxOuK8md7rCiaeMc6RRhbDrEFG
	FKtJd9R9U39o8k5mkFiCxaM4cl5hK1EFTUVjvwJiwb/LMxRbg1p0UueNDMEtJHXl0HliziHwdYHPH
	hb8+ZdM17HLU7jC51VOhDPKXPjDus7Igu7wt4szpPLrrCH/f2+SG290FsimcLm5z0PLtG9kxuePkx
	pc2HqWDQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkQjy-00GLa5-UO; Mon, 26 Jan 2026 17:51:07 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 09:50:30 -0800
Subject: [PATCH v2 5/6] spi: tegra210-quad: Protect curr_xfer clearing in
 tegra_qspi_non_combined_seq_xfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-tegra_xfer-v2-5-6d2115e4f387@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=leitao@debian.org;
 h=from:subject:message-id; bh=oHsppgOVm1uTJGTIRuD2JidFIMjUWIGBXVikALrCcfw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd6lw4IyO5WLhLgQFIxTEp7sO2iQgN+Jc5Fz4M
 WldSlNb9AKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXepcAAKCRA1o5Of/Hh3
 bVOVEACubdmBK80ZMoxahwajHnER1gysKEgqeKLkoE5DuYDtqTls3F+6Dl7km9T5he/abdv/zny
 Nff38Ay3J80iBsncjCrSTJc7wzVg09jNwrqQX58ouPb6R/LwVsv6w7mfhaLsGJcv4Ms4MdaGAB2
 GdkLofjofFF76QHIjSfGvbtALJez/fKm6ihad4EoHuWNIdiIM9R8MGSQF2Jvx970Vq8EK2Xhy0U
 SbAPSxcT+AuxfDSweOL8TPGWgVTD+B8sypDnZCBkxwlFdZ1/y2xy68HHR35mfJw4Tv/gg79lz/2
 gdz0oTZpCCd9Rlmef89zItB5c9zz1Y48rjJpzJ2P+qP4WzB7Aqpy0YYh5QgEsvSYy7YBpFK4FwN
 o6zktX/TZCJql2KP8ouRNBJfYtznGbKti2scptFli7fO2A3I+D7B+dypAgfmRUTZNi8/gDXqHGv
 DrM9y0BKxH7pPz7ssMQ3Uhq9InvRiGhgaFUp0jqTvT2MlD+kIYKR72JpHOyBm97oY6p1k82kYEf
 FJtrlRHBA3QO+YL2KjvQ3c9Qvlc4sANh6VukShnVRnJ+HFdnJ29EbyPJzHE7q+bp36/uElZ0UOT
 g96+255XqVY65i2ab64TbjQ+hWrikh6ZejQvq1K+Yrfu2m/sf8r0PPmk7EnXc+RcidtcVgV4GVW
 FMiRN/8YdZ9E4Xg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Protect the curr_xfer clearing in tegra_qspi_non_combined_seq_xfer()
with the spinlock to prevent a race with the interrupt handler that
reads this field to check if a transfer is in progress.

Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 669e01d3f56a6..79aeb80aa4a70 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1288,6 +1288,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_transfer *transfer;
 	bool is_first_msg = true;
 	int ret = 0, val = 0;
+	unsigned long flags;
 
 	msg->status = 0;
 	msg->actual_length = 0;
@@ -1368,7 +1369,9 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len + dummy_bytes;
 
 complete_xfer:
+		spin_lock_irqsave(&tqspi->lock, flags);
 		tqspi->curr_xfer = NULL;
+		spin_unlock_irqrestore(&tqspi->lock, flags);
 
 		if (ret < 0) {
 			tegra_qspi_transfer_end(spi);

-- 
2.47.3

