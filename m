Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794159701;
	b=gbV+Il6nib6kJEqHz5JEHW0kBZvGmF6p22c5SaDNI4aGQP9wQosO+dbnstOLdRsRVtJc
	 fz4IljRWIn5ElxxmrAXYtDt8p8fhu+YlTk9pSqHQlNzKQB7u069nB+6dFvi3TPoeVpmkO
	 LXeazYnk60E/aOmxdDc9sqUEzD8jk+miXjCILkESK5HBwhAh+7SUob/Y4tMej2pIqu5RF
	 nCR0bl+D4SCe+/ztAFCywbICH3+Dguylcm7LG0zA3whEd8XxvQhgicR2fEMNvu3glkJum
	 9//zN9qU61YREe3QBVJss/JwBVF9c7iRZP0/0LLk6QcB2aTrs8ostraMlFk2QuKbblA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794159701;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:
	 X-Source-Dir:X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:
	 AntiSpam-DLSRS:AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=GuCEUk+D57C1uh6zVqLkb4f3+lp4MzyMcZvNcQqPZDg=;
	b=t3HGEa9WR3EhV9dnvDtthBTk75JzGWbePi3DyOXa7eZONRPlCZnrAfweiWC63oLrYn14
	 QPxea6Fclk3ZBqGUwdY691lwvDJdSlkeQQJcaoUkJuISOC9Fsrmve/RA7kxUHz9jNfkUl
	 5RgymA7x5EbMFz7ZyBQfS2MQcovWT/QR5N1k7zGeKhqtPNm9XTxizFZ2ac9JbHGDIqL9R
	 owkry+uCDz5b6/fqC2QiSA9QF3GFfmGgY/ui9Nd3ENC/OB8GzQV08UH2/CFS7as7s6KXL
	 2OQTRSl8fftM3CZYKIMmxWkyQbp87yw7R0z09aPq1UcWDBiU5I8WKmAXHwY77MCLKWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=iUxO5nuL;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=epkPDNn0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.3
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63D606A31C;
	Sun,  8 Nov 2026 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C63D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=iUxO5nuL;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=epkPDNn0
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com; s=arckey; t=1794159699;
	 b=TqLcRlNhrBPathawZxhOrFHvrJ46KTOclJ7quqaKI/mYtTVHKhAxgsjc3tKSpJ4ZW8YVzumTfx
	  hLJvD44+E47LorZ8Ff7oBdDoQlZNM5ZwE9diS46KuHggJZoGJSJcLYjN1kLp6pJ2bRo4O3XY8N
	  rzQIC8jQvDkHC3ewBf1EqDDtFOIn7b9zq/QrqyY9MxeeKakMZu66vuRR1tCOfYCc5OlbDSpMET
	  wHaynHjQ4AcNYhjoCjUtpBAaL+e52sAiVnJKQqoVweyb4eNCDGvTabghPgCqAr44195JneqyN9
	  zDdSdKAQbEIzVhWmgqLbQwoerB8Euf197Ga9jElU8N0z0A==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com; s=arckey; t=1794159699;
	bh=f6VW1MvnrvYMrfcCLmWVZetubLXwndYussOEkJ8pShI=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=JgsUySuRsd8KsyY1wuoV8GADGuGF5Hw5ZYjv2OCu6lHuPF2aJdG38Y85KoXDTUdpyFinkRt2Ax
	  6gmC0ltFyYMrEeOP0unPMhv4LuKC0KorZgh137/mBWfH1Z3Sa2b2D82n0RGc4VtW9efWbGnMAM
	  o6DRuKM4z9hCGEOoRrJEfJxs9JCLLgvVJcZB1AcWAP+eq/86Y4Zn9wESkx8kcVLjwIbpkgWxD8
	  m+V9b4scxZ/GJIP0yTKTP+V8kyYBJG4jNj+xmesJKAMpGYVq+qMzBX6itbSJXQgIii/0CZXGFK
	  lxnCD85lnqu/iMagnexOrMlNSlBukI7k3TKJzp2ilfXScA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=GuCEUk+D57C1uh6zVqLkb4f3+lp4MzyMcZvNcQqPZDg=; b=iUxO5nuLW5XeIhFH+59a5iGjVU
	FWd1RSHBBxyF7IyQP7OkMPe/MesngtPYFb8tmKxVFhZmC/B01XpO1A3wbii3owrrK9PpJGMDzH6s9
	6ZO1MQnusizLQH7k8ZSPxS/hUdhgV8Lg9i565DK17st7IPPBmbkrZOrcoTbbub3NJ4kU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ6tX-00000005FKE-42Gt;
	Sun, 08 Nov 2026 17:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=GuCEUk+D57C1uh6zVqLkb4f3+lp4MzyMcZvNcQqPZDg=; b=epkPDNn0n1mGyBXyhhYFXxiiSB
	kOl0mAii8NQbLgzIAAK+rzOJcL7SQo08LqvUCSqk496EBOXWC2sL20l9OV8gfRCU1hzKJgiA73U96
	TNEB4SJ8lS+2vJrXxRCc20ybHCE5jBUcxu0JXAn2iTAsBLZP7N+R+R/RMAFuUHZVUpNc=;
Received: from [79.17.15.196] (port=60387 helo=[192.168.178.158])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xQ6tT-00000000EOl-31vG;
	Sun, 08 Nov 2026 17:41:27 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 08 Nov 2026 18:41:17 +0100
Subject: [PATCH] spi: virtio: move teardown to .remove()
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-spi_virtio_remove-v1-1-fda5f0996290@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBtIgrahV5ESNE7rCDUyo0EQ7
 27U5Vv8v4EgEwq8iw0YEwnFMcM8Cgh9M/5QUZcNVtunMdopmcgn4pmiZ/zHhMoF66pGd+XLVpC
 7ifFL6/WsP7dlaQcM8zmCfT8A9Kn3Z3UAAAA=
X-Change-ID: 20261108-spi_virtio_remove-8c285a0d4725
To: Mark Brown <broonie@kernel.org>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=francesco@valla.it;
 h=from:subject:message-id; bh=f6VW1MvnrvYMrfcCLmWVZetubLXwndYussOEkJ8pShI=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkftjjl+K7q3WhZ8XnW0iO7mT6kTuUKfaRSdrA2uslFb
 ZeteubFjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAiGW8ZGb4aX3+5jD8l7dTr
 sKDHjA37tkx9Inh8Hr+wr5/qml2Kl/Yx/FN0vlzMdfz7j2dJ+5se3Jpj8f36fy/bjMqWHy1XLq6
 okuMDAA==
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
X-SGantispam-id: 302caa1e16385c5e8fff079d2a365b1d
X-AntiAbuse: ID - 302caa1e16385c5e8fff079d2a365b1d
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xQ6tX-00000005FKE-42Gt-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-qv6g.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The .remove() callback is not marked as optional for a virtio_driver,
and thus a missing one is a bug. Moreover, the virtio framework expects
a driver to reset the device it controls during teardown and explicitly
checks for this reading the device status and WARNing in case it is
still running. Any devm cleanup action gets however called after that
check, leading to the WARN_ON condition to always be true for
spi-virtio; thus, an empty remove() is not an option.

Move the cleanup actions to the .remove() callback of the driver and
adapt the surrounding code to the new behavior.

Fixes: f98cabe3f6cf ("SPI: Add virtio SPI driver")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/spi/spi-virtio.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index 26f9711c99b3..2eeb79ff5aa2 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -315,10 +315,8 @@ static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
 }
 
 /* Function must not be called before virtio_spi_find_vqs() has been run */
-static void virtio_spi_del_vq(void *data)
+static void virtio_spi_del_vq(struct virtio_device *vdev)
 {
-	struct virtio_device *vdev = data;
-
 	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 }
@@ -347,21 +345,26 @@ static int virtio_spi_probe(struct virtio_device *vdev)
 	if (ret)
 		return dev_err_probe(&vdev->dev, ret, "Cannot setup virtqueues\n");
 
-	/* Register cleanup for virtqueues using devm */
-	ret = devm_add_action_or_reset(&vdev->dev, virtio_spi_del_vq, vdev);
-	if (ret)
-		return dev_err_probe(&vdev->dev, ret, "Cannot register virtqueue cleanup\n");
-
 	virtio_device_ready(vdev);
 
-	/* Use devm version to register controller */
-	ret = devm_spi_register_controller(&vdev->dev, ctrl);
-	if (ret)
+	ret = spi_register_controller(ctrl);
+	if (ret) {
+		virtio_spi_del_vq(vdev);
 		return dev_err_probe(&vdev->dev, ret, "Cannot register controller\n");
+	}
 
 	return 0;
 }
 
+static void virtio_spi_remove(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+
+	spi_unregister_controller(ctrl);
+
+	virtio_spi_del_vq(vdev);
+}
+
 static int virtio_spi_freeze(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
@@ -415,6 +418,7 @@ static struct virtio_driver virtio_spi_driver = {
 	},
 	.id_table = virtio_spi_id_table,
 	.probe = virtio_spi_probe,
+	.remove = virtio_spi_remove,
 };
 module_virtio_driver(virtio_spi_driver);
 

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261108-spi_virtio_remove-8c285a0d4725

Best regards,
--  
Francesco Valla <francesco@valla.it>

