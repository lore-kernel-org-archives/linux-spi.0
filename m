Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698F3D567E;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776046; cv=none; b=B2SIW4b/A9VmVRR9mQhKQRx5F+9LTjZ7njAjKbS1n5NrnFuFQNltER12MS0D9SvdZBCj37VDihcMut1dmkZh/Wzxh2201nIGhnXNtc+5Z6oyDno/G3zasH/HNmXVrnvTLqyUG7iUkE1mGcVWvCxPRVHF+uITRqEsnET8mxYEdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776046; c=relaxed/simple;
	bh=F1iHgRyYYUbS5G1p57lmuDMTMSEfEjvu3nZIostYLD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+IvbjmcECpWR7Y3fVK4c+e18kiLBDZvxjpo52Jrh+LdbVYgCmZ6xZ9sv9MUlahp7/3gvrx734mVfDHXx4ihoE2PhDL7NYMrNSAH885cdaGOE1/6unzZFJGvfEaMr4pokjvI7+xxunllkysBOvaY4xxesSEWc+swzI+o0aw2oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuIOJXIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuIOJXIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2D7C2BCB9;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776046;
	bh=F1iHgRyYYUbS5G1p57lmuDMTMSEfEjvu3nZIostYLD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuIOJXIupnmPtY+yYOo1ehCvUyws90PZ/j+rksbdefEccMsnjTHX3u9c4rI/bU+HT
	 /jqbbpQO5SNzw5U1G8rXuovYU161Abl2aRf908Tyl8t6PAEznNsrkC8L8HIY2ThspW
	 U6W2M5wjh9Z9Og52vS7cy3yddNq182S2oeifGdhEDy7U4Ok3ykGSw0AO4RvVDlQOSl
	 jBvZEP3z9Oz+dO8ipEKRL0TbrYjRWu5OQC297mnxFCzuh4ewgRI+1i2SQekHYIIi3V
	 af0fTgHIaNnAc81SsS7wt3nAJ0K5PtdQ6TTj1cJn4r9vAe3AKWM0AbETHzPuSbpSNK
	 5LSdhWO8WtwjA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAc7-00000006RIY-431M;
	Tue, 21 Apr 2026 14:54:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Anurag Dutta <a-dutta@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/6] spi: cadence-quadspi: drop redundant match data lookup
Date: Tue, 21 Apr 2026 14:53:54 +0200
Message-ID: <20260421125354.1534871-7-johan@kernel.org>
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

Use the OF match data stored at probe instead of looking it up again on
driver unbind.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f9f2313413cb..8ffc6c5f9888 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2005,13 +2005,10 @@ static int cqspi_probe(struct platform_device *pdev)
 
 static void cqspi_remove(struct platform_device *pdev)
 {
-	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
+	const struct cqspi_driver_platdata *ddata = cqspi->ddata;
 	int ret = 0;
 
-	ddata = of_device_get_match_data(dev);
-
 	spi_unregister_controller(cqspi->host);
 
 	refcount_set(&cqspi->refcount, 0);
-- 
2.52.0

