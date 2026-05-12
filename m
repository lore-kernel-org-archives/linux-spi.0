Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8832D0D8;
	Tue, 12 May 2026 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571822; cv=none; b=sjCFGlt1OE03ezn718QKg+NeantCdruhFzWEwwNLhhMS+hFaH8MM2mEOBT2TVCo4JcR5ssL/vOslQYOWBH7hXxgeab5o6AC+T5etElmPy6ix4/GFX41igvobbA3TiJgyhSANtJA2NssbPSFesjjM2ngBPWt8TPnmneHqBSvHSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571822; c=relaxed/simple;
	bh=woaHt4DaMyZjdzxtdu5O6w0pKR8LeoODuelJgEYFRoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+RViw/foIZpubuiSDsYxinjDfSg7SsL+92NVYTCxqdyX8pgchZ8tWe9nxuZ/e3MCgrnPSR1rRMm/MLNy2WX5ezgiQ6QWQQr75Xxoqzz6wIh3Q3Gw1eSrKY2D42WeE3MVKa5M8fd/1GOXtgmbmOK8NECPnYrMBNTCvWEgqstIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIF6HVx4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIF6HVx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F248C2BCB0;
	Tue, 12 May 2026 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778571822;
	bh=woaHt4DaMyZjdzxtdu5O6w0pKR8LeoODuelJgEYFRoM=;
	h=From:To:Cc:Subject:Date:From;
	b=RIF6HVx4LZK6H3eYGkJQ/ZstG6dlV0gBEfUNAHBMowZzDH42IQvCA4CMnw+TBtt/r
	 4jZImovTlE2uR24V/HSZCSo7Be/JLZk4Djqc6HSyqMIYQD8XiJXHs1B4rWtUftkJ2s
	 L3Q09gnuRCLzFv/HgSwXXpqspAyGyvI307ZH5E66s9iltiCUXAkNfx1D0pF0/t9uq8
	 6X7JpDLbtN4Hkfrmbn0W9dA05NxJc8bDafhdm2XuprOfbuwI2ZS4r4niqYm1fK24n2
	 Zf4rLeTBVE2HoAvjA0mgl4RIzh0wu0DO/p4EMuPU/6Kp/SS4hf5VZfYCHjesGo8cin
	 BSc0MW2YCCVgQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMhmF-00000003pxy-3cfR;
	Tue, 12 May 2026 09:43:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] spi: qup: fix error pointer deref after DMA setup failure
Date: Tue, 12 May 2026 09:43:34 +0200
Message-ID: <20260512074334.914735-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to the clear the DMA channel pointers on setup failure to
avoid dereferencing an error pointer (or attempting to release a channel
a second time) on later probe errors or driver unbind.

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: 612762e82ae6 ("spi: qup: Add DMA capabilities")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=4
Cc: stable@vger.kernel.org	# 4.1
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-qup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 45d9b4cb75e4..50bb7701b9d5 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -996,8 +996,11 @@ static int spi_qup_init_dma(struct spi_controller *host, resource_size_t base)
 
 err:
 	dma_release_channel(host->dma_tx);
+	host->dma_tx = NULL;
 err_tx:
 	dma_release_channel(host->dma_rx);
+	host->dma_rx = NULL;
+
 	return ret;
 }
 
-- 
2.53.0

