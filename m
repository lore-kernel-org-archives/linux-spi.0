Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA123E356;
	Sat, 20 Jun 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944830; cv=none; b=IbuW+rxVDolO7hR3knzR02fJwsyQft63Wn1jrIqFxiWuS0+F8z2bp5ufqcINt8KERdUQ/NmLyDJr9jHhbi56s9AQvIzNj85vrd4Jr9q/XEG46OWap/H3DYB0ZO8r/1aeI70kaJYoEzibd/y41Zs8k2/XLg+wiiDH5GxxIonbVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944830; c=relaxed/simple;
	bh=Tt9JrOtU8rnhnmqH8LpNFQC9zOsf94JTx70w5ml2iPU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WKcaRH+U9qn7soF80wmRKwYJ7nCLszf5qHLlQefDTwAeadKqp7NNyFfhDY7pqZgIciF/eaDF/+swfkBvSpX5r1qMboGs+2SDD/w5bojPa5cUJN0cKnsbLMB/Y3qZ9nO+OL4m7vapkpQsiknQxQzzX0vOTJkYTrRjO/VboHeUzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bkFpPBCY; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bkFpPBCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781944820; bh=ej4UjS6cRx6UNjVFXf0AfbuCsehLDg9rIoULOGIKgXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bkFpPBCYkv66emcnAK98H1eqJX/ahyj8nzvhwDX6TDkp8nssLS5XScWdgmVfHHsGT
	 DYetbLU5S/5E7jSfOvQg6XYBIGHnOMlC2gYSqQF3XcbWvuCZMXAU760vKUoExZe9Ea
	 P62u7EFSDMjK7C0OKDm82BTDeoAUZfCezMVmoDnw=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9E3A1AF0; Sat, 20 Jun 2026 16:39:35 +0800
X-QQ-mid: xmsmtpt1781944810txpi8snea
Message-ID: <tencent_8FC0B8DFAF4AE67AEBA20548045D53A77707@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GEPgrppcuA74EQV5tNi72w4WCuYLJdMHtBzDMEU4f+pQi8TaG5D
	 2OsdYy/9YdrPW88cQe0butmn6IpVfHpOO5TIQEXyh/VVf/eEJ7Bk7WWxqp7AW/eHFeIXh9St7ZcV
	 kCz8gOJPlcx1MogunHLVaW6UggwbnZ0YkUyV/Plozrw4UqKPufLrd6aAXnjy6nlKvbIN8oKelxOM
	 XFFmnlAM/F8r/Tdd4ndizwV0lyjArKADgf/wywAyHwIQKPlG2LhN/+o5s2yqPpLvr86r/4Ykh6Ya
	 BIwiWmmR9KY7VTAikN1L/ZqqdW57t5LOsrGCvu3FYpVPtZkAkU2cBWE8TRuWGtonAGqakyqIgrxi
	 SWS7T/oFmdBp589QCQD0QRsnVBTajFxjLEeLtBVyNobsTPwNP8Pg5bj2R8cm1xgYhNSZuXdoveOP
	 WZV63XdNbargCAX8DTX0xwj6QKghIvzafFfwAptuwsNaawwXyEm8nzoJUR+rHdYF/UPjdYpMmf+i
	 ZATREv5ZW1aoILKqsWjiH7L5HOdP1/Nxq7plSYKbWHmjX3+MWx7vK+ARM3LgWUbfcMTKZj/CJqGY
	 euZI3PrjKTwHWDMnUO3o76zxpLvCCtdAe7FC5DP3QYK4b2hyXqt7EfLlMDcqPe4Rt7iwvnd0wjQe
	 kKvK1D1CVwoESOftNkmoeOfQ/DeartFBGfY3aemy2xD1MiqRSRl0+UjsyeK3bpebdHba+TqrcddU
	 b+2hHkreAOu9I5T0hGqSbdRh0ZM8evKh5okpku+FuCiazMM4LWa/K5OUnpeVnXgsElVYDtqH7Zzh
	 EbpYAE2aBs2mXKVuLgBWjWc5pKYZBX7R47sPnj09bxNjgFB2LWKFV42jwfCpKUkgc/BHK7hwnS5I
	 fLtQTy7LFvSzWvcKDPwgUi/wOSIEm2jpLoOeq4ENWO0XaVg45YJuW6VqcJZeipB1Xu5oDYEGZgNP
	 Wk8GPQbPwP7DDP4ENAUqGfpvLMKAGYk2KMN2u2dLJnVxKq+ju8GCLER7iGlq/cUJtQ9DSmbdsZsK
	 ATvqmrukawrPsMChdPWzIG2chFfKa437T88YBTq9Ll7KNmftrrwYzd5OmVsXw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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
Subject: [PATCH 4/4] spi: nxp-fspi: disable runtime PM on probe failures
Date: Sat, 20 Jun 2026 12:39:31 +0400
X-OQ-MSGID: <20260620083931.1120616-5-1298662399@qq.com>
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

nxp_fspi_probe() enables runtime PM and autosuspend before
several operations that can fail.

Some failure paths returned directly before the devm cleanup
action was installed, leaving runtime PM enabled.

Route those failures through a common runtime PM cleanup path.
Use pm_runtime_resume_and_get() for the initial clock enable.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-nxp-fspi.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1e36ae084dd8..d94a2a7b98d4 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1350,9 +1350,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(dev);
 
 	/* enable clock */
-	ret = pm_runtime_get_sync(f->dev);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to enable clock");
+	ret = pm_runtime_resume_and_get(f->dev);
+	if (ret < 0) {
+		ret = dev_err_probe(dev, ret, "Failed to enable clock");
+		goto err_disable_pm;
+	}
 
 	/* Clear potential interrupts */
 	reg = fspi_readl(f, f->iobase + FSPI_INTR);
@@ -1362,18 +1364,24 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	nxp_fspi_default_setup(f);
 
 	ret = pm_runtime_put_sync(dev);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to disable clock");
+	if (ret < 0) {
+		ret = dev_err_probe(dev, ret, "Failed to disable clock");
+		goto err_disable_pm;
+	}
 
 	init_completion(&f->c);
 	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request irq\n");
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to request irq\n");
+		goto err_disable_pm;
+	}
 
 	ret = devm_mutex_init(dev, &f->lock);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to initialize lock\n");
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to initialize lock\n");
+		goto err_disable_pm;
+	}
 
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
@@ -1389,6 +1397,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		return ret;
 
 	return devm_spi_register_controller(&pdev->dev, ctlr);
+
+err_disable_pm:
+	pm_runtime_dont_use_autosuspend(dev);
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static int nxp_fspi_runtime_suspend(struct device *dev)
-- 
2.34.1

