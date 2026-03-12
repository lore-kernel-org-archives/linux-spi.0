Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C538552A;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328886; cv=none; b=f5oQt6Y6e0JiU+4rzy7kNAHyUGazeiU/vg/o0/Dl/bjZBa44m7qsiP9Oc5Swq+wh1HOD8F1Ln+4TIMgDTirB+ZDJsAafpWoqRGqXvk6dpDDEKwWUVUFvc+9wsUywQRCeM6xncmOlQPNYpLpjWLoIh2WlWGducI/bVBDvPZGFnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328886; c=relaxed/simple;
	bh=RUadj4HhKnVqicgv+dQt/skm0MEJJiaogxW6KV1m028=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBd1cK2CbTXyHllxA2P6tWLIxslVUJUTu9Ho91MLZ39t4iRSmzhIemTeQMvVrM1RxH2ontY3hMStJyzQIqEOEVrepfwGnJsaPTLt9oBgU7B8bY37QYJxD1wN8Yw7EG/mpDo7LHSuRcqWzO4YnkiJQARK7F5haveoHChnZ25Zx2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDk5uriZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDk5uriZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE49C2BCB0;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328886;
	bh=RUadj4HhKnVqicgv+dQt/skm0MEJJiaogxW6KV1m028=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDk5uriZpRK1M0qbSsxGy/elVNlFMOE5F1NZy5P3raa9wmmk6fL3M6avNBSoFqRBb
	 MkSwjnhKkb1/zShTBmbhwpeiARfJqvgY+MK5geysUTNN4Vx2SW9PG+JzEwZbdnygUM
	 PkWHKOAjEq3mCQxSBksrKQhLuYRHj7mMakALeHNWSJaRI6aZg7Yu3G0hd8M4/SJ77H
	 MDHwmT5At3LMgnyLUkgX5ILNNq02iFlf8moqHq3fjm2ytolSwz4HeXZ/PPEUJP9Isn
	 iQA5WFFv4pE4yZsGvmAWih6smP6kbQe8KWaYaTisnWGfvoLW+9D/WE/nwfM9cJ8ibO
	 uHg8CROcNQT9A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0hql-000000008PY-3ZHm;
	Thu, 12 Mar 2026 16:21:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	David Jander <david@protonic.nl>
Subject: [PATCH 2/5] spi: fix statistics allocation
Date: Thu, 12 Mar 2026 16:18:14 +0100
Message-ID: <20260312151817.32100-3-johan@kernel.org>
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

The controller per-cpu statistics is not allocated until after the
controller has been registered with driver core, which leaves a window
where accessing the sysfs attributes can trigger a NULL-pointer
dereference.

Fix this by moving the statistics allocation to controller allocation
while tying its lifetime to that of the controller (rather than using
implicit devres).

Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
Cc: stable@vger.kernel.org	# 6.0
Cc: David Jander <david@protonic.nl>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9b2e307dc30a..53dee314d76a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3049,6 +3049,8 @@ static void spi_controller_release(struct device *dev)
 	struct spi_controller *ctlr;
 
 	ctlr = container_of(dev, struct spi_controller, dev);
+
+	free_percpu(ctlr->pcpu_statistics);
 	kfree(ctlr);
 }
 
@@ -3192,6 +3194,12 @@ struct spi_controller *__spi_alloc_controller(struct device *dev,
 	if (!ctlr)
 		return NULL;
 
+	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(NULL);
+	if (!ctlr->pcpu_statistics) {
+		kfree(ctlr);
+		return NULL;
+	}
+
 	device_initialize(&ctlr->dev);
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
@@ -3483,13 +3491,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 		if (status)
 			goto del_ctrl;
 	}
-	/* Add statistics */
-	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
-	if (!ctlr->pcpu_statistics) {
-		dev_err(dev, "Error allocating per-cpu statistics\n");
-		status = -ENOMEM;
-		goto destroy_queue;
-	}
 
 	mutex_lock(&board_lock);
 	list_add_tail(&ctlr->list, &spi_controller_list);
@@ -3502,8 +3503,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	acpi_register_spi_devices(ctlr);
 	return status;
 
-destroy_queue:
-	spi_destroy_queue(ctlr);
 del_ctrl:
 	device_del(&ctlr->dev);
 free_bus_id:
-- 
2.52.0

