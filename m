Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E121386446;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328886; cv=none; b=cc7LU+2YnnvQwQitbEfrTJfPDOnGlz59OHAL/xeffDcxAT2+E5lZnahux7UE0mDBhkbMnGQv/sHXAKepP5Z1B6F6DB1E2hMLZaRN+PuJOX2RpAuzKsMaZJxVbmvk+y35tthHAGvXNvZbSOc0wfw5JjWQpBtqvB6GFZsQC53acIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328886; c=relaxed/simple;
	bh=X52OF9MemHaAxpWAJbwJ9EXaiXR/WGE6scVInXZuSew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rls9WXq1ZIRBAKKDfany/F03eYdx3ZtOZix1FlhW6tttchqmLH6bZCk8VNIopI1XdMScu3/yb+8HMGPvFK5gX3QiQzm+9AjgDuyx4WerzYLIIuKAXvGdgFYj6XPIkrC06Xziyp9tGEfhwuQwuvjPSPq3v2OylQaJlCZ+dKQvRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abF9OwAt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abF9OwAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5EFC2BC9E;
	Thu, 12 Mar 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328886;
	bh=X52OF9MemHaAxpWAJbwJ9EXaiXR/WGE6scVInXZuSew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abF9OwAt1xs2HLLFcVc4rYuvPo/TfegISJQD/0YvOUrOw0J1a5Yz8dImeaxhuh+I6
	 dPjODEENUyG8uMDXmQG9pdXh1PQQc9BWFfC65Eba9lhETGmNvkHLjGUKL7HW86UBf2
	 3Y+iTO+B2n5I2Vc0Q3Ktvlm7DB41V9lylAHTHeT8RyFBUEIwA5IxonnaRCjN2UoBRv
	 yN6vfMV6FFCXMblQ1c2dinqk+Q+avKWVBDiOT3xIe84+7Zpd/txFBE0ivotjMODfmf
	 6feMw7VHNwPo0PYGwDrayuLn2SxFfI4iaMqinigiGOis3eGd23A3iDKPMAE9v8csm9
	 RsGX2jeIqeBZg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0hql-000000008PW-3Wpi;
	Thu, 12 Mar 2026 16:21:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	David Jander <david@protonic.nl>
Subject: [PATCH 1/5] spi: fix use-after-free on controller registration failure
Date: Thu, 12 Mar 2026 16:18:13 +0100
Message-ID: <20260312151817.32100-2-johan@kernel.org>
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

Make sure to deregister from driver core also in the unlikely event that
per-cpu statistics allocation fails during controller registration to
avoid use-after-free (of driver resources) and unclocked register
accesses.

Fixes: 6598b91b5ac3 ("spi: spi.c: Convert statistics to per-cpu u64_stats_t")
Cc: stable@vger.kernel.org	# 6.0
Cc: David Jander <david@protonic.nl>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 61f7bde8c7fb..9b2e307dc30a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3480,10 +3480,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 		dev_info(dev, "controller is unqueued, this is deprecated\n");
 	} else if (ctlr->transfer_one || ctlr->transfer_one_message) {
 		status = spi_controller_initialize_queue(ctlr);
-		if (status) {
-			device_del(&ctlr->dev);
-			goto free_bus_id;
-		}
+		if (status)
+			goto del_ctrl;
 	}
 	/* Add statistics */
 	ctlr->pcpu_statistics = spi_alloc_pcpu_stats(dev);
@@ -3506,6 +3504,8 @@ int spi_register_controller(struct spi_controller *ctlr)
 
 destroy_queue:
 	spi_destroy_queue(ctlr);
+del_ctrl:
+	device_del(&ctlr->dev);
 free_bus_id:
 	mutex_lock(&board_lock);
 	idr_remove(&spi_controller_idr, ctlr->bus_num);
-- 
2.52.0

