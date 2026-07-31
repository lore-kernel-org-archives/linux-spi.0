Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D5314B8C;
	Fri, 31 Jul 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488910; cv=none; b=pkRvy8D4D5UU5G9wPm/lyJqSgC/KuQfXgdGA//JDMP3/cLQlD+ZIh2uXwgoq1uslz4HOI2bqBnk18JiC6OoJBgIW+W4Lwoa1JAcRSxL5FvRemLCDCLsugp/wuzUlz/Q2NMVuq2x0gAU/8EeoLNH4omj6dKign6e5Pes7cYceejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488910; c=relaxed/simple;
	bh=rq/tb46DP924L/FjVCUkL1FIttRHuK8j2ySAzVvIQZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3BFP3v0+WtOnNGNFGeJCKx6KE3fJJepEZ1mXVwIngCEr3ifaXPRXoCqOu9FbLBLzdJ/P292ecWGvpWhKOdDMeFP5iua1mhnuDJ9d5iB20Ox6nVlwEC8CWefLW+o2RPtIcg2C5SMyyZVoar1pM19sZhC92W3MeoDAuD+2qLzza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHzfLoYG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHzfLoYG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DEAFC2BCF7;
	Fri, 31 Jul 2026 09:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785488910;
	bh=rq/tb46DP924L/FjVCUkL1FIttRHuK8j2ySAzVvIQZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qHzfLoYGijlNkK5s6v2QAipdIJb70s6BBlSUGJpWG9oiN8o+2fk+LLTw4p9Fp9qNp
	 j/RuJbcBVBjWyM08YY9nlin4F8CcmmY7LcsZDoWRYdLRBXQQ9cIQWOVi4rY2tZdQBJ
	 kgf/RhF3kCbNrVGAf236v8y0SBIUBeH3Am7W6lhqHno7gWTDidr1Qlxc1mz7ZRmTRL
	 +cFE3f3MrAsX/hNZQ8bKLkIJbwxcazFMJW+5ok+Us9FP/SneSdVWv7flQIEbV6vPgb
	 GNFyWUIJPWytR1Ov0GgNFI68wGsv2lYgDZCEQEuz/X/rhnQf/egYp6Xr6yqbGot2eC
	 8WqCkKQe7aC9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FC7C55172;
	Fri, 31 Jul 2026 09:08:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 31 Jul 2026 09:08:26 +0000
Subject: [PATCH v3 2/4] spi: amlogic: spisg: Fix transfer size limit and
 timeout handling
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-a9-spisg-v3-2-a15da3f70029@amlogic.com>
References: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
In-Reply-To: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785488907; l=1947;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=BRq2nLOiEjtiR+0vj/uM6L8HPr1w32uaAGwS/r33K78=;
 b=+wtwSwKdGJ97TDwEtJc8168Lm+z187CiysDr9iVjlng+UZdwvgQC5anWhFOOEUIIOWvjCGJOh
 +41DdnUizsOCxC9uWXuNOE+9BqV72bytRXuxDN2WxCeKWtVKqyqoXQu
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

The CFG_BLOCK_NUM field can encode at most 20 bits, so reduce
SPISG_BLOCK_MAX to 0xfffff to avoid programming a zero-length transfer.

Perform the delay calculation in 64-bit arithmetic to avoid overflow
when converting nanoseconds to SPI clock cycles.

Stop the controller on transfer timeout by clearing the descriptor list
register before returning an error.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/spi/spi-amlogic-spisg.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index afc8af04638d..a6123975a37c 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -95,7 +95,7 @@
 
 #define SPISG_MAX_REG			0x40
 
-#define SPISG_BLOCK_MAX			0x100000
+#define SPISG_BLOCK_MAX			0xFFFFF
 
 #define SPISG_OP_MODE_WRITE_CMD		0
 #define SPISG_OP_MODE_READ_STS		1
@@ -175,7 +175,7 @@ static int spi_delay_to_sclk(u32 slck_speed_hz, struct spi_delay *delay)
 	if (ns < 0)
 		return 0;
 
-	return DIV_ROUND_UP_ULL(slck_speed_hz * ns, NSEC_PER_SEC);
+	return DIV_ROUND_UP_ULL((u64)slck_speed_hz * ns, NSEC_PER_SEC);
 }
 
 static inline u32 aml_spisg_sem_down_read(struct spisg_device *spisg)
@@ -565,10 +565,13 @@ static int aml_spisg_transfer_one_message(struct spi_controller *ctlr,
 	aml_spisg_pending(spisg, descs_paddr, false, true);
 	if (wait_for_completion_timeout(&spisg->completion,
 					spi_controller_is_target(spisg->controller) ?
-					MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(ms)))
+					MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(ms))) {
 		ret = spisg->status ? -EIO : 0;
-	else
+	} else {
+		/* stop transfer */
+		regmap_write(spisg->map, SPISG_REG_DESC_LIST_H, 0);
 		ret = -ETIMEDOUT;
+	}
 
 	dma_unmap_single(dev, descs_paddr, descs_len, DMA_TO_DEVICE);
 end:

-- 
2.52.0


