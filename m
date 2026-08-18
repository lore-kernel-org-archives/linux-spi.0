Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9EF2DF13F;
	Tue, 18 Aug 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058359; cv=none; b=A8oJFHTH0N/53XnMp9qLQkNGcjIH2RLk6+RaULsCrPMq0s5sROzZsF77KJ0eB8Q6IPCKWFMSUWWjUBveKH7JJPk2tCi41qLvkS7VNdttKf7XR5jE56dusqtv0Su/0ca7qDHrC1Mn3un6IarhDawpbW9AEaR4My2zQ6gkcfG6NlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058359; c=relaxed/simple;
	bh=hniaFIhoOHzqge2o2wLYQ0rXQ5lsV14d8559TujYhOU=;
	h=Message-ID:From:Subject:To:Date; b=hxZV40z87jcs8Q5+AZqQL1FIjq/sB4b+j+ZBYAbOTxx6QnYM0ahzIVjxFarn5C1gwKnSv1wrF810NerEYLPRK0Z8S7jnqCy+JAM2jsFYp0SzReF48wlixwh6GlB5ifw+OmN9Wv0J+V8QZgrYFv1ZRBxynzR6ZqDcULCsu4FCoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gE1uzqCD; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gE1uzqCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787058353; bh=Asc17psHKNAaSbNMycO1gd0Irfg/HEZLdr8szashNPw=;
	h=From:Subject:To:Date;
	b=gE1uzqCDY44EC3qXSlRjW3t0ZY2d/Z8qjL5Wu4bQVwzl0BSrKhreCQnvLD/HIPxIC
	 Kf/Rs38MbdNokY+wydyhJs5MN0YOftYq4R9GMSNpnSkf2JoK/W0ZworBW2M7+S/a3t
	 HHUZhqp8M0jDMaP9MvVGWk/uYrUrF86nYDOXXfRc=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787058350t92l880bm
Message-ID: <tencent_DD16C0EEDFEF4ACAFAB5A23EC8235D462707@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuTFiJHSXhG2jjRqHVE0lhZ6fR30r8eFb7fhrQgkuPImiL+Qtb/B
	 NM88BKMuz/8v4tH+QUMd279UbaBpmn46OEmHiaZeSlfl1WsCqtRDu0sMbg3GB6GdbZvdbKS9NzSD
	 jjTVzWhszt3cSrOb7QXZ4AXiF2ZKAMA3G3shfUvhK34GpmjoyvsXjjpHKOoKmsOChmDP8RV3kb2k
	 nKXp1LwevqXaXeLshellpMc3CxrrAXqN24DRqPp3wLlcL6Zu36ueYGAyniny9TxBzoRT04D5vcyS
	 7AnByDk77D+fJsCnGNv1EllfI4rbsuYm0v2Ink3DmuxOA/cKflbjtKI0f1csRbtQ29rr0QKE1gfC
	 fAKekd3P5fRDLoCTCUrZ+w2quQexQ6aKQwjPiLz8NsiH3WHSlO+6sfOBv60hdWJziOG7HfBa40GA
	 kDXqeiilfdxmiSru02V8aT3zcyd2E4LpdgsZKwRh4s/2QKeX74rHQTY4k5et/pEarRy2aPf/Cu4V
	 4sCQq+D3nTRoNIZQztwxRNeDWD5+oNIlqpPc5HA0IQwqfjd3dVp/0Zdzs0rFC1KlbLoPnm+GI2R4
	 mYjT/W6DEZ6w/MBMKnUE4GIimhXscSAw9mrZW+OKju6s90xQW4RNBkbxXXwh7+yjtXsDtv0aIMZZ
	 5sxuLI0rl4cxLUaPIvL5HqHckiO2mYuIZrPiKvUVoOU0GhrDokEC7NV7Raa1shi8GXjDRKb5P/3b
	 g8UCUAoSZd01fk+McPhY+LZfC63NiMjYNPMBF3TYT/nw7MwIvBrnhnJICRLRMRCjKdHDNdd5ByQD
	 1ptwrpmo5e19yS5iEI5OYQ7yHJZIRFI1q3uhq3XFEeRodZMXtKDnmJ1hR/PniiLTM7qMHENFD6Hl
	 fHDVLjJz3radqFmMCGpWt65WNIaSfd40amc7xTbkiIXSVsfM1Mn04BWlaMZfYwgYh/ZDojPLiWTr
	 /zSegCgF8MDdTwLzAkEBZf8bMmwc6UhLJ8nYaumuyMYN9v7Dl6aywNhPeoV6E4Wcp/aDRBX8915B
	 RUnm2E7/Bo8d3DzgHP1ef6tV5cGvvNeo56VKdIZw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] spi: rockchip-sfc: disable runtime PM in remove
To: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Aug 2026 17:05:50 +0400
X-OQ-MSGID: <178705835086.291840.15105782669010201958@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

rockchip_sfc_probe enables runtime PM and leaves the device active with
a usage count held by pm_runtime_get_noresume(). The remove callback
only disables the clocks and does not disable runtime PM, leaving the
device in an inconsistent state and leaking the runtime PM reference.
Add the missing runtime PM teardown in rockchip_sfc_remove to balance
the probe's enable and get_noresume calls.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -743,6 +743,11 @@
 	struct spi_controller *host = sfc->host;
 
 	spi_unregister_controller(host);
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
 			 DMA_BIDIRECTIONAL);
 	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));

