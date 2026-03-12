Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38B38644D;
	Thu, 12 Mar 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328886; cv=none; b=YgHQW2saQO7lJ/C3qsiEhzTxbnbUvc6maOIuigP+hQGxk4+TDa7lEvarqZPZN20WZvpIgeRW6MLEKel4N1vOD8n9hehOt/pk3YLzQ+S47KazDJUeDmfuRsNkqCwTjY5QRe8Ane2LNmI6e/AEPeVTSsSFxOv7L+6FxewjdXpVAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328886; c=relaxed/simple;
	bh=q3C/TW3hm+3wqtymCwQ2XcmPn7fC4hetmhRbMH7WDk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsfSEbo/nrKrWuAvdZIhfFHV5WUcembclu1agGdSCwhS3QuarC3Ke2I0e0FzX2nzITPBP8WKSkiuXtcc0jQ/dB7RR9+ORaZVBaLRCKGbtUXbMzNtbSCkId4jkgX85R04vTkknvRQh5a3vK4XZWnhHpmFUzmOMAdWs1zsXVPWtnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJVVjdmD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJVVjdmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16E6C19424;
	Thu, 12 Mar 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328886;
	bh=q3C/TW3hm+3wqtymCwQ2XcmPn7fC4hetmhRbMH7WDk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJVVjdmDCWlJZ8C6QOHl31bJ4MRHTLTsOM5l5MwNetIYbBztnEU36xMH1mXO3J5Hx
	 XVOiKq2DDfMQThLvslqo0Zf2IcMX37uve5bA2zZhrZ4zo3vkmP3h/jvAoIy3lOX4Xy
	 o6G4fg4aBS65n17zT8UyLIyzG5km9KKjOIxKy7vSCaqqDeCwG4SycaBY3muTGgcJnq
	 zhw7q0tdRUppdJJF0LqE3amVHwnpuTw4s/oLodHXovKPoSKA6fBJpEZ2UAdbNuQgd/
	 M6OdstsnyDoIVZ/deT1NDXzIHetUIrOZrE8djjWvfgdHap7GurFT5tsGEK4jYCUSfa
	 AJ6wM5rDSXRkw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0hql-000000008Pc-3e1C;
	Thu, 12 Mar 2026 16:21:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/5] spi: fix misleading controller registration kernel-doc
Date: Thu, 12 Mar 2026 16:18:16 +0100
Message-ID: <20260312151817.32100-5-johan@kernel.org>
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

The controller reference count is not decremented on registration
failures (and has not been for a very long time) contrary to what the
outdated kernel-doc says.

Drop the entire sentence about return values which are now documented in
the Return section.

Fixes: b885244eb262 ("[PATCH] spi: add spi_driver to SPI framework")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bfc42b75549a..34aca18a96d8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3388,8 +3388,8 @@ static int spi_controller_id_alloc(struct spi_controller *ctlr, int start, int e
  * device identification, boards need configuration tables telling which
  * chip is at which address.
  *
- * This must be called from context that can sleep.  It returns zero on
- * success, else a negative error code (dropping the controller's refcount).
+ * This must be called from context that can sleep.
+ *
  * After a successful return, the caller is responsible for calling
  * spi_unregister_controller().
  *
-- 
2.52.0

