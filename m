Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A460C347FCD;
	Wed, 22 Apr 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871019; cv=none; b=Lei3PHVSk86TelOVSJv5KV+gl5Rvyv+d90tsw59pCk5vwTh9dyMzMBI2xZx7JLZRDSWjagUa3KPZrT1y65w+MIV92fWlbRd64+NNufSTZPXboQdxH0xDcbvjilQ9I49adIzyOrcB9amK3lGvmU4/uBDe0NBYJM4QjAU+8JePQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871019; c=relaxed/simple;
	bh=6ET/frCteaTcrEw4caKHP3nJei7aVUDYuECfByOQKZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuCBfdwXy8r2k78zRLV0Nf5hrAAuh4gScqRFi+JWKRpVLAivgl93EHvESMtPTk8pxupTYznJ9KY6Nru4b8/B1Az11rIMPhjRtkXlVAUA6jTrQUMBBt61ITI5p7tO4MNm84isroUEKPSfya7e8UBysFrHUgv2zcEie/CVSsydIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxHwzwf6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxHwzwf6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF38C2BCAF;
	Wed, 22 Apr 2026 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871019;
	bh=6ET/frCteaTcrEw4caKHP3nJei7aVUDYuECfByOQKZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxHwzwf6JqgqyvJ1OZhj+VC34Cd0D6vupBQKWuZWOX8A05KspypYTPIhtKgsaxcr4
	 MxI+6c92kOvrVnb0eQvDn4ktGhaLL+1u5oKzj4Pgupi6NsqgOWGTTnmxIVwdNwu3AD
	 1XwXpXHRV1gcse9qesHmcQXcoT+4R7/hucBCcaoDI0glxQnauNBMf4qEDklnTvvE7o
	 Jz2phloDCSutGlSEEgTpO7pbMDz97FRKUHRW/SIAoWfwiLjbrVO9byQ3dPLgNVMvfJ
	 VBhgZcrw0lA+IBAyrbLk4D6SCziemmknGSV8c29FB3RGa3PMbJafgFfXiisUVg/7Zj
	 AXQJ8b/hkYYcA==
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
Subject: [PATCH v1 5/5] spi: microchip-core-qspi: remove some inline markings
Date: Wed, 22 Apr 2026 16:15:46 +0100
Message-ID: <20260422-cackle-guacamole-d51cc736a4b6@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422-foe-strength-a5d8ad650ef4@spud>
References: <20260422-foe-strength-a5d8ad650ef4@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=LZMEd4rd4apGWbweXgMgaeSQ0Rz6fCOGsgSVYyBq+ps=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkvnjkEWxX4Narxpf043SUqWr9A/tMz1z+x09nOK78v/ rh3U8bFjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk0TmG//6VNy9+m2b/dmHu 5KTGlv2/3DZff/skZqZtYV3znC21dWWMDFetQwvKIuZrRq6sucBSWMr3/NX1dzJ5vCwH32WeWq2 4lhEA
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
index ae1c7ce09b2ed..383d5eef7a2a2 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -199,7 +199,7 @@ static int mchp_coreqspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -235,7 +235,7 @@ static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 	}
 }
 
-static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -263,7 +263,7 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 	}
 }
 
-static inline void mchp_coreqspi_write_read_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_write_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -421,7 +421,7 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	return 0;
 }
 
-static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
+static void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
 {
 	u32 idle_cycles = 0;
 	int total_bytes, cmd_bytes, frames, ctrl;
-- 
2.53.0

