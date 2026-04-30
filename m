Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CC3ACA65;
	Thu, 30 Apr 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543847; cv=none; b=ZxvNGUvR8ZbzcKOxFrfPtViI2I+IC1ybbrgtRJuHU1d8SmYVwe9kIYbyo7djUUx01TBrNvebUeE4jBSR9pJxZrDBY6f8UsU/KNWJn93jNKKxf2sBwdOwpzMxRqhOGdwKxuKxnQnOnsZgbSxkQ48q2UzNVZOMHEuFpoD6RoIeRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543847; c=relaxed/simple;
	bh=SnQIwcKB/QmkyDmi1HGIsJczvkQ3ZCUL3EaPXot18L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HC6bL+nEVrmFb6Q4Xf9rPol9XcI7RnPq+YeZ0Z6ZhNupbDFNq9U9zk2aGkaFFL0GhCLD/viM/mQ8uwGapKKUqJUcQYfTyHVaGcbrb8srry30x1Jc0Gs06O8Awcvw0FjM0nxcKkdOAaxs6JtmA9FEZMRn3GVHuSvYZODrl/S0U7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhgxfs6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhgxfs6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CB0C2BCB3;
	Thu, 30 Apr 2026 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543847;
	bh=SnQIwcKB/QmkyDmi1HGIsJczvkQ3ZCUL3EaPXot18L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mhgxfs6etbHf8XFTCL0NfzKw2pPnDqlEH5iCz03c6UfMqI+GkUj/q1vTukv097NVF
	 iLjF8R2NebgDUX76ObkbrF+8V+cH84V0TWg8/pMUW4An77NovKILYi6feKYSQuWKOV
	 hsZKQzzeCRREyhqeXB7B1P5935RzERP/2C9+iaLMBE3SAjxX9xys7l6jlLBmIJGySP
	 b/JiqFhtzwq7z/8cPvwDoohYrKU9Hmn+Jq2omOgGn9TNabn9Yj/nSeE2nSaj0XlS24
	 o1WfiNiKtglnjVFeQWxO9yGl69v8XP88jA0ThB5tzLaz8J5ZjvYc0J8nUfLH88Tv+P
	 dy/A6vwt26P7g==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] spi: microchip-core-qspi: remove some inline markings
Date: Thu, 30 Apr 2026 11:10:20 +0100
Message-ID: <20260430-serpent-stimulate-59fb860ef429@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430-levers-defiling-00406e391c5a@spud>
References: <20260430-levers-defiling-00406e391c5a@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jpI++FBrluLRiP6PUmGBsNndveZI5ut1N5P3XQfqIEU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmftTo5nKy87H+5ebs3ymUctc27l/DaYUew3Nn739vsp yy+m3uso5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNJOsvwz9gt/bmXp0i50MeA pS8fT9e4emuiUObuC84nLLavUti07BojQ+O07KWvV3zp62Ji36vU4nkpdrVz1aQzaqfvX/62ojB 9IjMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Remove inline markings from a number of functions that are called as
part of mem ops callbacks. None of them are either particularly trivial
or sensitive to overhead of a function call. Just let the compiler
decide what to do with them.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 70215a407b5a3..4dee0fea1df8d 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -197,7 +197,7 @@ static int mchp_coreqspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -233,7 +233,7 @@ static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 	}
 }
 
-static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -261,7 +261,7 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 	}
 }
 
-static inline void mchp_coreqspi_write_read_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_write_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -419,7 +419,7 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	return 0;
 }
 
-static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
+static void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
 {
 	u32 idle_cycles = 0;
 	int total_bytes, cmd_bytes, frames, ctrl;
-- 
2.53.0

