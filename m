Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959454;
	b=cjM4wTKz45/Fxght5ULVfRx7ErPZoP+iYsK7zOQZb+0vjaMWbapLre9gO/sgKCmUwihS
	 V2IiP0mBjatYqymV25k3oChReuOzPmSdkVR92GXfZjNMEPhXVkW29QzUQSjoOoYFCWGbE
	 JhurfFqKLEBgD4CDP00z1f3TrMO/wGkAGUgk82DdFcfTBCQJ5IQPuPuM5Qp1c5KZsVcuo
	 4My8wREdhkKFynfcZZiKBasR0RB/R+Fj3uJq69dcncC/FgpuSlXUuycztTANk69b+rUJZ
	 2WveqILQAXV9ifI8xJYN9etefMHVXNRjfEHGHG4qlaVK5iK5B8ubG3mQ/ibNoLmJbwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0oMXGLoKcrMltsWL6uMm4zEKFcls2YExOE/JJ6JogwE=;
	b=jcEHoCdTyw3fj1Y32EK48f3XdD1UqvSC2s+elm/8Aak0ltFfjbuspcvjJrXeuLQMWNsG
	 lz576YOGa34inMLNkWpResZtkl2u/Ys+brG8sgVK551rQhULGTQX5SEYQ3WpFyVIR7zha
	 Bm9g9FyKE5ulf/EKPlE/l3UDCzPZ3tEkZt/5voZz8vhXUA/JKyf/N9G3Wagb34NJPXo0D
	 QuvMoBHBV08SN9nQiL/Lx+1gSJkrEEnGuQSg/fxQ/IWpWblJCzwxXIcNq/JIREKlvPO86
	 K1nBrK26KrsfamKCEz8+PrEwSCa2pJvXIaiH4Tall9P64hs2GGn2C3Mrm46UfdD9sMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=eT1U28Xf;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F8606A334
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 23:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F9F8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=eT1U28Xf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=0oMXGLoKcrMltsWL6uMm4zEKFcls2YExOE/JJ6JogwE=; b=eT1U28XfPrgX2Cuu1cq1A6eUiK
	QA0pCfbnSuaUZiaToiyC1gdOP0SlmE++zEY3IIQ8MPh3CRtQ2q45w6SsdvR45G4S4WtzJ6ty/hNnS
	6B+irPbVY+3elZXp0vxsv8QV04QFMN9ZgNpuqhl4aA/Q3XrgP/aSKMBPkv3UMR0tqs6Ld0xad+jZW
	ROBdlEqaCtI720fZEYd5ey3bjjBmHiCgsxhoHxplIkcv+a8xOIpaci3U1IhuRvwD8feABbnI4WE4Y
	2FvLzxnQ3Ta8vzM4BY61ioMLlkKMJqVcP7kOfMebEV/utvOkxdBQ/etF3m0mQKmI2K6eU7FXZEJH0
	vYQAAPKQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 5/7] spi: rockchip: Fix runtime resume error handling
Date: Wed, 18 Nov 2026 00:50:19 +0100
Message-ID: <20261117235021.2013719-6-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117235021.2013719-1-heiko@sntech.de>
References: <20261117235021.2013719-1-heiko@sntech.de>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

When enabling the apb-clock any error does get handled, but when an
error happens enabling the spiclk itself, only the apb-clock is disabled
but the function then returns successful.

Fix this by also reporting the error on enabling the second clock.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1a81fd94b439..8bb55d52d346 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -994,8 +994,10 @@ static int rockchip_spi_runtime_resume(struct device *dev)
 		return ret;
 
 	ret = clk_prepare_enable(rs->spiclk);
-	if (ret < 0)
+	if (ret < 0) {
 		clk_disable_unprepare(rs->apb_pclk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

