Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480923E5EEB;
	Tue, 14 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174341; cv=none; b=ZFo0YgANmKAdnPw/Ahc8nQqszHrxCte2L+wI55dLn4tx6Jb7xzpn6j3CiJCQWL2sOps0kGWbGyTwv82LZxZYOCfPwgfBmziGCoSN2zP8YMbB68X27piNsyu1AHGrUN3QbnMLsRO4Y3kyZP/jUiCceSzza7IKjVjXFUfr9Sg4oXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174341; c=relaxed/simple;
	bh=4nKgB30aIB1s3NYaScUwvoYU2iS+p8ZIb14gvBLmDNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dV8rTDJ3a4zGr+yHN4BPl7CVEdelEP2GlwiuBskShyptgqlYaSxwkMMiOuLJpTpaRG7MBTGeKRRJtsVwAjb2d7wWI6Qgdo6RsrqoTqoigJXsEXpSaH7x22tJxXnfMWZIRwubir9TRrRcW9BJFxUZiKi09U7cGilUV78wSJ1Roko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2M4SH8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2M4SH8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D8BC4AF09;
	Tue, 14 Apr 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776174341;
	bh=4nKgB30aIB1s3NYaScUwvoYU2iS+p8ZIb14gvBLmDNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2M4SH8BRF136MLoSKABQEd27GsZu/ZzEPogW7ksLBwuFaSOpbXatjuQRyQggFS6a
	 K0FkCpHISvstwBH5n0cTKdKwN7Q72ba3fH1ZPmTfTVfqEbChA0PC3oFrQ1HQlOF0lu
	 2gFB9IkFdVNd2+XFUb6IaDl8kif/8jb/tCW8NFS18WRgu7d1pQvIwXgEdrNh1lLdcF
	 Mxe5++iGJfFWtlmqsUfFTiBhdLZpRH/+uGy09T5V67T1mW3bliJSr1OemFiKRYHzV0
	 Ig88iL1IeFW+NYN3XE4ceKRh1pclIDO7V/VKJscJ/pjNbvHwuN5JAb8y0VHLSIHOvu
	 2e35mzU0N8fcg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wCe5C-000000046Vu-2xSf;
	Tue, 14 Apr 2026 15:45:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 2/8] spi: cadence-quadspi: fix controller deregistration
Date: Tue, 14 Apr 2026 15:43:13 +0200
Message-ID: <20260414134319.978196-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414134319.978196-1-johan@kernel.org>
References: <20260414134319.978196-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before dropping the reference
count that allows new operations to start to allow SPI drivers to do I/O
during deregistration.

Fixes: 7446284023e8 ("spi: cadence-quadspi: Implement refcount to handle unbind during busy")
Cc: stable@vger.kernel.org	# 6.17
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2ead419e896e..50ef65fc5ded 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2020,13 +2020,13 @@ static void cqspi_remove(struct platform_device *pdev)
 
 	ddata = of_device_get_match_data(dev);
 
+	spi_unregister_controller(cqspi->host);
+
 	refcount_set(&cqspi->refcount, 0);
 
 	if (!refcount_dec_and_test(&cqspi->inflight_ops))
 		cqspi_wait_idle(cqspi);
 
-	spi_unregister_controller(cqspi->host);
-
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-- 
2.52.0

