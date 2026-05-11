Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374028B4FD;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=WdDYAZYoo13aAvnnNsu+Gu9vpz1ATRqG+EehwF9t5NUHnVtLKjxV70Q/5ePCduM9Jwne2FkzVfdhVPS3M6jMv++wG7ZeDO+E+hD5x1mGbmH6h/xEZzq4GXcMU1K9jji+1UjuoPtCt93Lzx4dbmET/btVaSg8/M6/xYDJp99yKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=TOt2MkEd5JMN2shwHpmPB8E31K8CfbxQViEW951aFv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtKWV6LeF9guuG07vR9ej1k5W+EES7Jhhn9j3np281yIAz6JXCdQriW03praodeWCc5Bk3LntmZlXJsA4zBJ1J7v7qaCHSx3kRlsi/wMgYtBL82tNb2lvpSEUimYXZMpp1eSyFKtJpKfznOlSW4bmh2YC7NlKnB5aTQAvmR2beg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7Ulge59; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7Ulge59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7440C2BCF6;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=TOt2MkEd5JMN2shwHpmPB8E31K8CfbxQViEW951aFv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7Ulge59yhw8Ksvepkn14yMo1jZSXFUh8u8iOCRCZlJ49bGlIpN8k44YfH17AII3O
	 hRDBBAnIP1cUwyxYRMK32FiBwWTEWwVrRSGRImkqjveteSkyE2pHfd3N4TyE9e+cG9
	 9txqepTMpVF6yrV+aVITec1v/2lchwQcCW7sNBIlNCwoIpNarmCYdxOgcdA9+jq02N
	 qlU6FBzJA9vtrncj9lzV0S/pHTF7Z1Csp03qvF2FjD6sg66ehPyiqk/j8m2d62H7QM
	 cvT+49QRlU4E61PwLXVwU1WZa32zchhdmnFx9BLDoXOdy8ECwEDReZ3VHZ+c3EfB3a
	 EOFlrbxZpj+Ww==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8C-25Vl;
	Mon, 11 May 2026 17:04:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>,
	Yang Shen <shenyang39@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 05/12] spi: fsi: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:01 +0200
Message-ID: <20260511150408.796155-6-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511150408.796155-1-johan@kernel.org>
References: <20260511150408.796155-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation for consistency and to
simplify error handling.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-fsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index f6a75f0184c4..451cb4cfdb9c 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -554,7 +554,7 @@ static int fsi_spi_probe(struct fsi_device *fsi)
 		if (of_property_read_u32(np, "reg", &base))
 			continue;
 
-		ctlr = spi_alloc_host(dev, sizeof(*ctx));
+		ctlr = devm_spi_alloc_host(dev, sizeof(*ctx));
 		if (!ctlr)
 			break;
 
@@ -571,9 +571,9 @@ static int fsi_spi_probe(struct fsi_device *fsi)
 
 		rc = devm_spi_register_controller(dev, ctlr);
 		if (rc)
-			spi_controller_put(ctlr);
-		else
-			num_controllers_registered++;
+			continue;
+
+		num_controllers_registered++;
 	}
 
 	if (!num_controllers_registered)
-- 
2.53.0

