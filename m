Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA01339A4;
	Sat,  7 Mar 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772877056; cv=none; b=QkN5xXyE4eBN5RnIfLCZkqtfciBF5wNesPPsFxV5c/XEHVcsdb5fYyK2/07nCIu5c7qnpZiuPGuMvKct06YY8RMAQ6rjWr8gOMDXcVZurwThAaDbp5rUJtIEOINKH8DHkftFGwdO0+KDQaeiiF5Aarnx3gunpZihndTTuXuUJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772877056; c=relaxed/simple;
	bh=xtUClKEUaxMc0AVjz0TDLnnYbcwSJf7nwhjr3+OT8Uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cq5gzFLDhpevsapGleEkkW9msW2VVfkaoZHPJalO+WLwmH2rh9p54BhjTbi11LIAMrUfagnAEDaC6idUru5hGQJR7aNNzoESLkAtlX+BWfJYH59u5EmdqNPcMDOAsalBVpBBJg7vwPTwLQvhDfMkia9JgzPEM2Sp415eVv5sfb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUCFmocM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUCFmocM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAC2C19422;
	Sat,  7 Mar 2026 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772877055;
	bh=xtUClKEUaxMc0AVjz0TDLnnYbcwSJf7nwhjr3+OT8Uo=;
	h=From:Date:Subject:To:Cc:From;
	b=pUCFmocMA4fvnwvMnE3wBR8z8cgW4PzxD4AF0Hc7Kj54me5cYg3uLjFIoUhD52YTm
	 pq/YO76C+CBmHht2g9J3nknNaywLNwQm//dxLV9yTRa3Dc3WhA249+d0wmHqpAZbLu
	 xYM5KhTx13oqylo3zPuOAG4a+CGS/dg6EDm1++EX27lp7dKtRxDAtXQay+QjgyfuLf
	 FJTpV2PpGo8IBAp7CFiOVdk8FPnDDsUVUC0Fy+hQt2NEDlcGDqqtZa4e0Ma8tuDw9p
	 kVtqfdkHBseUJ7eg+3iUga6JR7j4osGOuzyBHCXovxHf5dX5wfUdagrAzghrfX2Dol
	 q8D5FTVWYfxNw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 07 Mar 2026 09:50:35 +0000
Subject: [PATCH] spi: cadence-qspi: Fix requesting of APB and AHB clocks on
 JH7110
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOr0q2kC/yXMQQrCMBBG4auUWTswqZharyIuYvJrp4tYM1WE0
 rub6vLjwVvIUBRGp2ahgreaPnKF2zUUh5DvYE3V1ErrZS+ebVKOISFH8HPDTT88Dp1zwl6O6Po
 gfXIHqoepoNbf/Xz5217XEXHelrSuX7rtoK1/AAAA
X-Change-ID: 20260306-spi-cadence-qspi-fix-jh7110-608e79a09d15
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: Ron Economos <re@w6rz.net>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-002f7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xtUClKEUaxMc0AVjz0TDLnnYbcwSJf7nwhjr3+OT8Uo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpq/T6l8+D08aPKFm/THA07lSGjTwJzz0/Ougwv
 SDq1OoKcPaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaav0+gAKCRAk1otyXVSH
 0F6rB/0bcov2kdGIC8V4YFusvogZVo/fllq0NIHth/WldB79/AabU4NGzAE/0zvPPKS6+r2PaqW
 zsVVCygIh3eS9X3/g0F9S4w4isqc7QWhxpnQqUpPT5YwEVXLLBLMxV0IkVz+8iBV5bRJirO5Be6
 M/qkkpFdfEf3s+laeX7sXLZZ3Gh3ZupLz2uM8W8VpG0XX8G9BPBytl+hz1zMTr2oxwBJj6HQ4Bi
 NqNmzRbTd4YhY18AAxMNArAczI/oObTPNLJyfrsqlg2LUSczBfRCCnGVhJtx5X25IKKNwBYAfLH
 YgLidoWGFWj/nN1DUxU+x/dS4lIcFnwTKAzNoyvxAHkpj5+A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The move of the AHB and APB clocks from a JH7110 specific quirk to the
main clock init dropped the specification of the clock names to request
for the AHB and APB clocks, resulting in the clock framework requesting
a clock with a NULL name three times.  On most platforms where the
clocks are physically the same or some are always on this makes no
difference but the reason we had the specific quirk for JH7110 is that
it does actually have separate, controllable clocks.  Update the new
code to request the AHB and APB clocks by name to restore the original
behaviour on JH7110.

Fixes: 324ecc7788c2 ("spi: cadence-qspi: Kill cqspi_jh7110_clk_init")
Reported-by: Ron Economos <re@w6rz.net>
Closes: https://lore.kernel.org/r/a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 649ff55333f0..5fb0cb07c110 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -76,6 +76,11 @@ struct cqspi_flash_pdata {
 	u8		cs;
 };
 
+static const struct clk_bulk_data cqspi_clks[CLK_QSPI_NUM] = {
+	[CLK_QSPI_APB] = { .id = "apb" },
+	[CLK_QSPI_AHB] = { .id = "ahb" },
+};
+
 struct cqspi_st {
 	struct platform_device	*pdev;
 	struct spi_controller	*host;
@@ -1823,6 +1828,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 
 	/* Obtain QSPI clocks. */
+	memcpy(&cqspi->clks, &cqspi_clks, sizeof(cqspi->clks));
 	ret = devm_clk_bulk_get_optional(dev, CLK_QSPI_NUM, cqspi->clks);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260306-spi-cadence-qspi-fix-jh7110-608e79a09d15

Best regards,
--  
Mark Brown <broonie@kernel.org>

