Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0C381B10;
	Sun, 30 Aug 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788097746; cv=pass; b=XQEl9eoIfWRtt//BhoRoVytWtFN70XtIefA0BJj33EBRF7yDCbPCvDDfrkWrAYn9HDyeMLIu87+IJcbjC7cceB+E0fyhJKe5SerJ0sDoz+W7uyloU4wmfqBSgemEGMZGN1m5L5jQ3OywqAJt65JWWuY3R7mT5/cpguK6/GIUx/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788097746; c=relaxed/simple;
	bh=2kiaebJ+Y29rKyDA9vC1b/injJL9UjUWKm+oKK61hrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HQgF6vNT2TlYIruFPu85il1DyvmFVL1q9ovqL8jDB8k9yAdvOEmjkiAUTJGDPxvWFcdUclZbo0sgLxVWFtRklz9hr9OkhjCQtAy/rhxCMfw2l5Ocf1um7DUKI22yx1yw59MBapg9X8TGECwU46e08WyRa+qs+a3hTSEzuxLOKXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=On/ce1C+; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=PytnO4U2; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="On/ce1C+";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="PytnO4U2"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com; s=arckey; t=1788097744;
	 b=d5kGvx4V14auVOTnKAjLIDv/o/41/EzNXdjkwSiK+UcrmEuZkzDrflK5iAFeII3pxNQXA7utT2
	  Odr5cjB93CPkRZAKDO3VG++uNkFrpB5M+qvzSojpDFjWAy6umwtXDCD7zTB2U5W7QZaMrkoqOI
	  MBIbooOv0cY4IBExZ5gU1CXnuyA0u7jAGL9VD7XNdeANM+fXlCWckKWhtcvj2ZO6HPvQ5nAeSt
	  9mtiScu7PT0REpvyQXLmncWR8eqhHA4E+4YPXsNb3vgaBLHrR/JeozWi9EmmrxlqlACIGjzOWl
	  lV5a0iAYKbmCppfROmeNN7ykAs4v/tZmjNdLuPcQw0xunA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com; s=arckey; t=1788097744;
	bh=2kiaebJ+Y29rKyDA9vC1b/injJL9UjUWKm+oKK61hrE=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=M7g8HOyixMQgArfW70bfWbibVzxeljWkovM1IiHmfBLJoPPwq8ey/na4jYWYMckEUj8VqScBcF
	  UG4qbng4EcwGs8maCpX50HWnmjjlZoopgDJsFQp8xq/Fmgfa1TO4yXCadQt9xD76+SlGGH/LYn
	  nKsUZhnw2p+JEmZpbYo9WQJge6Q80GqGpcMTilhx4QDKWllcK9d1UkKApFNU2qvVe0Yafz4GZQ
	  jzeo6zcQkXyn5N3B7B9yKK7mq62i1Ul6MGT3dovpsj/9O9ZHIeRNI/60RB7BX0J7tGH/sgpz0N
	  h4G3Il2YNih2Pm2Ypxg4n2tbRa2LDvWp+9F+Y5+Q7V0ucw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=DiHD8En7fq2ugx0Pu3ejCIoYiYpClHsgUceUJ/BO04Y=; b=On/ce1C+koBTg36DTgHgp47OPA
	NOroWNk6Z2Vt91Lyv8vDFfVjZ7eZw5I7bxOaBIQtvzvgT5/7j3DeOoj/SXfKq92Qzl6Omn6nSpSA2
	PuAL5UD938gn0ZVVXAh9M3yRRmBK1LFZVQZ3u7Np0Jr8nXNyyJPi9eRUcruJDi6cKTpA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x0fu2-0000000Cihp-1K4k;
	Sun, 30 Aug 2026 13:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=DiHD8En7fq2ugx0Pu3ejCIoYiYpClHsgUceUJ/BO04Y=; b=PytnO4U2/w2IfKUZiuQ3lt/wQa
	ghrfIgmxTn0X9L1uMAtUSR9sjr6Bi2My5wdzotlnL9gEA2iBnzdd3ZRkj/lmtCs3DWfHdqcViiCxg
	umhOdf9MiQduejSg23gE+j+uP6RYFI0AD0U3T/iaRO1/CzkyEGnGrfFs9NCb6qJJ6r9c=;
Received: from [87.5.139.196] (port=60542 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x0fty-00000000Ep8-01NB;
	Sun, 30 Aug 2026 13:48:50 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 30 Aug 2026 15:48:35 +0200
Subject: [PATCH] spi: virtio: drop duplicate completion init
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-virtio-spi-fix-v1-1-62f486f4acdc@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAQBCF4VfRXJtauyV5FbnYWYNxgXaQkne3u
 PxOnf8C5SisUGcXRD5EZZkTijyDMPp5YJQuGayxpamcwUPiJgvqKtjLicE7R4UlT5YgndbIaf6
 CTftbd5o4bG8F7vsBK5m7P3IAAAA=
X-Change-ID: 20260830-virtio-spi-fix-ca33b12bab2b
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=francesco@valla.it;
 h=from:subject:message-id; bh=2kiaebJ+Y29rKyDA9vC1b/injJL9UjUWKm+oKK61hrE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFlTTPZonj6ls3Uy38dn06zYZ7T1rc+5Iv+vzHnnztMv9
 otr/Lt1uKOUhUGMi0FWTJElZN2Ne3vmmn9L28D4CGYOKxPIEAYuTgGYyJxnDD8Z50c+3nUgUIGx
 /OGx2fsNyjk1JDOf6VgGruf6efhJ3AknRoa7pUFLTl9yvaDf83e2z14p5dxvQWIO1c0CLCtyzx5
 8a8wBAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: beb358e599b79f6ef325c6715a078fc7
X-AntiAbuse: ID - beb358e599b79f6ef325c6715a078fc7
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x0fu2-0000000Cihp-1K4k-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-2mqh.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The completion iused for SPI transfers is initialized twice in the
same function, without it being used in between. Drop the redundant
initialization.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/spi/spi-virtio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 2256dfec5407..87ce32b6d133 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -162,8 +162,6 @@ static int virtio_spi_transfer_one(struct spi_controller *ctrl,
 	if (!spi_req)
 		return -ENOMEM;
 
-	init_completion(&spi_req->completion);
-
 	th = &spi_req->transfer_head;
 
 	/* Fill struct spi_transfer_head */

---
base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
change-id: 20260830-virtio-spi-fix-ca33b12bab2b

Best regards,
--  
Francesco Valla <francesco@valla.it>

