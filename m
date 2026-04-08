Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FA3D0919;
	Wed,  8 Apr 2026 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655973; cv=none; b=D0h+NKg1KLtmFy0q68yF83cw5GEPNSfitT1ZJ6Gn9vae28U1DvG8A6+v/YbRpB42sZnBQ/2J5Wm+gvGcbBMA7c4uP/UsJQ52h+pqOtrpqCdi4khFxnOmpn7ZN7BooTBQtQKwh+CyXxKAD7AEzM1z/hSAhgTvcq2WJeQR41wdcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655973; c=relaxed/simple;
	bh=L2VDqHhN7Ia7l+wKWCkvcm5lCLsUz8HKsNWtCrpGFt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fj442XIPQVrXm8E6EGNldZQ1sv5a7MPGXAfHJzEYPaTDEAofiOWPu0PxBw3xqVEdAk1if1OlgP5lqP0JLn2eCGD/x8GUgJ4ORu8tvqjRM7yMYnAw/J/VDvfWKT/gXhByDmPM6Xf5p8xMlyumuQlKDbzGq+8eqWtpuSxQ587e1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=icQTJTsS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="icQTJTsS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=HcvFXUIAV4OQbqlH4vRJ5Y5Q1or2wmgdX0N00cKRyx0=; b=icQTJTsSdSmhWVsrOw6iMDEkcx
	6dkFhyNoWBHaMJ0VLi4G6UlFOPn4sK5QKrI2Ix1ij1JhsJs8wAqvMMoaRuGbyTNyEi/PlpD6SbYnx
	m6UmfFzG4L/YvdfpH6HjpSJ6gHoeWWGt98ZgAMSVw8HKlSLaN1zacWR/vXJMZdEcG0O1uGEI1Y399
	1RggYcDakrgrFQrTY9pMoIrnm6ynwYrFSsgwFT4x7d9Vpz6ODkT15GIkfay1SU1i54Os2mrzY2qnG
	I/FDKlYlmmvvV/ivcWTQjmBsXGw2MZ26TrNtqCtg7PdwXAKCv/EiA9whMVtQQwfs/tkTjhvInwtfP
	1VGfMkIA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wATEN-008Snk-04;
	Wed, 08 Apr 2026 13:46:07 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 08 Apr 2026 06:45:43 -0700
Subject: [PATCH] spi: tegra210-quad: Fix false positive WARN on interrupt
 timeout with transfer complete
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-tegra_warn-v1-1-669a3bc74d77@debian.org>
X-B4-Tracking: v=1; b=H4sIAAZc1mkC/yXMQQrCQAwF0KuEv+7AdCxF5ioikqaxxsUomVaF0
 ruLdvk2b0VVN63ItML1ZdUeBZnahiA3LpMGG5EJKaY+dvEYZp2cL2/2EkRlTMIH7tsBDeHperX
 PPzudd9dluKvMvwHb9gUGTwG0bgAAAA==
X-Change-ID: 20260408-tegra_warn-cecd2ca3a61b
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, song@kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2822; i=leitao@debian.org;
 h=from:subject:message-id; bh=L2VDqHhN7Ia7l+wKWCkvcm5lCLsUz8HKsNWtCrpGFt0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp1lwa0fRGYKAfqmnbOnbUQt23sPW2yEc53EGC1
 1SJdRgmzL6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCadZcGgAKCRA1o5Of/Hh3
 bTk4D/9Zpiz9mjkCbo1M5qP26gFrQH6VOr4VwUL0PxpKTWaF5SJiMTM/uCT1s2RV26mwI5L279o
 5bP3/WfRuDU70jdy721FgOexf3RpqghxM+6x0zN9O71IdHZsGpdqKcRV6mV18rMVz0mM6gnwuaV
 XyZNdsqHPam2ocM3YS2Dc/e2OmLd0R8CVqhKHJAgENK+myawra+B6+aBP2qsYriKZ6wV9PnuZCn
 zeKFRVzi/C/thsR5Ils44MtMXxQsrv+QJFloY9m8dwQ794G6w9a9zfHN3KRXC56oiSFTBqddw+h
 P4bP9fbdPID3JIG5MAmyeimBFfPQH1tJEnyK2RHzbV8961gf+QVrS4oUCgUYAuj0xWI26PScTsb
 Sl+vIBcNmtBO/KV5gDGXFrud9Zhf2/z52qGSd7gz0OfpV3vlkc9D/+PvV5MCwpYIDWim9xNcp1y
 ep4yfYJT1kSTestgmIbuh3sCzd2Dnl//XFGmbqALhg16+3X1pkEoDNuxhfpkzHKfWijGT52wG3t
 XDKjXLW2THn+qVCqtL2Qcnke2BOFAE1+N7wsYL4BJxBmB/Ba+X3t5CeEnnw65lTESZNZvjxrWcX
 SCK7hjuRFM/rxWfPminPsAl80RfrHZEBTVwfx2nQNwjM3PEb6XL0InSuq/aOsVssbD6Ifh4l4FD
 k6KJuFXhF1bU8Sw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The WARN_ON_ONCE/WARN_ON fired unconditionally on any completion
timeout, including the recoverable case where the interrupt was lost but
the hardware actually finished the transfer. This produced a noisy splat
with a full call trace even though the driver successfully recovered via
tegra_qspi_handle_timeout().

Since tegra210 uses threaded interrupts, the transfer completion can be
signaled before the interrupt fires, making this false positive case
common in practice.

Almost all the hosts I sysadmin in my fleet produce the following splat:

	WARNING: CPU: 47 PID: 844 at drivers/spi/spi-tegra210-quad.c:1226 tegra_qspi_transfer_one_message+0x8a4/0xba8
	....
	tegra-qspi NVDA1513:00: QSPI interrupt timeout, but transfer complete

Move WARN_ON_ONCE/WARN_ON to fire only on real unrecoverable timeouts,
i.e., when tegra_qspi_handle_timeout() confirms the hardware did NOT
complete. This makes the warning actionable instead of just polluting
the metrics.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 7cca5578eba31..db28dd556484b 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1223,7 +1223,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					(&tqspi->xfer_completion,
 					QSPI_DMA_TIMEOUT);
 
-			if (WARN_ON_ONCE(ret == 0)) {
+			if (ret == 0) {
 				/*
 				 * Check if hardware completed the transfer
 				 * even though interrupt was lost or delayed.
@@ -1232,6 +1232,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				ret = tegra_qspi_handle_timeout(tqspi);
 				if (ret < 0) {
 					/* Real timeout - clean up and fail */
+					WARN_ON_ONCE(1);
 					dev_err(tqspi->dev, "transfer timeout\n");
 
 					/* Abort transfer by resetting pio/dma bit */
@@ -1340,7 +1341,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
-		if (WARN_ON(ret == 0)) {
+		if (ret == 0) {
 			/*
 			 * Check if hardware completed the transfer even though
 			 * interrupt was lost or delayed. If so, process the
@@ -1349,6 +1350,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 			ret = tegra_qspi_handle_timeout(tqspi);
 			if (ret < 0) {
 				/* Real timeout - clean up and fail */
+				WARN_ON(1);
 				dev_err(tqspi->dev, "transfer timeout\n");
 
 				if (tqspi->is_curr_dma_xfer)

---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-tegra_warn-cecd2ca3a61b

Best regards,
--  
Breno Leitao <leitao@debian.org>

