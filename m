Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4D2AE8D;
	Thu, 18 Jun 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801146; cv=none; b=DKhLvdKxwW90HAbCB1mS4xwx6YBgjCXqGUXht/XqWZqFU4oRlBFKBOvYg8Q4CMewjDbblp8/8mO3Ec0vCoal9MbGfeMlxcK//ZyBttFG8PVFjw26SM/+AeprVRKBDhXrqvL56aojFbtzVMiMWeN6DikvOeHVwD+UlxO2IXE3Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801146; c=relaxed/simple;
	bh=u4ScgSjBiuMWAZ4fQhN1A3LtNjvL2L6W93wvkqUm1Xw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=jhv4sxjastPT/igZzpBsdv1/ecQN80EMYU5Vbmeh3WSyEx5nByB0Er94YQMPN1nwni4uJX9nFS203ZxIEvOzBdo1m2nhj0kbkHvROgkhu2u/D2KVbr3etCvZG4Rb7H4cF4mSeoSI3th3bcbl0+lT9UD9MDDqzI8X6HfRboLoBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qRAVAjLN; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qRAVAjLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781801134; bh=U3KjdHkIcQFYEw14wG0dsjmYpum4BOCzZGAZ9ZfkdZo=;
	h=From:To:Cc:Subject:Date;
	b=qRAVAjLNACbpcHu3zbkhOuC6nzx++uS1MlnsanGtPMm3Lh9/nueBv8wnYxDciC3+B
	 HV+Bg7c2mgFcKsJ8aJbEgdJrAqBMyrYKGYKuS/MhN7zEgVsYKaNvzamQSoWToiDzGf
	 4h8ED+xZlJr0GzXQXvaIITxvg72D/9J12ER6iCy8=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id B558E2E3; Fri, 19 Jun 2026 00:45:21 +0800
X-QQ-mid: xmsmtpt1781801121tmjvzsvlz
Message-ID: <tencent_0BD7D4091B90EC17A8B2BA5EBA8803725905@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb50Q55bz6YxO3u8mgT1qmnuN/QA3SxH1+cMU0ny0xQdJijKbXrWc
	 8m4gtFYYpo2kaoSFecXx6LVhRbAXDM087fNp3LSOWTTd9anKUV8dZ3bbGjOfbk4JviHMmEJgUhzJ
	 qhpVTDBH6kfbXXyERLQdJ48m/ViZBlwwQr5gNdakgnPPZVRUOvhMCoSQsHQ/fS/ETtxUZ+7EKC/C
	 Ubs0hdh55V602Hz2TeAw+OeWM8EiryTu7eB2Xc8W1zmt34LfnZYTNqQBOo1SxPsDbo61mImT43i6
	 AAzA0BNXl0c0nZ3A6gflEqApA7HXS9/b0zeqJbctt/5lm+WinRMb5gUaQrSYWmw3WJhRuwMbb5S4
	 qAs7ebY+3/sH31aJHIJSDj/1HwvzqY+rQUv+B3o6zGvqyp6BIkoFaWqO6qPy2JKbocbYzPLNzNZE
	 cg7ZTkar7Vn10mZuvSopVBzy4zF8S2vpqPKP2VS+VkQHkCg2G9Z/ZS5oNGkB7rVmcRNr2qWHiXNQ
	 nhFtgRFT3JAui2uejx26d4kIRCjk/5bB1U/TRcD9ldRsCAnqJYTlK0zrT3o7/LQmumT1ajDBr5G3
	 WIKgmd6qhBKnmsP7CO3DuECc1r0o8BLC8yVQbyGRXpOlG2ohuV8MCRHEG6zfx+5q3OG5L3hYcQha
	 BFOcWl385UzHebwnNW2TRxlNeGdOZp1QqP+x2Q09yxCY8C9zEaAIGYz0/1n/8U0+OZT2ncZMm1De
	 P3MI/bBKyh5voFDdGmhMLrethX63b3aBWN3norPOjYnv7UetyCZgzp/4P0LMVG5SaM42GdEhWbkR
	 ZUI/AplWV4a09R4zi5HR2uQVFPBhezDaKa7YP5E9hqDjHV8DHxLeENYaRk3CHJZuFu1XjBo8YNt4
	 7JFCZ+Vot2sT26CnZpRDGEiA2UJ0lMOeHQjpg1/mt7NN+V1oLKHcf9f783rwhPc7W1/nHa7+JLCm
	 GS82iV5Jv8EpfZBjkr1meHNR+nH1ek0NwuSEFQd1LVNO3Z6tmBlCw2dSneDDnrVYiXyo/dVzTUmE
	 lv+fqOeuoZIEB/oYI2DAIG5ciCuNyQ8Ok35/qNVMPC2hYtmsE/XcA5HPZPMqGj65M8+dPyALTShl
	 o4CC8l
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jiawen Liu <1298662399@qq.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kamal.dasu@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	jonas.gorski@gmail.com,
	kursad.oney@broadcom.com,
	william.zhang@broadcom.com,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 1/3] spi: bcm63xx: return error from failed controller suspend
Date: Thu, 18 Jun 2026 20:45:16 +0400
X-OQ-MSGID: <20260618164518.3885130-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_controller_suspend() can fail if the SPI core cannot stop the
controller. bcm63xx_spi_suspend() ignored that error, disabled the
controller clock, and returned success.

Return the suspend error before tearing down the clock.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-bcm63xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 43d7b54e3ae8..8cef725aab26 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -632,8 +632,11 @@ static int bcm63xx_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
+	int ret;
 
-	spi_controller_suspend(host);
+	ret = spi_controller_suspend(host);
+	if (ret)
+		return ret;
 
 	clk_disable_unprepare(bs->clk);
 
-- 
2.34.1

