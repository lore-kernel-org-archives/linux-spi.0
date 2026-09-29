Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E1524AF9;
	Tue, 29 Sep 2026 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685498; cv=none; b=kOvnrKMBmmQbgbEutQbwXzZsJT2SwIuELGs7ft0G164KoKdz9LSHhFiPpldDCx3Y4qmG4j/URSldCIl4j0E+CFTgtOjpRMcoanwnrHi6zFJppicVo3V9JE+7qKqcAyveC6gt4DluFcNOfq+G0c288oVt2XrLtzktbQvzGjL4pxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685498; c=relaxed/simple;
	bh=KFTyLKUyX4zP8QpdqjlR7ZkyMKM4k7B/cpIbOdWCqCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMh8A5EKMpk+DoP2E4y9kqViTJtgtUDzL41gOmyuuNcqFJQgF750OEeCRYWJAoZAIjFoOehEFsD570h5keudnfJ+23GU4U9mooo7dgzNIpkKREl9l2B9BNDZ4bOW8E/MhZyHUZPYkaLNyh40oy4R1crmjBCcJehBgoh04DA+6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5sCsvBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5sCsvBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2861F00893;
	Tue, 29 Sep 2026 12:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685496;
	bh=neytlIQXdUaSH2YGaKdqCIIZLNyrglaw5V1+1H8MeMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5sCsvBlrUPNRmrKN5CgO2xwlg0B40eO6Y/wOo8c8UMxHKD0QHrJGm8rf1DPZdVCi
	 XGClQKYeJ4FBu6BaB2tNE5nKv6Dho/hhiTkyLKcCjDojmw3sYRNlPtjOaCvwujVMRS
	 Zci6oIq9KQzcX+qo3thAb4Twd5ry7iEbQLy2kWACLRXw+wlbbuZAs8eUTa25YS0hMO
	 vFI2PZuUmHiBwL+2se/ESEK+w1IKghzSQDJM8EffilxNgyUY2AXoDdYKoygScO54iF
	 ofxKPeXRyDl6gOaYT4StcxmfI+R2eqqFqbd9rzgGmPcEFV70FvfrQSEZbH6lB3TRaf
	 9vjz60EsicYZQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
Date: Tue, 29 Sep 2026 20:18:15 +0800
Message-ID: <20260929121817.20896-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929121817.20896-1-jszhang@kernel.org>
References: <20260929121817.20896-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dw_spi_irq() need not handle enhanced-transfer's "!rx_len && !tx_len"
case as that state is already handled by dw_spi_enh_handler()

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index f4c4e9dae25e..91de357f97f3 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -284,12 +284,6 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 		dw_spi_mask_intr(dws, 0xff);
 		return IRQ_HANDLED;
 	}
-	if (dws->transfer_handler == dw_spi_enh_handler &&
-	    !dws->rx_len && !dws->tx_len) {
-		dw_spi_mask_intr(dws, 0xff);
-		spi_finalize_current_transfer(ctlr);
-		return IRQ_HANDLED;
-	}
 
 	return dws->transfer_handler(dws);
 }
-- 
2.53.0

