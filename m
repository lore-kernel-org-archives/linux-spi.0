Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8593ABDA8
	for <linux-spi@vger.kernel.org>; Tue,  8 Sep 2026 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899048; cv=none; b=hyUCs0pZ6Gm0FBzcD2Xx8y0Ex+KpitgVIgJep34pIcuaBoWDmKCrAfzbNgB1gKu7ID8KThhBdIbVKnRnaMEUdjF1smPtRsDAOuOqEsyASNjjLJT9ccnu/0nb6AyWaXy8fRmEK1bfpAaE66qekdF7SDb1OBiPy6FFqiCNY6yhjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899048; c=relaxed/simple;
	bh=fHmN0IfbJYKRxXiKNbPwjI+pza8hAMD/vlghiSxGeGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D8Mxf4+94Rxw8qSug2kEdnk7n2D2H0ONQ090UAl3GPQyHH9jwxzzSGqyWFRhHFc+NKOIt5F8uKivx6U4tr7ie2qPsCr+ACDOxgVScn8Pt/6vqch3jER3V15D4lUTc7j/8sQy7YwZIkKtDc1UeMblh+lqaHWQgjyqWYyI8EWFNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAcP3aMb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAcP3aMb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so71588405e9.3
        for <linux-spi@vger.kernel.org>; Tue, 08 Sep 2026 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788899045; x=1789503845; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1MqNm2QyW+y3V2DcOMpwDww7mcE4W2SOM19bQm3wPcg=;
        b=XAcP3aMbFY0oqYaXg5+6JcijyGHd64C0DK2vHxUwVvBgXtcx5TONIhTDNewvy5eF9z
         2sR5N50OpFDFwOV+onVm7Pn44Me1P8UFi/zh54NmUOSG/vyNab9enjOcqAw62qHz8GnT
         K8i4P4Bff/BZGwPGgQT9HONsdXvOtyms2tDjszAf+WOjhTWgvu1389E+bV+61Fx9Ehch
         eG4H/qNNsliMNG/Tib9LSy3ov3D7PmbvldQZIgNjmsIhKRhvXHGpMfwERhf2rjOBhNEm
         iZGoJyc86Zh8+I4TA63q2B2IW5VImh/6oYuNp6l+DCIIwkBxwLQgWkqO3cf9K574v7Ek
         C1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788899045; x=1789503845;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1MqNm2QyW+y3V2DcOMpwDww7mcE4W2SOM19bQm3wPcg=;
        b=O5KNKUUGcDIZfINdGyWHwSDuQUeN3SGlqnzLmXbe4JvOMZF/TwRFnE4i7V+JLmoT/v
         njWu87r4Gc1RRq55nO0604Vx1ztZJcKjcwXBCnH4ITXb6HM/fuBOEveTt92Lv78TW+Sa
         8v6W8FpVHPf0WToSCB1rk5V1O5F+IjA21ZBWuyrvbANvGMxOPLUI5GEKKZkIz+zHeNYD
         6jJJe5kyQYzNQLngdm1XkxyzeLzeg64r8O0Rrxt1YJZi5MiEJzlahtO4k2OiMAopHsxx
         tZru5EtVjqGiYBzG7WptLkByaU5E/1b0rKMifM2zJzepGt14Yz8HTOehtzNabFJc0ehX
         iUwA==
X-Gm-Message-State: AFuF++kvGTjMleYLqw3eMTZzlUHe/IpmbbAUHh5NU6WnQi9RHMVGW+E7
	p8+Lz8UHJPV/9DBnRCWKQeUwtKGAh5BveEl87wKgD/OQITtV9+hUgf7r
X-Gm-Gg: AYBFou3KOrKtrqx2pUSCgZlKbnSjN+aUBRXDiXpOH1koMu2h/6rpf/jCOIO5cfbObCy
	ZCYvmRAzu5Zd/reSa6MIdwyjfdVGg5eFgEJQbgu3GmNKa6kngKavglv9YhUZdtTtgfjqyx+yZ97
	Ubjx90TgzmGNB56qEghZTb3hNb4mLNu6T3cq3clDReRXHJBVV2tlhhR5TAto1ZqnPsct9pV8hXg
	TCwE6vcEco6p2Jqac2z76RbW3bbtL6gFeYbTeGqmCSA2EiQKXmtSffSkoSQpR2DDmS2PBGY3kpf
	a2rT7pS9IncwJ4FtrNI6H4rGaKqtBevNDG5ntD3u4Qa4f3SObSf7IKICw+Cb4c6JKfrfMlotnjS
	ljOCDTMynRB+iH9/H8GZf8sJWCNpSZCwh1x5r/MGp0N9v4k0ZkXsjOrlGy3jfbym3KvTfac8R6q
	pvlNh+PBmUR2xeCaZjzfaiLVRzC9m4lxdKyCKf2bkgW8H55RapbpfRYkCFMlWjAXnuPfaGp9Mrg
	Jx6OV/4Ei+ISGUAlWYQukbwzyVO
X-Received: by 2002:a05:600d:8498:20b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-49cf828c65amr222198055e9.16.1788899044466;
        Tue, 08 Sep 2026 13:24:04 -0700 (PDT)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm418324665e9.4.2026.09.08.13.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:24:03 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 08 Sep 2026 22:23:55 +0200
Subject: [PATCH] spi: spi-qpic-snand: remove interim 'dev_data' variable
 from qcom_spi_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-qpic-snand-drop-dev_data-var-v1-1-147d3fab6c48@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAwA0F+RnBfIylC3XxljhCZqLrVLRxHEf
 7d4fJe3Q1E3LfDqdnCtVmxNDfdbB3HhNCuaNEOg0NOTRvxli1gSJ0HxNaNo/Qr/GSs7Tr0OD4q
 RQhigFdl1su3q35/jOAFXsgszbgAAAA==
X-Change-ID: 20260908-qpic-snand-drop-dev_data-var-f6e740cc0227
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

The dev_data variable in the qcom_spi_probe() function is only used
to temporarily store a pointer of the device specific data before that
value gets assigned to 'snandc->props'. Remove the interim variable
and use 'snandc->props' directly instead in order to simplify the code.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 61b1f2eb19ce..9eafaea74f6b 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1585,7 +1585,6 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	struct qpic_spi_nand *qspi;
 	struct qpic_ecc *ecc;
 	struct resource *res;
-	const void *dev_data;
 	int ret;
 
 	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
@@ -1613,14 +1612,12 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	snandc->qspi->ctlr = ctlr;
 	snandc->qspi->ecc = ecc;
 
-	dev_data = of_device_get_match_data(dev);
-	if (!dev_data) {
+	snandc->props = of_device_get_match_data(dev);
+	if (!snandc->props) {
 		dev_err(&pdev->dev, "failed to get device data\n");
 		return -ENODEV;
 	}
 
-	snandc->props = dev_data;
-
 	snandc->core_clk = devm_clk_get_enabled(dev, "core");
 	if (IS_ERR(snandc->core_clk))
 		return PTR_ERR(snandc->core_clk);

---
base-commit: cb2ad3c020579bf51fb0d702db9cf64af9698377
change-id: 20260908-qpic-snand-drop-dev_data-var-f6e740cc0227

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

