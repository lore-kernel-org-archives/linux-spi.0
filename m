Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF333DDDD1;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=VqQveuiLtyXyYbA7Ov6hWTKJQijLZJHUVh8DHEDXp8znohLXK6gD47t2PKI6pPTs59WBELGuWKNhWsz8a0Xg4b9uydhZtv7CRnBA8XF48qft7xY3njkjSzrmRDkpMInHDcWXHSqAPmNEuQmud7Q0xP98pSzXp9ME1ScuMxJxjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=c+R6CFjXbtXJOAEf9CQeUXizCxetpWosBkHOEcwoOCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0gZtKCUUOcjIxxifyzk51Lu9l9GjhuW674EmP+tTI5I9Yc/64KaNXqwsOE3BUhP0l9prXV9o5aD6m21W3mII/dVjUM0aCmnq7tttAnxlom81c+ZlPg2J9iw2ynJdZ4ZOvjI/I7AO8I7IJ03EoaXgpRJtepMnVEh/uDQ/Ph0zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scjoFFcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scjoFFcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E203C2BCF7;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=c+R6CFjXbtXJOAEf9CQeUXizCxetpWosBkHOEcwoOCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scjoFFcr/mxbVZoKnaSuXw9mm+NdrM8MMz828bKtoYNluJ5S16LBtR7UCeLj4GUA3
	 pRAet5MoTF4wvVIfqO0UtE1WfsSYxK6HHeh8V+7mzytLx9R0e9aFKHChifYsOFLF6g
	 5Xn9WirxOj20piAkreoVAukqoTcwDn2JyswNSrGJ9MrSXD4MLX3ojPH27Y7DLyPIcB
	 72ktmTO0gzkHfgplpmjjomuRtnzRrCoDEiIELgD4G6aU+A7VS364NOcYDtsqAr0kiv
	 HyFcnoiCWN/By01iXh2MznBPiC2iUTJrVRV7XfpEWgLPoal9bPhsBh5nfHlVpd4sy2
	 yrVIsb2lPSlVg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002ast-2hgS;
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
Subject: [PATCH 03/20] spi: pl022: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:52 +0200
Message-ID: <20260505072909.618363-4-johan@kernel.org>
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
 drivers/spi/spi-pl022.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 9c0211f94fd0..95652df5fd09 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1868,7 +1868,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	/* Allocate host with space for data */
-	host = spi_alloc_host(dev, sizeof(struct pl022));
+	host = devm_spi_alloc_host(dev, sizeof(struct pl022));
 	if (host == NULL) {
 		dev_err(&adev->dev, "probe - cannot alloc SPI host\n");
 		return -ENOMEM;
@@ -1907,7 +1907,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	status = amba_request_regions(adev, NULL);
 	if (status)
-		goto err_no_ioregion;
+		return status;
 
 	pl022->phybase = adev->res.start;
 	pl022->virtbase = devm_ioremap(dev, adev->res.start,
@@ -1984,8 +1984,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
  err_no_clk:
  err_no_ioremap:
 	amba_release_regions(adev);
- err_no_ioregion:
-	spi_controller_put(host);
+
 	return status;
 }
 
@@ -1997,8 +1996,6 @@ pl022_remove(struct amba_device *adev)
 	if (!pl022)
 		return;
 
-	spi_controller_get(pl022->host);
-
 	spi_unregister_controller(pl022->host);
 
 	/*
@@ -2012,8 +2009,6 @@ pl022_remove(struct amba_device *adev)
 		pl022_dma_remove(pl022);
 
 	amba_release_regions(adev);
-
-	spi_controller_put(pl022->host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

