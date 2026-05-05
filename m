Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17C3DFC7B;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=FDbws6r+3acaI0OM4KJCYgm/QDYGaffJRti0lfbwqHJLtdX1RWn8R9lgzzeIBTl1zxvtQ5ib2N8AGODVyA6juv60VdN7HQ3+Oix+LmQC3O2wdDOGX2M/kJkGsbj7P2wjx6heoH0P1/a94Xs4JjxIIfCCvNDhA7Omv90xWE9m24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=SraNUJkTQRHpcBfz8guyzQNXalx3gWHtPFxseAcaryI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYba1abs7KeXrkxtgxyp9CSqoEDpr8IKWPb1ucAgOOLctym8BPJPEOiilSWgrE9AcKm99jxbZSejUR6oX/Jeeh1QeUN2FM4KvKh3LWKsz1EXOTafIoKJOZnt8+O9lw2XLYbxMOeMKCYu+7f0IrMs0GdOYroQwmFn9X/mC8rDkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUhUv8C3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUhUv8C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29902C4AF48;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=SraNUJkTQRHpcBfz8guyzQNXalx3gWHtPFxseAcaryI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUhUv8C3gL9uyFN/DMf8Mfpfu3uoYFyXff0D98ztdNZ1iOYOTAwcYlAXMr8AKK5r+
	 VLi5EGBkYH5ot+mgnNxPi8gQw3wIMoLgVfKeB2YatX40OTzerzvmceOTjZ/AVFZ/lc
	 6HxAavR4w9MQJ8IRkmo6pT3nzMzmlf8cMIS6MGEnC28wX+22w5ujo3y+Rvh2F6kIad
	 Jf5++VFUu6kw7YCu1d7sy5uVxvouHizSe8d1A7HrVHKoWaOOB2RhpVUdtrRRlAGBSQ
	 4BWMrqGL3Phic1I/4831Py36RCqbKAlNR8JeJuXVnNF0LOyNQyQ/LZaOPxbL+PEKuS
	 oEcjgwwyM73rA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atO-3GFx;
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
Subject: [PATCH 18/20] spi: ti-qspi: cleanup registration error path
Date: Tue,  5 May 2026 09:29:07 +0200
Message-ID: <20260505072909.618363-19-johan@kernel.org>
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

Add a proper error path for when registration fails so that the probe
tests for errors consistently.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-ti-qspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 2a8548810f84..6b407c7b5d33 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -882,9 +882,12 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	qspi->current_cs = -1;
 
 	ret = spi_register_controller(host);
-	if (!ret)
-		return 0;
+	if (ret)
+		goto err_free_dma;
+
+	return 0;
 
+err_free_dma:
 	ti_qspi_dma_cleanup(qspi);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.53.0

