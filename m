Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A551FECAB;
	Tue,  3 Feb 2026 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083720; cv=none; b=qmr9Snm2+gVqpdvGJtrV5i9Lu76PKTQKbnotVU5oM/tqr1doOc4p4mNjjjhrWpV+iwoZpcgbOm3Q2aJ8dT4DPMmWy93yHUKfwitz8DE3/ezCvFMWYJEfCsvXnF7oap5i8bhkHJ20KDPYW1nNK1ntMB+/kEI1DhooaNKQI/4tfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083720; c=relaxed/simple;
	bh=IW/+JrbrQIvK+EQCG3nXnsBAjmMT2tbO68ByxNyFyHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r9WKKJPw2gPcl2C953tZIhl5a+mG1Ua66Yqtu0ssi2BGUUdbRbHJEhzOnlhFLmjByve03tCFrtxLhkOL5eYFtIsCGHMPCeBHRwwBMDWAwAdR+zKPGgfjZfFcNvpl0XrtwiSk0apSfHDzMwm8t7SyQa61q1Qx7Oywu/brq+uBBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgr9chCv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgr9chCv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F240C19422;
	Tue,  3 Feb 2026 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770083719;
	bh=IW/+JrbrQIvK+EQCG3nXnsBAjmMT2tbO68ByxNyFyHE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Kgr9chCvLZbhou3vdF+YfiY0wLnGvAmYNw7iYWGQxhJeF3uiypF6+exd4Vvr238DE
	 RvBEVin4n0y1SAw52je39GyouY/vJL0KHf56mDuNgkIXAb71bn/J9YkKSLHhXc6Cdm
	 /0nj96exxUZUL4J3kegOwRiVs3Yww68NORr/lp8C9FnFoQeatosTaBciX9kFv9y9fE
	 3AxDFKu4tovrwXvv0920eECgX2qeo2y+ZC504cwD2lwWZ+loD7I5cB6ctPvpqAR3uZ
	 BFAYbgonlAp7ZH8XysmlCgD8lvOJ47odx2ee0rd1iQGUCIf/ZZ7l2HZjfMen/ouXwW
	 n4Gogqqnnqr3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBE3E7FDD6;
	Tue,  3 Feb 2026 01:55:19 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Tue, 03 Feb 2026 01:55:12 +0000
Subject: [PATCH v4] spi: xilinx: use device property accessors.
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAH9VgWkC/03OQQ6DIBCF4asY1sXAqJR21Xs0LkDHMklFA9bYG
 O9eNF24/Bfvy1tZxEAY2T1bWcCZIg0+RXnJWOOMfyGnNjUDAUpIqXkciS/0Jr9wabUu28qqSt5
 YGowBO1oO7Fmn7sLQ88kFNGfiKiTIQuWgKgDBJTe2/YRgXG/8w+MyuWHMDe2gozgN4Xucm4ud/
 SMA5x9zkRTdoAGBGjphz0y9bdsPsT+ax+YAAAA=
X-Change-ID: 20260118-spi-xilinx-1b884d5b6519
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770083719; l=1424;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=JnhvafHbNCA383rSJUeixD1NuH8QF2CYjO1pAgK3Pbs=;
 b=4kZg1Y5eIQ5AUsqkxYCepuzdNSwUt5ZgPJLeCt7hsoG5JfExAcj+26GBMPshRjiD0GsWqGkjc
 OOf6cP+lKA7DoDZkCl5vICaChIHBevWJvMGBxn2578x8A+B0y0Ucs/B
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Switch to device property accessors.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Switch to generic device property accessors.

2.52.0

base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
---
Changes in v4:
- Removed patches making the irq optional.
- Link to v3: https://lore.kernel.org/r/20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai
---
 drivers/spi/spi-xilinx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index c86dc56f38b4..c4b70e95b695 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		bits_per_word = pdata->bits_per_word;
 		force_irq = pdata->force_irq;
 	} else {
-		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
-					  &num_cs);
-		ret = of_property_read_u32(pdev->dev.of_node,
-					   "xlnx,num-transfer-bits",
-					   &bits_per_word);
+		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
+					 &num_cs);
+		ret = device_property_read_u32(&pdev->dev,
+					       "xlnx,num-transfer-bits",
+					       &bits_per_word);
 		if (ret)
 			bits_per_word = 8;
 	}

---
base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
change-id: 20260118-spi-xilinx-1b884d5b6519

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


