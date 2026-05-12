Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63946379C4E;
	Tue, 12 May 2026 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572062; cv=none; b=kOeXmHxSOcA3HgF19m7ntG2gU3mfQjPblvH+xOyfxfTmH9212gNtsQrgkqvimkHEiRduM6fzkmBVdlCotSn9HLvW2bKrtZulZY086InuVrQm6UwPZ9LPdh8OtjNv2zrL0dufKIK/8Kw/mWACswJttxPFxDXbAQKOuDqZbQD8Xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572062; c=relaxed/simple;
	bh=0riGnRSiO9rbaxTtAOsD4j5kD6TmNUqgXBStITijX+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3T3qwnQ+Ev9OiDNK345k/y6lvW35iKklbK8EOSLc/6PzsO7mWlKVk695jKDs2N0m/L5xJwODhrXdU63KKbVCNuGhZgPERQHxIe9R3u2eHVlsjMMZMMXoM+PkkG4b0BkvXxc43hqirpz1mBrpwxQtO59tAAGI5FBJyf4PyWPcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1XASieP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1XASieP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C302C2BCB8;
	Tue, 12 May 2026 07:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778572062;
	bh=0riGnRSiO9rbaxTtAOsD4j5kD6TmNUqgXBStITijX+E=;
	h=From:To:Cc:Subject:Date:From;
	b=V1XASieP2Hna3aJX0ytnaSlxgKTqroNSjNmx4MsDToJmoIbRBBsnQ2EzRJqk+AMXu
	 Ff0KjG4+XI1YkDzX9oLS0p71A74gRbQh4NyND+rWxXSb/8I+DNliU9KXGcaRHwVLdo
	 /mGeR+fl49hiZXwSsQmi1kz3NFGat1Woxe4b7OW4VL1wo/wvw46beARGqaf0TvFBuv
	 PbrL2jSSaOCYn/StZpZFExJkRpSfgbnIoL+Olc2iTFWOOpaacrkAXZzb2pBCT7u+s0
	 i+uYBHtKnQVPqtMU1KQ8BdvW/Kh/iJUTADJKY4Jw1D8J55YAUfoIKbmGsvUMBnN8K7
	 fny+Fy1yxq3XA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMhq7-00000003q2j-31E1;
	Tue, 12 May 2026 09:47:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Lanqing Liu <lanqing.liu@unisoc.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] spi: sprd: fix error pointer deref after DMA setup failure
Date: Tue, 12 May 2026 09:47:33 +0200
Message-ID: <20260512074733.915029-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver falls back to PIO mode if DMA setup fails during probe.

Make sure to check the dma.enabled flag before trying to release the DMA
channels also on late probe errors to avoid dereferencing an error
pointer (or attempting to release a channel a second time).

This issue was flagged by Sashiko when reviewing a devres allocation
conversion patch.

Fixes: 386119bc7be9 ("spi: sprd: spi: sprd: Add DMA mode support")
Link: https://sashiko.dev/#/patchset/20260505072909.618363-1-johan%40kernel.org?part=10
Cc: stable@vger.kernel.org	# 5.1
Cc: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Note that this one is based on 7.1-rc3 and will cause a trivial conflict
with the devres allocation patch in spi/for-7.2 branch.

Let me know if your prefer a rebase on top of the conversion instead
(which will result in a similar context conflict when backporting).

Johan


 drivers/spi/spi-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index fd3fd0ce122c..acebf9c2e795 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -991,7 +991,8 @@ static int sprd_spi_probe(struct platform_device *pdev)
 disable_clk:
 	clk_disable_unprepare(ss->clk);
 release_dma:
-	sprd_spi_dma_release(ss);
+	if (ss->dma.enable)
+		sprd_spi_dma_release(ss);
 free_controller:
 	spi_controller_put(sctlr);
 
-- 
2.53.0

