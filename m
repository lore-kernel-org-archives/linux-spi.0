Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883037BE7F;
	Tue, 28 Jul 2026 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225913; cv=none; b=nJqdK9eihbAeixaKof3a32icDdVjRm+sipOd7PxnmJSaDioYTwdMOJIKUG/oo1erAeW6JgqjIKor/ZIHxJhw3QRBlEDnnCD2KMVXFpDVKiDCgefWbsAeSb8I8DufVbmbwTCTmoh/OOPZfj3NydyD4pCHdkuveedsFpug3VRvsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225913; c=relaxed/simple;
	bh=AGbP6EP2ZkUWkfboiBreWXWa4lYu2eMeNXwhIXwiMmk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qM0forX883LssBCU2MOTU1Kk/CNIfQn+IylZq1hY/9ZkRy9KdKhIZvALMH/XXblxoF0z/ZZCDTo/UTIMahK7yQ3T4ibdp1t4vxT0FVtXSL/l/Z8xN21XpDawJQE7keLaxjmEHi8EexsIj/2St9UN9i7RykbL4nyVpOlgUk3LTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kN1FhgA1; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kN1FhgA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785225901; bh=snpxnt6U542+xHMzXEgpTZyLajaeaZHgHX/RxJEC8Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kN1FhgA1y1Fbdjh+hqUcUNnDDVmf6M2jFCqRkihzmqlY+RDlZDwAAYykskD4SnJSW
	 LP6MxFaCspOUZJ1uptX7oWc2A38tcKFcRNb/1PQ2N3zq+Hl/udU+HzRa/Nxix1tqL8
	 M6QlXjvceAVHMVBHYTEm6tlp4QDR7dJn+cRobCYs=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 12B9D80E; Tue, 28 Jul 2026 16:04:43 +0800
X-QQ-mid: xmsmtpt1785225898tek4xgipc
Message-ID: <tencent_D07D657D7D49113424BFAEA7931F60DB2F06@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25G1DtTywlptBNnx/yyZxxsrVnzx7lxl6RRF/9816SxZ1l9wTjC6h
	 XUW7mNwJBXeZa08waHGfS77qd26zN1O9qv5ktA62t+QXQ/HkajDtKskEvd2XeykcI/bAD9PffHho
	 9ETPptCxIWANbeUzQhy8y9mgMuFBIlt9C5lrVfkGMmT6Lia/581UG/rv/f83JsyAsCCMiOqrW9wy
	 kzfpnRN6p91Ji715UdGpj/q6v90b+bBEQU/kxrKxdsqGZvNDF7xVLcplG1x8oESQc9YRHn6hYOeB
	 QLfOP7LEW9S1AJhurJ3wPdxl6321VnD+JGZizPC6KekG1dN72pbbaPU20LVU9UKImOwDzNgxwcU0
	 XKtQd3YCJiqX2UtYiPZUEv3eODSdizZx4unrHmmbVt99Z6OUfDC93DoTgkX9plUdRdAqUZQK85eK
	 zDe7TiRfizYhNxcjpRxwQcug0MLqrt0e8c/Hqlu5HImBBtrh8xo+pZdQhmWVV1TwJ+jEZ6QXHhiW
	 5dDBJLMdnI+DCUymvsu6CTBFVjxfL3E4TogpUnOOm7qWVPclei3+v2Yq/TBbed/2WjSi+jQnY0GF
	 bbnwduL5TKzr3UR5UzO+E/j+vjAojHIXFse4sbgtkKxNYIMY6E1Ii5lb6DtchVGGnMZJN16YF6GD
	 x66G/IlnP5gp8oTL+ywuBBA2uDb9wAMPThoGioC2sYQVm84L6lVpMwLn3sdI4wjRqGrZMmi8eUKz
	 NtYQZicpEbSSv6YzfRUXQZeHeEy9dFIR59ClSbfOkF9C5vPLa8DGeDHkRZLeUlqQie47jFiSeoIQ
	 ddiXfr0Y6AQxSENO4aggjOW85axeyTlsVqvv8KC9pobmWTf2Bqjq9TGSY87B/se7Szf57F60hXfW
	 kzTQBJvjtwRef4Zg+vhk339KTYLHRNAzDxHJ1CKXFRq+YglVd6k1FEVAaSKxQ54IaXT9hXHAoTCV
	 1yass4NE141yWtdh2TL9F4bCLy+6u8jNRY3CjQ1H3Oe2Dutg/8rdlLyu7Uiu4ZzvYfnSZh0XBtbv
	 Jym6H8yuaKUVzpcL3174+7CECuamUjsAa3HKCBhA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jiawen Liu <1298662399@qq.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH v2 1/3] spi: nxp-fspi: use devm runtime PM enablement
Date: Tue, 28 Jul 2026 12:04:41 +0400
X-OQ-MSGID: <20260728080443.153827-2-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728080443.153827-1-1298662399@qq.com>
References: <20260728080443.153827-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_fspi_probe() enables runtime PM and then gets the device active for
the initial register setup. If that get fails, the old open-coded
pm_runtime_get_sync() path needs manual cleanup of both the usage counter
and runtime PM enablement.

Follow the newer spi-nxp-xspi pattern instead: use
devm_pm_runtime_enable() for managed runtime PM disablement, and use
PM_RUNTIME_ACQUIRE_AUTOSUSPEND() for the initial active window. This keeps
the error path simple and avoids leaving runtime PM state behind when the
initial resume fails.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-nxp-fspi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1e36ae084dd8..6be78712b534 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1275,7 +1275,6 @@ static void nxp_fspi_cleanup(void *data)
 	/* disable the hardware */
 	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
 
-	pm_runtime_disable(f->dev);
 	pm_runtime_put_noidle(f->dev);
 	nxp_fspi_clk_disable_unprep(f);
 
@@ -1345,12 +1344,15 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "Failed to get irq source");
 
-	pm_runtime_enable(dev);
 	pm_runtime_set_autosuspend_delay(dev, FSPI_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	/* enable clock */
-	ret = pm_runtime_get_sync(f->dev);
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable clock");
 
@@ -1361,10 +1363,6 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	nxp_fspi_default_setup(f);
 
-	ret = pm_runtime_put_sync(dev);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to disable clock");
-
 	init_completion(&f->c);
 	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
-- 
2.34.1

