Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7037FF76;
	Sat, 10 Oct 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791646531; cv=none; b=cVlx0KpdPjwyM2TJTXe0lrWRFNfBNlQgUs56xaQZ7MfEEduN8wnMNQ9bfpDG9MyjmHAN426C5zDwyTE0zsFq8sZHp4xXmd3VviaHqs/dkgE8nWqXpJJpjKglItKjGjOSyj9CfZ5G3aj52JJlddZEy7Yh37g2n8v+2NIAm2sPbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791646531; c=relaxed/simple;
	bh=k//mj5jmFAlK6jX77ioAzV5EkUQHciQW8fBuV9gl2O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WERVXkJ6IcbzTsZtSfwAkcAmhgnTMzAn7ThPx5fV1EaReuvYSVwMdsra6I8XD0Chr7oweVOgvZ90ULpsK2vm7d0OPUaLlH1tv9VDTFWiINL45BFEdCPYzpat/Jmj3oN8MYgvLECUG6FpvvwljmjAOdCHCMEEPfVXatC8A+nL/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJbeAswi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJbeAswi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B777D1F000FF;
	Sat, 10 Oct 2026 15:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791646529;
	bh=7eMTukemozpAwDOfk9djBR7fgMTRzRaDIeCMs3qeRQE=;
	h=From:To:Cc:Subject:Date;
	b=LJbeAswiKweFXEQ2NBx1uxY+zqiq/pfRuBSlB1t374T6dUOoYSlniCpm/U9FX6sYB
	 beNslYWYtXAB+a9Vy50vw7TxbF8nmQIbEjcKWWQpUgyq1JpKC6exKUMS3pvUeMtXgS
	 yTcfcsqk0SlFy8thfJRxggoLhgwSrcbQsA1KZZ3EUHIfWVQIwOmSQSmg4BUq3BR1iA
	 YS7Ei4GGOxbRj29LlBiIclFI5RlzMZBeWjWm3Frluk9F3MNsNy0MTanlmEjK/lSICB
	 Y5jwAkjrR0XXyI9MrPg4KtSLOFM/fVSiDSsUl9F2bCNhIx2e8VsXr2HoqfIzjJkVfM
	 RFFboj+0286DQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: Fix missing smp_mb() in dw_spi_exec_mem_op
Date: Sat, 10 Oct 2026 23:15:29 +0800
Message-ID: <20261010151529.30590-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar as commit bfda044533b2 ("spi: dw: use "smp_mb()" to avoid
sending spi data error"), we also need the smp_mb() in
dw_spi_exec_mem_op() after setting up the members in "dws" to ensure
the data change is visible for all CPUs.

Fixes: 6423207e57ea ("spi: dw: Add memory operations support")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 2d671e31413e..90af2cc9e17d 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -842,6 +842,9 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		cfg.tmode = DW_SPI_CTRLR0_TMOD_TO;
 	}
 
+	/* Ensure the data change in dw_spi_init_mem_buf() is visible for all CPUs */
+	smp_mb();
+
 	dw_spi_enable_chip(dws, 0);
 
 	dw_spi_update_config(dws, mem->spi, &cfg, NULL);
-- 
2.53.0

