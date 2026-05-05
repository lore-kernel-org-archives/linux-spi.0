Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532D3D6465;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=Zd8ErQcJnl0q3xuWCqr1I+m7gdda1jeQvAH9qBdDN36w4bggX+Okvc+r1zMqU6jhF8zrMpd8Irf8j/84el6tArFQZOFfEZJkyfr69pFTCZ0TTUIJRhnjb0jQk/FHA8DBeIC1Z+dLx1CrIY7ONcFzuDFduAAC2CNApQ6N/MJHVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=ecfhR0DDjKPf8GZXYNeWT7z6v7gzPmEBwwbZ5X5NmfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQCb5cGYAWYiJJpB2NWCVoLKe15dw6RFiQdjqSNd6SjeAT/i6H+hbDbStETa8m7N2ZlMkLtbqCrqVSE9Q7+0ks1tmzJzwntA4SYF75t3FQB/vObg/Ic3ZJHvygzYVZIz96VlpYz6KO2BWZpvGQkLjJ8IroFkDjg0torgSE3NESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR6defhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR6defhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0410FC2BCC7;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=ecfhR0DDjKPf8GZXYNeWT7z6v7gzPmEBwwbZ5X5NmfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TR6defhq4mQo0qsYt8nSFWNZktLrbqrWEeivpzFjVPGC8iwRjUmgdkb4zqSAbm7F7
	 GJq+aldPFOc+R+SRybt/SRDtjSavdUWzfLjUIFsYNSQWuf2BWTupoLGRro9RlKtJFa
	 MiNqgNA68l7ELskkD6LcHzd/kLZzXOa/Qx2sEdVxE3rYRkNNtkur4+yoGUj7ViGj0U
	 Ber4OYWcBvsUC57JW3u7C+Hce5A9ufOexmQ2ouhDjBt/nBncsXSDHGUv4bEiyfXt8u
	 db/jQjbXpBOYy67Zfbr1qTPaEuCJv/dt1h50YDwWD2Cen29YRugaGnHq38CpCsfbYT
	 76TRpkUeRTyng==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002asv-2k9j;
	Tue, 05 May 2026 09:29:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 04/20] spi: qup: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:53 +0200
Message-ID: <20260505072909.618363-5-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505072909.618363-1-johan@kernel.org>
References: <20260505072909.618363-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation to simplify error
handling and to avoid having to take another reference during
deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-qup.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 45d9b4cb75e4..4df01ef2e662 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1071,11 +1071,9 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "invalid OPP table\n");
 
-	host = spi_alloc_host(dev, sizeof(struct spi_qup));
-	if (!host) {
-		dev_err(dev, "cannot allocate host\n");
+	host = devm_spi_alloc_host(dev, sizeof(struct spi_qup));
+	if (!host)
 		return -ENOMEM;
-	}
 
 	/* use num-cs unless not present or out of range */
 	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs) ||
@@ -1108,7 +1106,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 	ret = spi_qup_init_dma(host, res->start);
 	if (ret == -EPROBE_DEFER)
-		goto error;
+		return ret;
 	else if (!ret)
 		host->can_dma = spi_qup_can_dma;
 
@@ -1206,8 +1204,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	clk_disable_unprepare(iclk);
 error_dma:
 	spi_qup_release_dma(host);
-error:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -1320,8 +1317,6 @@ static void spi_qup_remove(struct platform_device *pdev)
 	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
@@ -1343,8 +1338,6 @@ static void spi_qup_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(host);
 }
 
 static const struct of_device_id spi_qup_dt_match[] = {
-- 
2.53.0

