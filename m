Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B33A9601;
	Thu, 23 Apr 2026 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966037; cv=none; b=my9yLnEg1NmzTDbeG7viL2077AIX5OKU6pNY2SzuDncTJkU6TLLpOIrkX+9f43UyOfa8LvXFSHDriJAFGdqMjxYISNlhjqT6DHo4kxtRjIhHALGqVhHNJ+bzl5Kr3DzOZD5oShE5ZCJl9fLvntbabenXKpuoPSLGCtTjsRdsbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966037; c=relaxed/simple;
	bh=8WHRE7PsKgt1I1RbMZATFo5T1e9JAAGj4qCpgvPY1c4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6Dz9UHpD3+qZOZQzQAoi7E6b/ljpxkldNEmdmlGjuvrKocL4f9IOv7xLPdJOJa5EQj1tcTgZJ46hvBDJnadUq1g9lDl2IJmn3/OiGf2FzKPwom702qiuGssYgImi/eolXoB6dwNZfpVhemx+Kk9VjJjn+WPqAILzuPrp7aw+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net; spf=pass smtp.mailfrom=kevinmehall.net; dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b=lpnRw64x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S9Z3l2eE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b="lpnRw64x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9Z3l2eE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B4AAEC05C0;
	Thu, 23 Apr 2026 13:40:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 13:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kevinmehall.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1776966035; x=
	1777052435; bh=XFfXl4/GQbW6GPX8t/YkBYX4DbIwbw9iQSWalhVhYcE=; b=l
	pnRw64xa6RXfvS8Km3M+XHQo9aJ2zZIzDtgAF7wkS/uMsyNdNYMMYgJBXprxwLYZ
	6wmgqmKzJcOVEOraO4/2fAsd+LTx+S4vZ7YEr34dGP/YSHCVLJv7fmM8czXlWoMT
	kUeF6TDPXvWH2kdG/HMd8KTSkHpTr3wa1TkuZC+2t2nZrt2G65RneuOtMl2+LrgU
	hY5jYQ7PKH3PSjdJpd5H/w9uIpSfIGIDw5HABfC6R+oWuY+Y3gXvQcDrLIv7J/3I
	hI/6jNuvxWNxugEJo6jwaNb1zz1Qhha5/kngufct/iC6VCqrmwPeWa6iFoaRQBEx
	m565R/a4UEnY+cAOvSFiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776966035; x=1777052435; bh=XFfXl4/GQbW6GPX8t/YkBYX4DbIw
	bw9iQSWalhVhYcE=; b=S9Z3l2eEX7kTyTFrqRqiZXCz+DZPq/EcS7H/umYt9zg5
	9d0LPH7CvgKx1sWETULB8uFvOJbVVFlJCWvQ1YgSD6DgfUWNkftDqFLI493PK3OQ
	v05U8je5zWtt0akV2BXWzxEmarGHN9qhhdiODriodg0A/Hf5H+r1iAfWqCHi8PEK
	EACuPvBpsOzE+l6Yen5HBrmr+tOFzAe7FztxkhZVUf1fwsO/C8uvkI0/mKzGBTLp
	6OAButVZ0NXXvyz00iwsMBpJTSkyq78x+Cn5IBIjVgCNviSvDYJpjQVUh3hjruZL
	vVG75gunLisUBqzpGWJTtt2+OHK9vgMZupncmSRkTw==
X-ME-Sender: <xms:klnqaW4w-wFXcOJ8jd55NWYVkt17yjyd5iuCG5VVx1E-rv9dJz4PnQ>
    <xme:klnqaYGDUFHMJDOWNwfI76WitXOhkT80VtGHyfcrbDGvl-0fHtF-hThwzQarraPeJ
    Uir36Su5SXpqwThXGEY3gYkaAQJnqdKtbdTXi6xew8QvD-37Lne>
X-ME-Received: <xmr:klnqaRCm1JdkTz3BKNRlfQHwLetS-ru2oX9kFga_1rNt9ODJS5z07p4_867V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfgvvhhinhcuofgv
    hhgrlhhluceokhhmsehkvghvihhnmhgvhhgrlhhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpeduhfeljeetgfeiheetieelveejhfdtledutedvgffgveeihffhkefguedvffegvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhmsehkvghvihhnmhgvhhgrlhhlrdhnvghtpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghroh
    honhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvnhhssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomh
    dprhgtphhtthhopehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgpdhrtghpthhtohep
    mhhirhhkohdquggvvhiklhhinhhugiesnhgrnhhlrdguvgdprhgtphhtthhopehrshgtse
    hruhhnthhugidrtghomhdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlih
    hsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqshhunhig
    iheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:klnqadya9QuSMRBI5kpgADidSfj9UD08sfWocPE2IcHvXLX-VM5aXA>
    <xmx:klnqaV7b0kIxonyFIxf-2yUiLVO49TAZi6M16So9qHYUFTTRW1EvFA>
    <xmx:klnqaeytaprLT87dvg3dsp72KcnZvzmx95n8olx17KjhwBOr0wpLIA>
    <xmx:klnqaZcwCWUj410nNXcjLeuua-8tBuXRUdiftgd7cQQ0xrle7BQ1kg>
    <xmx:k1nqaQNsaeS4dI4SYBZeWkSPWlL9CKsy0MNlHX3DfET4hHX5OnxfNhVJ>
Feedback-ID: i421842c8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 13:40:33 -0400 (EDT)
From: Kevin Mehall <km@kevinmehall.net>
To: Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Mirko Vogt <mirko-dev|linux@nanl.de>,
	Ralf Schlatterbeck <rsc@runtux.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] spi: sun6i: Honor CS setup delay on the first transfer with native CS
Date: Thu, 23 Apr 2026 11:40:00 -0600
Message-ID: <20260423174001.2797797-2-km@kevinmehall.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423174001.2797797-1-km@kevinmehall.net>
References: <20260423174001.2797797-1-km@kevinmehall.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move SUN6I_TFR_CTL_CS_MANUAL to sun6i_spi_set_cs.

The CS_MANUAL bit is required for CS_LEVEL to affect the CS pin state.
Set it in the same place as other CS bits to ensure that set_cs takes
effect immediately, and to make it easier to reason about CS behavior.

Previously, this bit was not set until the first transfer's
sun6i_spi_transfer_one. That meant that on the first transfer, set_cs
would have no immediate effect, and the CS falling edge was deferred
until the bit is set in transfer_one. As any configured cs_setup delay
happens between those two steps, the configured delay would have
effectively been ignored on the very first transfer. This change makes
the first transfer work like subsequent ones.

Link: https://lore.kernel.org/linux-spi/d199f72a-093b-41bb-b33e-b6685563f704@app.fastmail.com/
Fixes: 3558fe900e8a ("spi: sunxi: Add Allwinner A31 SPI controller driver")
Signed-off-by: Kevin Mehall <km@kevinmehall.net>
---
 drivers/spi/spi-sun6i.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 240e46f84f7b..fc228574ed38 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -185,6 +185,10 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	u32 reg;
 
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
+
+	/* SUN6I_TFR_CTL_CS_LEVEL sets CS rather than the controller doing it automatically */
+	reg |= SUN6I_TFR_CTL_CS_MANUAL;
+
 	reg &= ~SUN6I_TFR_CTL_CS_MASK;
 	reg |= SUN6I_TFR_CTL_CS(spi_get_chipselect(spi, 0));
 
@@ -364,9 +368,6 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 		reg |= SUN6I_TFR_CTL_DHB;
 	}
 
-	/* We want to control the chip select manually */
-	reg |= SUN6I_TFR_CTL_CS_MANUAL;
-
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 
 	if (sspi->cfg->has_clk_ctl) {
-- 
2.53.0

