Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC79545D9A
	for <linux-spi@vger.kernel.org>; Tue,  8 Sep 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897211; cv=none; b=FnYkQodE2P+r3W+awr0P6EGcIpQf7ZLi/4yJUy9FRWxNcCYpyukyuj7wBq2mZJ8bvnAoMMlxbhCa022oZtwzv+pUCsoycz6b7EycU0KQZH42AWyF/IilekHlVM5MUkYHHu+tAHNF562jy8XIezfI/pnzw71AUkBq/oWZPwbuFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897211; c=relaxed/simple;
	bh=NTd2pp5ANgj0lmniIesf6GIajPDFvFvZIKDPSGDqkEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RX4l/1Pxv23NIfSWzxB9KKhatMzo1y3bxLAEVIBGLyb8xl9j2IvMuP+N5mBVWtXXVLfDrjtUJ1//I+jcGp7PUfkdXkHKfxE4b+G3j6thFq6I30Ssw8QmZheXsi9/XgfQrCnAeJLHOn9VA0dwzJiYrq+tNIw7paiIFnzNHXeiTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0jVGLeX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0jVGLeX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956869750eso45110475e9.2
        for <linux-spi@vger.kernel.org>; Tue, 08 Sep 2026 12:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788897208; x=1789502008; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d34WrDSCafXYxFFebWg84mmDn+YaaqWAdBrUeMqE4nk=;
        b=o0jVGLeXFM+lkuUdxQ7YjkyrzTQdtuRvHQIUVQFmCBpFCSImOEaxOx1hKNNFH/5Lda
         7RjLKVW5Bv1H5OTu9iPjKlA6FxFyZBco9XQ/pnrTYGutKmF/Bv7hx6fu1S1CyqFpl5cY
         ROHtSGj/aCDcvGkFzXzaC+Qr6i9Sh5EilyIsvplDPxMA/6nBJynUhf+cVRXnRAloEbQU
         wlxqGe1O4LJyA9+rBBOapvL9sD2rtQmtUo9fhkv1vbYXSO9BxIECIsGgdvu20irZOQDA
         /PZJhXJotp9GWyK+BfVraNfBNx3Z07uNK3kxj7cODhypCgeSVbf68AmT/7CS/7hcRoix
         cgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788897208; x=1789502008;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d34WrDSCafXYxFFebWg84mmDn+YaaqWAdBrUeMqE4nk=;
        b=E1Fmd4epKp7cb/dquzeCJqCQMo5FqWZo9TmaJqZIg08vSlyiFfdO6CPOBB59JMDY6j
         xpw7X2LAvYF7XK6IzhGvdXnqcurTAHkGV83Q4Qk+zZGisdKgfzyK7nC8XZJYbgyhfQMD
         fJYYzDx62ZBvcJGfyMEm1gAtmiCE7i6dMxTkx/mEtSMYDHrwT1pcicws4I7XGtW79h1r
         HtXCLU7CacbLd9uq1VX0nPiazQ6UBnfplFWgjPv9jALGLS9ChepA5051tBtci7H+IIps
         WCEF28h/6ck+9YmnK3Z8c7oapyd9L1Nh2XGkMukiLpuBUFaVcNc3XihQ5jR9c8B2tdR9
         yzyw==
X-Gm-Message-State: AFuF++lY2IU+60XFqFZUlTY7O7PH+y1BHHWsi12SJhD97udu5lGrbfDN
	f2sDEZSbvtSRQPsmQn/Ap1DAtVCe88d+Davg0WCOJ5a2JRvy3SzMCrgfYgjp0g==
X-Gm-Gg: AYBFou1FAkHz9E2merJdXVInCdWMRKiEMmAtJnJO9Z/jhnlyZKpYUkABsvBP3jA02NE
	xA/GLVrAABmxmGzaZOAlCh0q8OB7ii4g3lofNdY0PC9rqk6mDxhQ9bjkVpH7Wx0o7nzvYfXboDR
	uaSiAeJr6iQJX5sNNTOHpubLOyTJVLM59x6dzlplVrRVsBo0saeJzQepQXS6s8Z1Hi9Eh+SsZMi
	+gw/CVm1m1cwizmAEMFdfqkS7pWTr15iCGx++tboGLVwhSppUji6pzTM3WWOp0x42Uz+TtgqsCm
	/2JBTnJBf9IgQvzOh62VRYe43J/NO6dQ6IV1Q5KvyV1VrWAQVQncgnhtLCyZ0xe+FVTa6dDFvii
	L0cO39eG0lLIce4qZu8HK5jpKAN9jvJlge4VJKK+YzW9lie0/bKFMshIAdnkoJn3PRzE8bkO4wy
	cRbLug4kudQjr/8OdGRIEd/QxSdiHF6SuCJ/B/wQ5bIPkmzvL5hN68JHHwh2QA8PpXvHbfev8+G
	QCTWSkRiltNKXz7
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49cff19cbf4mr255212345e9.30.1788897207627;
        Tue, 08 Sep 2026 12:53:27 -0700 (PDT)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm547748475e9.1.2026.09.08.12.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:53:27 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 08 Sep 2026 21:53:16 +0200
Subject: [PATCH] spi: spi-qpic-snand: remove unnecessary cast to '__le32 *'
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-qpic-snand-unnecessary-cast-v1-1-26df1cdd4bb6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ6CQAwAwK+Qnm1SiEHWrxgPTbdqLwW2SiCEv
 7vhOJfZIbSYBtybHYouFjZ6RXtpQD7sb0XL1dBR11OiAefJBMPZM/7cVTSCy4bC8cV0yzTwtZU
 kBHWYir5sPffH8zj+2d2XPm0AAAA=
X-Change-ID: 20260908-qpic-snand-unnecessary-cast-97d08a41c9c0
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

Remove an unnecessary cast to '__le32 *' in the qcom_spi_io_op()
function. The 'reg_read_buf' member of the 'qcom_nand_controller'
structure is defined as '__le32 *' already, so the cast is not
needed.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 61b1f2eb19ce..4bee26b06ff1 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1485,7 +1485,7 @@ static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_
 
 	if (copy_ftr) {
 		qcom_nandc_dev_to_mem(snandc, true);
-		val = le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
+		val = le32_to_cpu(*snandc->reg_read_buf);
 		val >>= 8;
 		memcpy(op->data.buf.in, &val, snandc->buf_count);
 

---
base-commit: cb2ad3c020579bf51fb0d702db9cf64af9698377
change-id: 20260908-qpic-snand-unnecessary-cast-97d08a41c9c0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

