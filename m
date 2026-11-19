Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096706;
	b=BpGDp0SYsJHIWVpoF7oi/jIy8a9IHDqZ8J7D+PjGnogdzxyAq9ECQWYM27YpBpmVHMnk
	 oL7LPOMWptXzuK7EaSb54lQigqw0R0RCGqQ9DmTak3DqB2yKml8uem1VidXIziiiS212W
	 OtX9xyY1DuhPBvRcj//2Nrtu4u0yKcRVklqi4ke8HmTuvLsNFCuR1ScEX8H/PfgBZk9jm
	 OdJwlyb3KAWaitMIjItweXDmaxRT4Ycd6dLrOT7NRjnpscqGWQxoUnY72+WELqdUTPCFh
	 5EvzWpCMmY+hD+FA39N45+aR0rpVw27a0En31JKXR8Yg5WyJF6d4k3lXY1t2hx1e7Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096706;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MfVmbNiMRP2tKpvH50ByGISUxc8c1XPU+cH8XaIhIrc=;
	b=CLsPa6xBBaorTUb/9OPhTyL2nwajfyKR9lQoHhocjjHlwG9oJnZFdDVc+blWAYffIkOK
	 NXVD1qhPIoD+ZIK3FmTLMI4hQNO6WYA62GNJbaH/PXLbz4h3H7v9N1D0WcqfUuvcdyuGV
	 qcRDV3ao1ss1wPpU51CaJ94ijn6bWiwXYPjx1yIo6gwtKD+S8RCIRzwUydQ5uM7DWtgqa
	 LYG6P5at49qVkJbHpqR7qTbaAa7kmg48BImkatql4tx9dAvudsT+dL5mRYXH4Vv5cfPuQ
	 bNlOhfxiK9UPwWnO87kPDxCTs4i4GSY3MrFGj4FXoz8TAitPTyQuNq3ufsIawhDAymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=OxuEj42x;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D40606A32C
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 13:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D40606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=OxuEj42x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=MfVmbNiMRP2tKpvH50ByGISUxc8c1XPU+cH8XaIhIrc=; b=OxuEj42xyrrZIhlmeXAfRWbuUa
	ZR0zQyqgyjAOcR+z5sOU+agBOHl+82XdkMA2vebavYrQINvBuiWt3/Ac3LHMnukMKHZr2hhe53+i7
	xqhIDyjOmVTaMYn3pB7sFJsDRRTCG4Ke7kRnY1e6mw9e2Zg4cYeJFeh5dQG9pM1aQ/Fd3VxbZoP0v
	2HShQbqB7GtSUlyoP6mf6uO58IHEwwJkvk8zipztqJpDxlgc0uChUJvb6O5hgPAI/1DLH0+VdW4xq
	od8TYegFjOQxsOeLimbk7db285fXw/0B4fpzIDTObrj7UCrTAgEwQQbOw/q0wjBRaIRKLIzdfBkh9
	J37QCeNw==;
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
Subject: [PATCH v4 5/6] spi: rockchip: Fix runtime resume error handling
Date: Thu, 19 Nov 2026 14:58:07 +0100
Message-ID: <20261119135808.2377849-6-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119135808.2377849-1-heiko@sntech.de>
References: <20261119135808.2377849-1-heiko@sntech.de>
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
index f8d6cea2f3da..cc6bd7d8f877 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -992,8 +992,10 @@ static int rockchip_spi_runtime_resume(struct device *dev)
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

