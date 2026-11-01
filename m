Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793550759;
	b=BlNq3R/F3SXQgjBbyxS1QpJ3XUGBbRxTFGl3u3z8QS0w72X3N/MRW5PL5erEVf+wYQb6
	 MWjLUZxUAVLbJPH7+HqrYxKZGxoHhfNfoy3ejjuv/Gkh2OFNWRS+gU/353Ck339mXy2J5
	 6ZFYk1Zs/DXI0AELFDwqflL5lkITsV/9V+onAHZC4+V/aOSqhjUqAhbi7zFbZ392UYJgQ
	 d6wi8cPvTj00hsLE65Gpe/UD4+FJX7H4a0FsOIc8B9JPMw4UI7VS2aMigMAZ1P095l0P2
	 GdHuDQPA1TJbrBrNcjn7Buk0bzBsKZY5EgYRPFcjy+plcuXiAhyDqywMlU0rsf30H+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793550759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iFLRmIpfBlnSgkw2NzNhDZgfvhMKknERscVzqbFyv9U=;
	b=cJZvtimfN/g09N/H2nwyHOXGOAx8hfVkLXhm/ei7nE+WYjbUJTv6Jn7GI4TQC4WP88xS
	 B+u6fXMx21wl6Bz+xZqvngPoDPZZmb6AF9bZmFYI2fFR3TuboucyK5Z5sOaHzol9z7ZCj
	 V9SI+/JVzNraTNM1DS8o3Mw/nzEiWDgbU8dhLMTuHR61lQPFXIy9WZNKCjuVlTBKtojVX
	 z1HeSdYAcjzw+lKpZH8sxB9bcPkKBxGKoQQEIMgBC0qjNdq9J0zMgLskpYHBco8StCOF3
	 k/BNBcfd5eGwlaQST8nmOkswQODVwCOaq++UahqUG/Prwt9sFFCt328aUuyzu1MDFHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0Rn3ysS;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AD606A325
	for <linux-spi@vger.kernel.org>; Sun,  1 Nov 2026 16:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F7AD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E0Rn3ysS
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso7658865e9.1
        for <linux-spi@vger.kernel.org>; Sun, 01 Nov 2026 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793550758; x=1794155558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iFLRmIpfBlnSgkw2NzNhDZgfvhMKknERscVzqbFyv9U=;
        b=E0Rn3ysSMBRCTtBfkBmzHVr+Hq439phfwyyWpeM2ztVJxpgMjKmAa1As39gTkpTcyd
         n7uhviJjEF5sTybCG+x8gm/d7q7y3m9P/3Un/k+mfowB0/tiqdQf30QQ0rdUdY5WBN/J
         UXjQvF2BrDRBa3El6IZsNbLF8+MSZHtUEK+18VZsUpNmGs4wZVPdj6455PA477iJ9cGr
         bne79mtvajzKNYBMmJbPdPAxoUW+eRz2MoSQ3Ydldbxv6WoMFFmPA6Fwy5j8ZLkaH0Jx
         uwxZ7IbsbqXNzLOtmE0AUGKKkIPIRtY47nJUS/RJn0Obs/XnaYs7658jiUhAWExA+lwo
         zblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793550758; x=1794155558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iFLRmIpfBlnSgkw2NzNhDZgfvhMKknERscVzqbFyv9U=;
        b=pd23NDEcwbcvUorCUfubzzbItV8nL8DUOr+lLGw5MwQCIe/m651EwqKGbeuyBsD64B
         0R5Y8Mrz29V/tlz0l7BIKvVCmUPzRz34A8ZMprPSjc8LINaIqDzLTJ8rUx/pTi4OjKl8
         otX2hJWDK0/SJk1LWkavpGsT6ZDCWqnvFlo7QD9L4DUqbFIC0SCxoroo3wnjuVZvS4b7
         eJSaozffJxrbC3VEZZtnRPmxm6vmHnTobDtXE8LVJfVl8GNN2jhk3a+YhMZkNXMUO+dz
         5/kbIY/mAQnrpC4dAU8l0dd1sVr1vNxRJS4bdMyigrN7zqO2/PbwW6Wn7k8o2fR4ZAHc
         tx1A==
X-Forwarded-Encrypted: i=1; AKwUvByfYqu3Cy2qYrdZw0KCb/pYmiQyqjDR1g4aGgRAbz0btbmMvx2bCfJfT9fv43W7/8Fe1EJttXfaJWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbOwerVbUb5CZlZ47UC1I7uI+tpITfF2lws03R8w8l56jLphzK
	s0ihf3+KO3w1TLP+1YAzuij97rZlyuHYYqN1lIfZW08/MOs5gQ/77jxw
X-Gm-Gg: AYBFou31WdckRikFb1ive97ofB8u/Lg6WdKVUioECzzuOR1sIeNKCcuuYLmjj/MO3IG
	f5NNrUH8Q5+z8/pYzcTKpEb0J17vdfKjzeevTAKADp72E3xLf30T2Me5l04XEpiJhsfYw6/LndP
	wGA7Sq3p7rwWtF7WijHqkdAyOLlchtWIAgrx4ae4rsep8RRNt8GQE7uIh/NvHVwWa2fqrkj0wTy
	NK9WVMcIrfmsafjp4pJQiT9HURSPlXzABzNaJkhfqq1Sd9SWzlVCBdo8LFGk2ce88YZVlRlZIEL
	2Zb5qUI6bD6hwa6u2BMdQiItMtK/dEEM337+qoXUdTxE+GcE+WMu3ipTb88hgx3CpCYH0+UdN0h
	jA/fM+cbSt/GEj5P0SOo1Sh3ZwshZvcmy5e8aj4/SsQMdZG9ATHupmBBSZyl45sy/dmXYVwJzD9
	CCy3ZAtzRXU+CrgVMPtTuFkK+H/c+NoejngBuMEHUByNwhmANiMsIBTKSPhqvAXHHagNxMpPtbc
	l0oQsPkIrsjgA+PlD0lXG9BiSuOItrGI6Zdayw4nQ3cqZXgxTh5yIJEGoJuDknSo+VXe4QpCLJ1
	sTD2Ko9Z9jgTeOUSUgh40k0iVhknAI78CvSoXjqFXl0186Z8drY=
X-Received: by 2002:a7b:ce0d:0:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4ac177538c5mr139047215e9.1.1793550757885;
        Sun, 01 Nov 2026 08:32:37 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm97219875e9.0.2026.11.01.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:32:37 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Marek Vasut <marex@nabladev.com>,
	Marek Vasut <marex@denx.de>,
	Michal Simek <michal.simek@amd.com>,
	linux-spi@vger.kernel.org,
	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	Itai Handler <itai.handler@gmail.com>
Subject: [PATCH 5.10.y v2 2/4] spi: zynqmp-gqspi: fix clock imbalance on probe failure
Date: Sun,  1 Nov 2026 18:31:52 +0200
Message-Id: <20261101163154.2274099-3-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101163154.2274099-1-itai.handler@gmail.com>
References: <20261101163154.2274099-1-itai.handler@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

commit 1527b076ae2cb6a9c590a02725ed39399fcad1cf upstream.

Make sure that the device is not runtime suspended before explicitly
disabling the clocks on probe failure and on driver unbind to avoid a
clock enable-count imbalance.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Cc: stable@vger.kernel.org	# 4.19
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/Message-Id: <20230622082435.7873-1-johan+linaro@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
[ itai: 5.10.198 carried this as commit 19f3d5d13b75, and 5.10.199
  reverted it in commit 649237ccf440 along with 2cdec9c13f81, the
  mislabelled backport of the previous patch, which this one depends on.
  Context - zynqmp_qspi_remove() in this tree already starts with
  spi_unregister_controller(), added by commit aeb00d7e89ca ("spi:
  zynqmp-gqspi: fix controller deregistration"); take the runtime PM
  reference before it, which is the order upstream ends up with ]
Assisted-by: LLM
Signed-off-by: Itai Handler <itai.handler@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 7223eee6db88..58b8c5c37f9a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1189,9 +1189,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1213,13 +1213,17 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	spi_unregister_controller(xqspi->ctlr);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.34.1

