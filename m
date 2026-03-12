Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC4391856;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328886; cv=none; b=t5HabNDSTMsVVv7tARZw4CrNvFkfnUUd+0HGKWiSsKsoI4MWLLm/y6/Zp2tGuHvLxhym6wRJNzM0ZtO4VXrMLBHZOnnFeWs0MmgGq9+RVat/DjlRNDERJatKGovz9RH7mjiFsBJng7ewJRYyYQRO+HWmwWBaugqrFyY9M1VSPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328886; c=relaxed/simple;
	bh=PWwFJnbWQC7RH+lSsXxqshJAP7fO4Wnei7MnG0HWrKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpJZpB/kagSs90waU61mTT4xJpN/meq73Tuzm9Dt4rCzMaOsOwfMhsSQC4ptXnkIU5BEZj6DWDTd8FQHhIGa0zfLIVMBByLE9w0L42aH7gm72DFcXfD17URUBCv2Bb+XaA95/XwjN7IB5t2ZZyGKTVPL//mX/Nn5aUufBilggkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vbbd1dRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vbbd1dRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7F3C2BCAF;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328886;
	bh=PWwFJnbWQC7RH+lSsXxqshJAP7fO4Wnei7MnG0HWrKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vbbd1dREG17Vg8V2cC1PoMH4C6AjTSKVBMVuHy0PRK9E3pqBkqxPhJO5BbqNN6/V5
	 rZuXQQr8CM0CpoEo54f3MINrRlojH5nAEAvmgC2vncHW8CYFTpFL9Ix+Cqpm2O613D
	 R8Ktvii4+NzLXt6/oBqWOkEC2jVwZEke0VWDmsAX1/0sfUzrnLmgRlE6AkCUpo1WIR
	 Ao5sWF6EF2Y7oALiyWxAYeOYkJO6DQk2WfWPiV0L+sv9I8VYABQH3LF7wcnwMIhtb4
	 +5RogfRc/LWgfKbg9lN/y6Srao5c7WfU+jgG8RCAAP52ZJhkpMBEJ9yWTBni/ZNAh1
	 cE4PxWTBPhXoA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0hql-000000008Pa-3bcb;
	Thu, 12 Mar 2026 16:21:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/5] spi: drop unused devres statistics allocation
Date: Thu, 12 Mar 2026 16:18:15 +0100
Message-ID: <20260312151817.32100-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312151817.32100-1-johan@kernel.org>
References: <20260312151817.32100-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the now unused device managed per-cpu statistics allocation.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 53dee314d76a..bfc42b75549a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -96,25 +96,22 @@ static ssize_t driver_override_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(driver_override);
 
-static struct spi_statistics __percpu *spi_alloc_pcpu_stats(struct device *dev)
+static struct spi_statistics __percpu *spi_alloc_pcpu_stats(void)
 {
 	struct spi_statistics __percpu *pcpu_stats;
+	int cpu;
 
-	if (dev)
-		pcpu_stats = devm_alloc_percpu(dev, struct spi_statistics);
-	else
-		pcpu_stats = alloc_percpu_gfp(struct spi_statistics, GFP_KERNEL);
-
-	if (pcpu_stats) {
-		int cpu;
+	pcpu_stats = alloc_percpu_gfp(struct spi_statistics, GFP_KERNEL);
+	if (!pcpu_stats)
+		return NULL;
 
-		for_each_possible_cpu(cpu) {
-			struct spi_statistics *stat;
+	for_each_possible_cpu(cpu) {
+		struct spi_statistics *stat;
 
-			stat = per_cpu_ptr(pcpu_stats, cpu);
-			u64_stats_init(&stat->syncp);
-		}
+		stat = per_cpu_ptr(pcpu_stats, cpu);
+		u64_stats_init(&stat->syncp);
 	}
+
 	return pcpu_stats;
 }
 
@@ -574,7 +571,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
 		return NULL;
 	}
 
-	spi->pcpu_statistics = spi_alloc_pcpu_stats(NULL);
+	spi->pcpu_statistics = spi_alloc_pcpu_stats();
 	if (!spi->pcpu_statistics) {
 		kfree(spi);
 		spi_controller_put(ctlr);
@@ -3194,7 +3191,7 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	if (!ctlr)
 		return NULL;
 
-	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(NULL);
+	ctlr->pcpu_statistics = spi_alloc_pcpu_stats();
 	if (!ctlr->pcpu_statistics) {
 		kfree(ctlr);
 		return NULL;
-- 
2.52.0

