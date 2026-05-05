Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454803DBD7A;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=orOPnytK0yxz5Wm7+g7hK8HoCG9EuCTfwLps7E4skXjZSy4/3RQXrHlaht4tbZif0UNsuAl0lrKYMCrPrRxjS6lJ973N+yGUEiZegwhQvNn3zER5KH/93P6BH2zvg8F0kFVRD6oBztOQ2/qXifdQMqufx5X8Of9TnN5jqYVCtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=OPKjhQeLpDmJwn/0U35NYSrlP9hF2lLUtJLVV+BfiNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj59uQ6t8sWbI2QDJVimol2g+qKf+BE0vcv9wEQNRjzKE8DF4Eio3ZSNYBAXLoKydHqVsH0n/k8CPqjV41Bw3ki+qNs6tLmao21X4wM1ViJbyK0KyZsnGZe5y1KZl2hio6/5kx3z5I7FLDcuviZ+d9C+IgItVs5W6EtH2HtKZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZByWqD4D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZByWqD4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30CBC2BCF4;
	Tue,  5 May 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=OPKjhQeLpDmJwn/0U35NYSrlP9hF2lLUtJLVV+BfiNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZByWqD4DEN/+EZCFJosAK+jdT5h0sj11VSy5zddPQ4GkRTfBYsZpTRqZ9wHIRprJ6
	 xf1GKEkFikpYUM5jLvRVVPk4l1IZBtXVVsVs+cYR2wVM5abIrKzOHt3+hstii8ZVdz
	 Gi+jvK2N/m9CjmCw1TBcBhHDIIzztv6wSsIE3qgxkRg/KAjKu+jUzWiksHEpVlmSXV
	 sDF1rAaPV6u1RoNZtbz3//MYFCIuOqy3ir4ttORiXGEnjmBQ7ANbiCCTug6JdsdLT7
	 Yz8U3oZVfZJMMFX/3dHHoagDe59dYI5NOJvpFeWQ+yNKb3yucdLMUr8kxxCX2kPJ2G
	 WXrtr9hsYMWsw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002asp-2bjZ;
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
Subject: [PATCH 01/20] spi: pic32: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:50 +0200
Message-ID: <20260505072909.618363-2-johan@kernel.org>
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
 drivers/spi/spi-pic32.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 70427e529945..972128271e4b 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -752,7 +752,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	struct pic32_spi *pic32s;
 	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*pic32s));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*pic32s));
 	if (!host)
 		return -ENOMEM;
 
@@ -761,7 +761,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 
 	ret = pic32_spi_hw_probe(pdev, pic32s);
 	if (ret)
-		goto err_host;
+		return ret;
 
 	host->dev.of_node	= pdev->dev.of_node;
 	host->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_CS_HIGH;
@@ -833,8 +833,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 
 err_bailout:
 	pic32_spi_dma_unprep(pic32s);
-err_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -842,14 +841,10 @@ static void pic32_spi_remove(struct platform_device *pdev)
 {
 	struct pic32_spi *pic32s = platform_get_drvdata(pdev);
 
-	spi_controller_get(pic32s->host);
-
 	spi_unregister_controller(pic32s->host);
 
 	pic32_spi_disable(pic32s);
 	pic32_spi_dma_unprep(pic32s);
-
-	spi_controller_put(pic32s->host);
 }
 
 static const struct of_device_id pic32_spi_of_match[] = {
-- 
2.53.0

