Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2D3C9437;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776046; cv=none; b=eRoF6CNutszNvmPI0zsPJyKpmS4L4mNOIlnht0En5ZANg7jxvOF8GraU0oLMt8ic+MloCKbppzRFwYpvSfHmFFrkCREyFMwXzRi/v9ob1BrSMZV6pMqAfFauleAOYZxHxgH+o89rA6EIHANgkqjf1gBqWbwzasb56xPtvzFfQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776046; c=relaxed/simple;
	bh=GbVUyYwVI6NJo7Uo7ArYE4f8GvPxrWAa5auzbEce44s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYzK3Ml2OoPB5vmtCP2lE4qztarv3DlF9wZIpKCI24Il246zBJpV9/SypfSF8DKdHJkB8nhI9mZAmAGb36B/DfKT6+4G5HQmoCAADdqtnekslsXlj6ElUgGZ1FtiisdemXVz4/XoSttQjsxypRlF79EHespt2/ySZeI4X26ZaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnRASV1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnRASV1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2383CC2BCB3;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776046;
	bh=GbVUyYwVI6NJo7Uo7ArYE4f8GvPxrWAa5auzbEce44s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnRASV1ee/919RMT40nNzpMsCFMDXKhKWF5ejLpNgPietiL5rXH7zoUjEWLY7TYKH
	 66PV5VtpsG14cxoda9i0/729ZAcmecWofkUBIy8U+v44dAvC7qoaoSNpodZyrEgxWu
	 7vmShrwRu5TE5ayNWTVpKIYubQpGtTasBzASGCmN6odq718qDhuuUSAxZNiNGGnkCl
	 u6AGC4bBK6VXwFBZy8xDLhkFGcU6X0uTKihHBYmCtRfk0FHxb98AhyBao23wHf+6DO
	 lCKdCGL0U0hERHS1mdhcIyxHyCeuETo4tHK04GfjTJY+O8d0Gum4LSx2WLemFIMc83
	 olAdvZioKOOhw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAc7-00000006RIS-3w11;
	Tue, 21 Apr 2026 14:54:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Anurag Dutta <a-dutta@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] spi: cadence-quadspi: fix unclocked access on unbind
Date: Tue, 21 Apr 2026 14:53:51 +0200
Message-ID: <20260421125354.1534871-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421125354.1534871-1-johan@kernel.org>
References: <20260421125354.1534871-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that the controller is runtime resumed before disabling it
during driver unbind to avoid an unclocked register access.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Cc: stable@vger.kernel.org	# 6.7
Cc: Dhruva Gole <d-gole@ti.com>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=2
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b79f48f2420c..87dc14c53675 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2028,14 +2028,13 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	cqspi_controller_enable(cqspi, 0);
-
-
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		ret = pm_runtime_get_sync(&pdev->dev);
 
-	if (ret >= 0)
+	if (ret >= 0) {
+		cqspi_controller_enable(cqspi, 0);
 		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
+	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_put_sync(&pdev->dev);
-- 
2.52.0

