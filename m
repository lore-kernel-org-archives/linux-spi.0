Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC62690F9;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=AqcYJHAUZP9dvsiCJOMG2jQiXisH6EYh2C/S3DZA1qHYSeX9FmbNv01EsBxlX5N0RuOdne6iOa3GnaKGtDBpzR6KT/e6UniL5v7u5RIKjRoAllhs1id+ShSY2mEeyghYpO3EXdnrl2iKuDoE3Depgs+4wnIBZ7ocmYm3Grmx8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=plEjJLIpJ7Gg/iQsNUFNDB6cAQEr6Q+aVFvWhC0ddkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiaDhujU2GrRgJqYoob/RlnFOry/P8Un/ATbS6pnUO1FtD5JtQDXMwcvenWhL2TxtyoBmTfHPE8S7AL3HPjOETr0NyXEHFAxE6TYGgFqV1Vy5Iy3wAOgnORgaIkDa1Y239IZzquIlw9B5iXTQcDh8aihGLc/w6TatDc6apVHi3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMaCaZcm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMaCaZcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568D2C2BCC9;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511874;
	bh=plEjJLIpJ7Gg/iQsNUFNDB6cAQEr6Q+aVFvWhC0ddkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMaCaZcmy7SZnIvENxR0TplHY8Bd6sELa2/2QWycnI0uT47aTGNftWNKLh+wMEndw
	 LUM9gcEWEf46HCun+cZYJuxlsU/Xx8Mz5lV/AkHfzOCl5IMHcIb/UF/lPs6aMgA41x
	 S9DX2bvKndLjq+vHAsLYCc0Ud4tWMT9JN7wo3TyZFEls4Ao3B8n/Yrxs4GiXe+2TCn
	 fRGHmZlVidptm6eQH749PiISaNohb5O6mlSzC7B3rcjAxjo1HQz5EZ/mMFHsan/ayT
	 cktoWsg9C7JCqkJi20VYaztN1adD+v6prkmCQyB0jSld9hsK1nQOPMHBmJvLlNnL0t
	 8Xy8uGNJhk7VQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8K-2F8L;
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
Subject: [PATCH 09/12] spi: lp8841-rtc: drop unused ifdef
Date: Mon, 11 May 2026 17:04:05 +0200
Message-ID: <20260511150408.796155-10-johan@kernel.org>
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

Drop the probe CONFIG_OF ifdef which is unused since commit 3974a585be78
("spi: Drop duplicate of_node assignment").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-lp8841-rtc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
index 355d9df4d1be..b2546a3a9eaa 100644
--- a/drivers/spi/spi-lp8841-rtc.c
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -199,8 +199,6 @@ spi_lp8841_rtc_probe(struct platform_device *pdev)
 	host->set_cs = spi_lp8841_rtc_set_cs;
 	host->transfer_one = spi_lp8841_rtc_transfer_one;
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
-#ifdef CONFIG_OF
-#endif
 
 	data = spi_controller_get_devdata(host);
 
-- 
2.53.0

