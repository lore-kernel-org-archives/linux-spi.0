Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881179;
	b=IXmKnKrMzrUeYGDvEnLKoSzqgQTkFhamXCFY1c/LEzcBmTVVLZMBqvIEIxcWySX+UOPz
	 bHQ52j9kgHGLwPHdtEUfKlltCGFduE1BMLEsRaDSXzODiYsXoxC2WZXv6rfn//Om7Guf3
	 UxWV0e9pkE3QnML7dzR1CV6OsMvWU8Bohc2RbUv8R4BSjkHy1+2kmDsYwoKOQJ50cmtKY
	 IuINjNdHQ577o/7nSA+95MrrA+td17WNOeTiHFy8mJ6+c/2B0pspY+UMBqbL4TOK0t94Q
	 Hfukw3TSB9oWXXE3w4nM6snm8xU3tMCGNb7e4EzSi4hkQ0MdmLBakclPifZ7vGID4aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881179;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=btRGuzjJ/g6J9xQkRo+LeSjkAB3m5T+OgnK3c0kCtHM=;
	b=ZifPle2Bu3oTufx3sOmwP0gTn6te61tymXr8Pq2UIf9iUYKLtMfDtcjiHVZ6AMs9aN8Q
	 3yxg2QAXOFCVGL6zpLX9uDRozSYv+9udTqsQt5ohWyapH2VpnNZaBQ8yzFQdgvPkqLZ9w
	 3t41W8V52Rb2hyJxaRLRbskRb82SYVgSSB91ppzVQx/7ouCtLhoOsrTsqTg3BnWOgvIDN
	 VdjCvI1yUTwLx0Bwk1ehYF+hsQSbpgeDi73B9529SBmKuk776Gz+O/9Q6drZpKEkpwXfh
	 mH/LntgW8ovGRMQDDwtCnTX+VNYQquOTYdN1YRT0QEOupQV7O2Rf+1w9mjdVa5FJoKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zu5q9ADK;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8677606A31C;
	Tue, 17 Nov 2026 02:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8677606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=zu5q9ADK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=zu5q9ADKIsaEq2UDpwRmtzwJ+uRnOnuee/psBh8HaZDxRF6egptwv8y2vy9P/d+ZlpKWPHAOecLx/
	 +3t2DBXsRSrDNaFZ79Yb6SBgBrKAVwie/ZgCWgQ4ZDrn83TWt/4qX5CzDqcsrLg928VZIV+o1quDcW
	 mYvBwFCeQPw1JQHw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36afbb69724b-cff62;
	Tue, 17 Nov 2026 10:06:16 +0800 (CST)
X-RM-TRANSID:2ee36afbb69724b-cff62
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16afbb696b6d-9ee17;
	Tue, 17 Nov 2026 10:06:16 +0800 (CST)
X-RM-TRANSID:2ee16afbb696b6d-9ee17
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: at91_adc: handle clk_prepare_enable() failure on resume
Date: Tue, 17 Nov 2026 10:06:19 +0800
Message-Id: <20261117020619.20065-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
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

at91_adc_resume() ignores the return value of clk_prepare_enable(), so a
failed resume still returns 0 and the ADC registers are used with the
clock off.

Return the error instead.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/iio/adc/at91_adc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 433f81cbf4..7bfb827f5d 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1200,8 +1200,12 @@ static int at91_adc_resume(struct device *dev)
 {
 	struct iio_dev *idev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(idev);
+	int ret;
+
+	ret = clk_prepare_enable(st->clk);
+	if (ret)
+		return ret;
 
-	clk_prepare_enable(st->clk);
 	pinctrl_pm_select_default_state(dev);
 
 	return 0;
-- 
2.24.4



