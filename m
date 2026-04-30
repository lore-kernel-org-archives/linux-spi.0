Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31243E4AE;
	Thu, 30 Apr 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564593; cv=none; b=m9M+tJkPmO0Cw6yHOqz7c5Y3DPGpZfY2Pdtpo+WoyWJX3V+8LUXjabCsv56mWwIc0XPBeGkPEWnOOLGHUIUIXkZwDgrex3wbtWh0fN+dngk/9gxwdyHbDIcl/mmguw3wqWu9q//6DvRG3YWIu/ozyUS+1xL6FwaHd2/ZDGx9gR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564593; c=relaxed/simple;
	bh=h0Cz8bf84xfbKmcTQ2/v2Z93g1Acs5e+A7to572ZZGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5V/k0g8XT5mjUhiv781E+h4s1q93CI/zh1gDtUNybVKoLzHegXp2MXiBeQGHpU567K+E0+7ZKYZ5b1ZVFhUekYgkKMN9wIigdO0LyXGkimmtsxEVbBl3XZtuEYqinHay4a0YQ+RoWSlHn4yHHA6POiDAfZZpFGMvnVAfUtG9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FAsoKEvV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FAsoKEvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ax
	jDicrKppounBiGYtfzHy2w7g0lf22gdPRW8ADstbY=; b=FAsoKEvVljxlWVKfZp
	+VnZlXjh13cnAHhJHMU4ng+BEMP9HEPIPF8XeTzO64hMaJuwRjm48LTek4DEv46P
	0vieuLj1/nU6KQnOdQgsqzHTC9tjDoMQGzj02WVpeGPI7DQkzQ1HrbdYSTluI6uf
	car78L5nAbibcHquUFbDryNqo=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S4;
	Thu, 30 Apr 2026 23:55:02 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: broonie@kernel.org,
	sunny.luo@amlogic.com,
	xianwei.zhao@amlogic.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	han.xu@nxp.com,
	haibo.chen@nxp.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	lhjeff911@gmail.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 02/10] spi: amlogic-spisg: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:54:48 +0800
Message-Id: <20260430155456.36998-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430155456.36998-1-18255117159@163.com>
References: <20260430155456.36998-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF4rZr4DKr4xCryfZwb_yoW8XFW7pF
	48JFW7CF1Dt348Ca13CF4YkF1Yg395Zrs7Gw12qw1S93WvgF1DZFW5Kr48uryagFy8XFyI
	gF4kuFW5KFnrA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE2Q6gUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBZL7mnze1Zj5gAA3F

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/spi/spi-amlogic-spisg.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 19c5eba412ef..4c9f4088cb37 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -601,14 +601,11 @@ static int aml_spisg_prepare_message(struct spi_controller *ctlr,
 
 	spisg->bytes_per_word = spi->bits_per_word >> 3;
 
-	spisg->cfg_spi &= ~CFG_SLAVE_SELECT;
-	spisg->cfg_spi |= FIELD_PREP(CFG_SLAVE_SELECT, spi_get_chipselect(spi, 0));
-
-	spisg->cfg_bus &= ~(CFG_CPOL | CFG_CPHA | CFG_B_L_ENDIAN | CFG_HALF_DUPLEX);
-	spisg->cfg_bus |= FIELD_PREP(CFG_CPOL, !!(spi->mode & SPI_CPOL)) |
-			  FIELD_PREP(CFG_CPHA, !!(spi->mode & SPI_CPHA)) |
-			  FIELD_PREP(CFG_B_L_ENDIAN, !!(spi->mode & SPI_LSB_FIRST)) |
-			  FIELD_PREP(CFG_HALF_DUPLEX, !!(spi->mode & SPI_3WIRE));
+	FIELD_MODIFY(CFG_SLAVE_SELECT, &spisg->cfg_spi, spi_get_chipselect(spi, 0));
+	FIELD_MODIFY(CFG_CPOL, &spisg->cfg_bus, !!(spi->mode & SPI_CPOL));
+	FIELD_MODIFY(CFG_CPHA, &spisg->cfg_bus, !!(spi->mode & SPI_CPHA));
+	FIELD_MODIFY(CFG_B_L_ENDIAN, &spisg->cfg_bus, !!(spi->mode & SPI_LSB_FIRST));
+	FIELD_MODIFY(CFG_HALF_DUPLEX, &spisg->cfg_bus, !!(spi->mode & SPI_3WIRE));
 
 	return 0;
 }
-- 
2.34.1

