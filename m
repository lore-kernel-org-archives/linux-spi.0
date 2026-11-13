Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577831;
	b=HQ9j7Y6N5/IIAT6GI8uliuWhlG2mNmAEdJ1Rb98gxWQp2iMZn9SKsZmLC5G564wmHvzI
	 yDWPG1FVcWlLIOAMzcBmKs7jhr+XCSH8A+Y6bP4tcuFXNPehxW1rYjImreQD2U7et18Iw
	 XTOL4jyqBDvOpZ2JknOTu2naEih0neRcvKYqszp/lkrVPT8kXT/zN46kaaaQgrnGLHynZ
	 bSAlSOkW5RSHbZ1IkOTz2/WAwYU4XVgAP+V5COax9UsxZckydPWvwXyV2NCuf+QHZZ1Dd
	 fTFl+10jzz4Pn9qHx22S/xKg8RgudPmP+y4JboC1dNguZFx7T4d8be6mjq2+LrW39BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577831;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0oMXGLoKcrMltsWL6uMm4zEKFcls2YExOE/JJ6JogwE=;
	b=dzLWrAaG6kGTgjt74DG5HhsCC2lZl0CaHqhtIR76A+jZxsnR1NpPF+AlxAA30oORfMmb
	 bRgcgBIhZnqYfq+O0D8a84I75OhFmbpuvEXVm9sKyeKCPJQ1fSnQAewsG4qkltP+I1u49
	 7I2bnWwcxNYPAIY3H6PqwRUtnEuq3sHJfAaNe40AnyBaZxzssk+VXBqIpb2BhDJNQQN1t
	 pwc5SisS40Qg0TCADpnvv44/cm8En91GJCxVINBu6hhcdDzwBJZynPcjLK2cZ5F08HezK
	 ksbD4PAZkmjJYbjcH932dm6Jj3pY/MJXVCIQab24aVNcqE2R7kxZ0HPUoi7uKeSCY5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=RVvrMH6Z;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6860A381A
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 13:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4B6860A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=RVvrMH6Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=0oMXGLoKcrMltsWL6uMm4zEKFcls2YExOE/JJ6JogwE=; b=RVvrMH6Z/IifApCX991OGZ23zo
	U6Vu4i6+RouBvXDRHWrfvr7HFsgmiseIqsRipsZ9ImX2YQCuvoeEIatmwXZ/cCRdNuDwyW3N0UpYW
	ZW5BDSrqajHEYY98UeF+ZPnbZbZwGuFVjUjHSXVF0qQttw0HgEDgasM7H96bd+4S03Csltf78Yd5a
	Hki/fOYpcK4cGJJr2UVNZ57hREGRnr7tnib2lPzTt33aTrURV6VWWr0PDqx2R/YmFWjFkdGLnOkiU
	C9JCvxuhhhx/MQEgEWzxg7JwXqKB7EgPrRCBhlnoKU42d794xx/omep2t2N6X81nzDDOMtwvwhVyC
	Qxp/23eQ==;
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
Subject: [PATCH v2 4/6] spi: rockchip: Fix runtime resume error handling
Date: Fri, 13 Nov 2026 14:50:15 +0100
Message-ID: <20261113135017.1047959-5-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113135017.1047959-1-heiko@sntech.de>
References: <20261113135017.1047959-1-heiko@sntech.de>
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

