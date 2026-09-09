Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54F55409C;
	Wed,  9 Sep 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965803; cv=none; b=Z8JkAtrLi0D3l/vSgki8tlfOoWHnyZjFwQtB5hXOOro482TrsZ8GwfWfPU3mdaALtSV9vlYwEw4SWAdS5/Ohj5zEr+4EhjtssT4cJh+50gy7xevmzs4THQgXkdCqXg0xZPnREZh+ZmPj6S5KOaaGODXchHFjsw1iLn/76cTNai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965803; c=relaxed/simple;
	bh=PnJBgVnbIgcWLNLYch9cQewKsDFIC4Led3KTymkokH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfYaXUsMsEKzVPxyff5yYbJLSzqJrd+tdyJvxsIyhZZSc7UvlcPXZronq+bOqBiL20xZ8a0bNCiuHFMO1VveTHvbKu8DWcMHmxVmLbWwv8f6/K8mgS4JefFJifMAQG+4W/6lwhSKPp85Hv1Ydh25ZsK1XzP7i6p5qjlKbaPxL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgAjzxW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgAjzxW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB591F00A3D;
	Wed,  9 Sep 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965801;
	bh=xQvqh5V0jEHbs9qUBqtF9FaB1INU8MfQPD5WaPzmvXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BgAjzxW9oTcmnwHg/oM/xjTLyIDaxl7iX4kw9aix5b+MeuTyqn/eJJahgw5PKt6Ga
	 /kQcnUYjaa9xomM5KEVrNN/kexYLL1sMWt5IHHqlxP30pDTQoTTdHjDx2oKF/udBKv
	 juJiXeR40VraItdO5rHIEiE5/aqxSuVgNskyTQfBTrNR9q0wi4hj8iHOnqWtnzZGjA
	 bYXupBcRjhQDQdYUEqynIP77PHULgPXZl43Wo2PtYtb6n/aUPtTCrBqbCSYZ2R0ZyC
	 D9+61p3qkIICqvg37w1/hKWPQzSkLau+lrJvWjtO9/afYZXYb7CAJiDiGT3+uXNAr4
	 mQNHE/C2qQPZg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] spi: dw: use DW_SPI_ISR directly
Date: Wed,  9 Sep 2026 22:36:48 +0800
Message-ID: <20260909143652.9234-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260909143652.9234-1-jszhang@kernel.org>
References: <20260909143652.9234-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DW_SPI_ISR register reports the masked interrupts, no need to mask
again.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 206d3f9dd83d..1c060f0ec50c 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -275,7 +275,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct spi_controller *ctlr = dev_id;
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
-	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & DW_SPI_INT_MASK;
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
 	if (!irq_status)
 		return IRQ_NONE;
-- 
2.53.0

