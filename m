Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEDB23E356;
	Sat, 20 Jun 2026 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944817; cv=none; b=bBfNt7EcNJW7tjTi5n/MyleXFt78RNoEehs9ER8E0nlZH0qWOQUJG8DHCA+ncny4Yd4Nww2B4/sHUyQ8gjf5FRE1Z937rOBDCi1ha9s9qqm7fhG3cvUcJ1zMqFrpQa3KiFvphvwQew4xDo4qZZfoeB58hm0CJEtH46UVYT0/0os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944817; c=relaxed/simple;
	bh=Q6jXL7Hka0/54bjjVHnNpYwVwXiRMGRiye49EqrSwpU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=frBDGAg1FybgV5CfG7LFblXCGPKpqVQesx9YtlCbbdVVm3Y6L/Z1GLLLDUesLahDaL9NKoc53pBYKHEOjdV9l8VZOcrTXCHKdL5itl+XdXweRa77iPZPg+fDBHCSIYbUhuc4/Ip2g3HPhTnWaZ45K58Hfy0nmszGFZ1MItzTXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LZkRvsw8; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LZkRvsw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781944805; bh=AK72JY9546LAn2x2ESR9aaSSsyIR6+VYcMVygo1wvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LZkRvsw8845tPJpYFmQ46MdmEmzdVH7BmIn8Sdc2QlENWSDBpPY+MWzSir/RrVuoY
	 BSl7n4t/bLPV0t8MbTJlSaxsvi88heayhd/DEaEmNNN4Eof9Es2ZzmPmOCWWpLWSqm
	 +me2J0C+7a4Ql3tb+hiCIonsxwcH/gWDKNXE6AKE=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9E3A1AF0; Sat, 20 Jun 2026 16:39:35 +0800
X-QQ-mid: xmsmtpt1781944797tdyk1m35s
Message-ID: <tencent_54F5634545908FBA724E758054BF03953808@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQyyyHkx3pIRBPOwwLsAGMVPZQ4eguFQMDuIpiHoSkhbaPnF81IdZ
	 2z9voss3diVQvFh98JzA6ZC5Cri1wPM4ATG7x2zGsWwwkoZ0OMN9QeG2bJCBrIRWkpGgOf2t39MX
	 /R2tCxfnt2K4U+LvvZ16e16MCvM8+84TI1sw/o1Yu0ZCJRhWQzMQ358umxSHrO4yxdSUSweJR9OL
	 1Hd+I8z78s4jmVn+j+k+6Ru1EM0mbiQStkeOLgt5+tQyBiUkfy06BlggKyHJllbug5vLvPJHVHlz
	 Et9VdU3jCL+QKVlHIv63H/G3ui2EvBBXCCdKlScKRK5m5t6UQROFCvwIZOYl6N81iZnPC6Sr3SQq
	 Yy4uqXb9tXK1zfrjU9AM0Exq6Mnd8XVAVb0WW+aS1YQ7WE+YFx8PLAPFe0FcDbttlePwgX7BDcpi
	 L3gEIxzFEhiEZasPK1WRgBGh8hG3fHYeHEfrMNPaoXaKv9mDdTvhUMU7PrMfzoL+YJCyQM8uyJAV
	 QRhFgUF74Q+DcuGa7YfNpn6uzvsWdS9AJH7QUQzLXkcXNkqMEHG9RfJcn5TyaiixopyuW04sUHrN
	 JsKIkia++VloL6BVbmnVTgmRohek0acvg2wlM0h/RyB4Vs9h2QyT5dYS0LfSPyLRxed8F4beMsSa
	 iM0tzxSAuZ5fQt0UlAvNsrYYgWLgr2uVgqyZnZNmVkefcKPWHQiRiZw7rptceWj3mKwepQVC6hdo
	 m5yYZmIk/5xBf8oakTDvWaPAQFPROXf6W+YeylSe8cjmzzJ3qyVJp3obeUkZop84Q4UbwhczqX+d
	 S/xfJl2cglTnck4mlPXkkm5XqkaIt4Nx4PSBI58LMVvXRFhzvFJPrmz344PswNe15FM6GYkFGcFX
	 YmC8YL23s9wErND++x7tabmwyUOLTiNxfIas+BBuMQ1byAVQ+1nlgx5SaB4i2+gDzYDZN5t7HJBs
	 s8J8sEnMeK5VAlebYjkiWN1bfAZWaWY2xIw/wbocWMJ2N6yL05Hk353V/fFlsciWN+2ZWzvvknST
	 +t+ZZK1U/Ss9HcPbiLR0jL2s+mJNof4+eqfYIAkY4OkTOvup2wkIEmnzvCKdEr6rSjuprX4w==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jiawen Liu <1298662399@qq.com>
To: broonie@kernel.org
Cc: cl634@andestech.com,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	anand.gore@broadcom.com,
	f.fainelli@gmail.com,
	rafal@milecki.pl,
	olteanv@gmail.com,
	han.xu@nxp.com,
	haibo.chen@nxp.com,
	yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 2/4] spi: bcmbca-hsspi: return error from failed controller suspend
Date: Sat, 20 Jun 2026 12:39:29 +0400
X-OQ-MSGID: <20260620083931.1120616-3-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260620083931.1120616-1-1298662399@qq.com>
References: <20260620083931.1120616-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spi_controller_suspend() can fail if pending transfers cannot stop.
bcmbca_hsspi_suspend() ignored the error and still disabled the
PLL and core clocks.

Return the error before disabling the clocks.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-bcmbca-hsspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 09c1472ae4fa..af88ce04948b 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -568,8 +568,12 @@ static int bcmbca_hsspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct bcmbca_hsspi *bs = spi_controller_get_devdata(host);
+	int ret;
+
+	ret = spi_controller_suspend(host);
+	if (ret)
+		return ret;
 
-	spi_controller_suspend(host);
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
 
-- 
2.34.1

