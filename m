Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C711DF73C;
	Wed,  6 May 2026 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778048707; cv=none; b=PLUTHPNvlTiBzrl7hmbGNE2Vf2J5Zq5z1QguLyZPu4Z7uLQDrqQB7DCSsi8keUEhrOog19c+kRxYKdR2pohxaSIUyoclmAQOqoxmn1ma3dN0Vonf52Zm5DAOtAA0ao0FjmLNruLD7PaiBKicUbgX1Sk2ZQA/m4EAczGlhevWh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778048707; c=relaxed/simple;
	bh=toQdRYAFTlPv/S5zODj9c4Qj/WjyNVx6xfzWloQKAvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6AZ7+CtoQHlIRaQi8EN7d3ActHbYRsO4U1CisW0EqCHhAu7kX+30xcu/iQ44LcFJrKZ3lP9RPcmdcSbdlvnkPio2PPpAA7IazSueqrfthC1HI0hfuO2bsbYdz9vMYdrBcrmp+nCGZ0w9TlgLjf9W29RE60/nafb4HzxEPnopxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wch.cn; spf=pass smtp.mailfrom=wch.cn; dkim=pass (1024-bit key) header.d=wch.cn header.i=@wch.cn header.b=QbgJdTQQ; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wch.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wch.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wch.cn header.i=@wch.cn header.b="QbgJdTQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wch.cn; s=ssbr2306;
	t=1778048674; bh=Sy7RriaJxfzUZ+1nDzjAU+KRpFOAyhU7CaQJWg/pXso=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QbgJdTQQ53zVntdA7AXZ+kJi2zHkBkcbJ4qS/4K7Uex6Dmpn/BjpVFA3RdwVKzA9I
	 pD6KlQyCx+e0vjxkK+BzwSS+JAShWIEZQ9M0cL3Cl32IoPW6chJLN8EDwd/NQm+anM
	 AEKBSqjGGJOMrxOr9wZ7P8XiZDLjW6y1XAcqyxvA=
X-QQ-mid: zesmtpsz4t1778048673t57407af0
X-QQ-Originating-IP: NW+t3StAE/KZHUvn15jrrJoZRk+FdRIpoumram3nTio=
Received: from wei.localdomain ( [117.60.69.176])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 May 2026 14:24:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1270364702676656804
EX-QQ-RecipientCnt: 4
From: Jiawei Liu <ljw@wch.cn>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiawei Liu <ljw@wch.cn>
Subject: [PATCH] spi: ch341: correct company name in MODULE_DESCRIPTION
Date: Wed,  6 May 2026 14:24:12 +0800
Message-Id: <20260506062412.371034-1-ljw@wch.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:wch.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N7zE+17nr98T1Lt9jYGl88/7YyhKzPhvbCZHeYpSxNUL0OyEL1TUqpj1
	TcD0Zs2+Sr7NCuWst8tfJQwihAzyByh+rX7unmv03YVPeuXMfavFDKKCstCT6BQ/DGmGGHl
	2ERmTn736I3S87sggXq49RQpx+yZqu+qIjTxbV2BmuiaFMuynw3KiATscZzk0rNg/DoRo2J
	Oozp3D47k9WRS80e10GdREWjb8NyjKymhvbXK2vbBDAknL/mr6VopLeHA0540Q1wSOmiQMy
	o58KtqfZl0W6sYXPOSQ93SDueSoXRhHfLQtJbIYq0uAIYZ/X/laDMzOJPXXEGrSPoObM+gW
	btyICsp2EqmrVKuTh8YJF5DotESuqSrTgoYye5QHBi0jItjsP2gYwKm/caxcG0kbIHIm9SG
	KbEIR9PjW4r/lrCwOk4Jj5Gs12EdJMLnfyQaxpS/8m3bu5309tTRK+WRTZ7bxCXbholak9j
	jGQ5RM8EpxcTsXXzPIRzFKPa1W5tmPIqVLfhOqvt2rdqOK7/hD95oQBXhlRnXNFY4ZZy32K
	LHgMXaKZ/YP7ZI8eEbiJ26SyfLkeqkLMC8KPdX3zM06QlsRcEdjayVTyS/bun3VMOrznJo4
	ZRgGQode1c8qR5ZSayko8xzysBwz3S+0MoT0OXCc5cisJLTyWJHxk/B8vDIbJgyQJ6vGUc6
	d+mZia1KdL+WvX4/j5/o9ZHcJ3FmlEgrxQEScL3tmf8OCaQgMd0uKF7IqzaDUzdaopuJhWJ
	ERiIZ4d2GquvSJ87wSljJvL/gbKVmF3cXuuM2Txld5twuMxWB+5evR1O+wVCrT4qO+NP7hd
	cTapcEzheCB0CsuRX5LpxeAE/w6eRdWyjf09ILZMnl+PsEEZ1CtmeXuFWzwvMEMXBPU5t4G
	9i80aAfFaCXqO/nW7vif3Tk8P1QOdiRvNcl7JOFI+0AubexqtlOnlxztE96rD8aFH36DPE4
	hoe2q81fdSc7fnlwpK+kT+AJ6dfhp2FsfWqQzGph0KKRq9jHwGd5yw6l8oUzlpVpevGqkob
	lSObzJnBBwDgWl8WT4qObT9OxDlk4F9QfvOUleeaafEWcEEoMt
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The company name "QiHeng Electronics" is incorrect.
The correct legal name is "Nanjing Qinheng Microelectronics Co., Ltd.".

Update the module description accordingly.

Signed-off-by: Jiawei Liu <ljw@wch.cn>
---
 drivers/spi/spi-ch341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index 3eaa8f176f63a..6448a44a8b67e 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -250,5 +250,5 @@ static struct usb_driver ch341a_usb_driver = {
 module_usb_driver(ch341a_usb_driver);
 
 MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
-MODULE_DESCRIPTION("QiHeng Electronics ch341 USB2SPI");
+MODULE_DESCRIPTION("Nanjing Qinheng Microelectronics CH341 USB2SPI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.34.1

