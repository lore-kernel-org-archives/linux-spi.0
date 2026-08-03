Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F40313531;
	Mon,  3 Aug 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766741; cv=none; b=fF/WSHnejQQI5fnDcLRYJC2ixJjffLaWSdVBbtIbzbngQK6oSPRgsqhRyrdIQdRQgYj7KfBKxNj9nEmosIYtqeX6cYwXnL11oEGrBcGhMtbVrTZm9b4g6wb5BcDNiy5omCFLnwZ3YJbE4/i0Rb/Mwbz4byEZFVJI+vI+GzBAhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766741; c=relaxed/simple;
	bh=tT89kEOrGkasZT/23MSY762HUyJrpQ8U04+YnmASHxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/5l7cK4ACNSBMQxeIuo9bX0jDVGTTLBfR9qRswB5vmGannwFfoVGOAa8tiPL2GijYuGKmzCFAkGWX2ASKrWr1jlvcZ6WLhlW5/E5gHk0hwPodvSydaSg7BJkQhCPQLXpbCYNQVBawvT5L2N2qvOk6LmSbTpM6NhDfse3mvavtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h826sJaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h826sJaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06661F00A3D;
	Mon,  3 Aug 2026 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766739;
	bh=BLhHQgP0J2/gm7jobn2VN4LsgI9MYLQocCCLjPWs4eQ=;
	h=From:To:Cc:Subject:Date;
	b=h826sJaY4IX5VbYALPxa1D+qOxqJ4yrUEV8zy4nVy4BUeUKmq0zGKDiRL5YvvGYHG
	 RfevMX5Y7ITrvUPNc5bfZ1tgGwyox71++lNlCnp/VWX6EPGCoHZa1dJQL8l9ClyXka
	 cgExaGvHsKu61fvPgrjEv1RbLVCgRmqkKV1CFJq6GCDNXZ1dRLXp54faO0URH/Nd2p
	 0GHvjzX30V+LktaFWqGpmBXPxCwJ80Ps637DDVCx/DZXzPiCAIc8C5Pd3G3xntbjl9
	 XG+AiSwd+mUiLLwWRbgeNYG4jRhkQHGEgJQJ8U+7QRrl9AV1cHAROxcDLTBTKI674u
	 U+MUVBtF4GI5A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: fix wrong RX_SAMPLE_DLY setting after resume
Date: Mon,  3 Aug 2026 21:59:25 +0800
Message-ID: <20260803135925.12622-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms which need a non-zero rx sample delay, the RX_SAMPLE_DLY
reg setting is lost after resume. The reason is that the reg may be
reset to 0 after resuming, but dws->cur_rx_sample_dly doesn't know
this fact. Fix this issue by clearing dws->cur_rx_sample_dly in
dw_spi_shutdown_chip().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Suggested-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 2f2debc64e73..a9d055f9c5dd 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -283,6 +283,7 @@ static inline void dw_spi_shutdown_chip(struct dw_spi *dws)
 	dw_spi_enable_chip(dws, 0);
 	dw_spi_set_clk(dws, 0);
 	dws->current_freq = 0;
+	dws->cur_rx_sample_dly = 0;
 }
 
 extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
-- 
2.53.0

