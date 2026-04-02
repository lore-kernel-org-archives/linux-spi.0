Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705EA3E5EF8
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135432; cv=none; b=s3Q01fAUWhqDyDrdy6ASDX+9r5GMtjWRqm7rgprc1HZT1XGl6suko3VYvUu3QISaOHcjBY97/uxmBQPlhr4vrv/jvuyd2vLehpzqq801oeS7bEM37V0FJIymsY3m76ucoyfrwN2yLdvMvK7gNnnHeS8fNvQVADh1jHPs6XLJZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135432; c=relaxed/simple;
	bh=U4PLVNmitmFk0IAzfLOjKlCSu5Fm4qOHd5/vnDMdH+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwApYzzIh5AQe+KgmiWvsFm5HGmVuxowXmtVxPrgiGW9OeTnx8G9m4Na/LpNb2bUuapCp8EnPN8UmJiaANci3W5qwYAMGv8R+0r6Ey0hjEylCt3TULe5fV09v3RKkTQnlHg7PCGWRjgTIF3rYmqru17vj1uGiJSjJ/2Y8cWvQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmUFXiU8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmUFXiU8"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d02a71526so554369f8f.3
        for <linux-spi@vger.kernel.org>; Thu, 02 Apr 2026 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775135426; x=1775740226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlmD1kbg6mKeZNYx7OKw0AzuVS9sA1logO6t/+1LGUE=;
        b=ZmUFXiU8kwhfSGUyqisuuCQ2bVsLrPTw2yc9TR5k9u11zYPfk5beikptV4Ad9XrFGX
         RhOyUIORtvBjG5RRk2Bv3QL3JcADrXKGDcVtn1/yc4j/hPQo5q3e5MYfTuQ/EbTny+n3
         I5FOs/xpYcHTKdw/5gayHub9BWdvXKgRXLoHhmvdDYudjU8LGkEYDRcZYogGgjV0Kxdw
         /bg/KF1lF7V7aSw1SkGt3/U2xZwL3h4i2IHDPiR9sZpa09LHoPd1yoQfsZwI5NdkbA1I
         uPVQI1KIm6F/FRwx9g4O1wwZvyzfViiy5M+Ulroag7GxFiHEifIYzpEP6qEgKAET4ngM
         R5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135426; x=1775740226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QlmD1kbg6mKeZNYx7OKw0AzuVS9sA1logO6t/+1LGUE=;
        b=GDRdoeFM3VkN7FwHxQ1eSHPJQLL6cpUcIpcKhcq+46Kc4/jEDKGpR1UkWufWSjo16j
         zBMDu6gBQqj3xkd1PEjzTlY2fnbaPC0AvFUu6G2qxKkQOsA2MwUtoMgcc9nUcSGRdJvE
         26w++CT0VEXrH73mXvjnJOvsxSYRwEZfxhO/gKntCz7gtULhbcm5TZ1dW4u9JCopBbh5
         8MJ/YJvCpLJSgk9SCI5I6iDgRz8Tk/8WpiQdLX4z2/HVjQ6nF9+FQrSmJ6zkVXRcflYh
         Tr6CBmOWWtS+MJR74+2/VmMQyX/YNjjoq0+fPfS2qw+NrgwkYYneJ9OFyXoxjiRytrKL
         T7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVYeFby1L7gXdhCEuJH788we1XNpRG36t+Zm/FLk3BkyJ6BefvenFrExCdHixD6T5ogRCqT6+AeG1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRVc7k19ahM+nsf7rdtuGXJFHeFgVoVPnkRqBTOljMfrcsppG
	ZAc2vqOCf7mnbPtSrX9AbGIbG8RWQIWrABq3DSwFzHZfcR0h5OO8A98G
X-Gm-Gg: AeBDievN/0OA238sHkRtCFmAL2fpIMJQexHE1niwqkqhppl7qMHB7txssBY9qqKzsU8
	m24BmU4uZzHtOWR4KCvPmEhs0KHjLibWmWymje77rN5QAvrkJ9V5zwJBZdtVQpYJIaGA1xuV0+r
	ElTGE6YB4tRz+XlxobnSEOtCBoTZ3dJgjN30Hmu6LfIdLTW3JkAy5utEyLhuro4QJKvCQiIvmlj
	7Jz+lkoI2V4x78jzPlz6p38MBIQV8qQZiFzqW9yPo8xaaIiFg5Ot2s3zxYBsgVr/L9JxQ8rJG4l
	g4Eo3nhGxTc/5ogdgilUwg7N9VikBBhSJwlifEMTheFti355Elfpw4Nqk4lyib6ORdEOyHZCKHi
	/a2NBONXOpv7t0DcOugWXI0dDh8tQ5pT+eDX/DRmtsUwzHiODTA/PqpUpwdwDOrC+zPXLMVhknL
	CezCMPR2ik0uGdCzwgJXV3X9E6YgWBfmdcFpj0miSqP98OWTRviZtAVJ6XAy0=
X-Received: by 2002:a5d:61cb:0:b0:43d:1c21:ead3 with SMTP id ffacd0b85a97d-43d1c21eb20mr6902373f8f.16.1775135425685;
        Thu, 02 Apr 2026 06:10:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:1526:47aa:5ab6:5a85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm8040753f8f.4.2026.04.02.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:10:25 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)
Date: Thu,  2 Apr 2026 14:10:17 +0100
Message-ID: <20260402131020.143123-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402131020.143123-1-biju.das.jz@bp.renesas.com>
References: <20260402131020.143123-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for RZ/G3L RSPI. The RZ/G3L variant requires only
2 clocks (pclk + tclk), unlike the RZ/V2H which needs 3.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag.
---
 drivers/spi/spi-rzv2h-rspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 23f0e92ae208..38ee09e389c9 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -811,6 +811,13 @@ static const struct rzv2h_rspi_info rzv2h_info = {
 	.num_clks = 3,
 };
 
+static const struct rzv2h_rspi_info rzg3l_info = {
+	.find_tclk_rate = rzv2h_rspi_find_rate_fixed,
+	.tclk_name = "tclk",
+	.fifo_size = 16,
+	.num_clks = 2,
+};
+
 static const struct rzv2h_rspi_info rzt2h_info = {
 	.find_tclk_rate = rzv2h_rspi_find_rate_variable,
 	.find_pclk_rate = rzv2h_rspi_find_rate_fixed,
@@ -820,6 +827,7 @@ static const struct rzv2h_rspi_info rzt2h_info = {
 };
 
 static const struct of_device_id rzv2h_rspi_match[] = {
+	{ .compatible = "renesas,r9a08g046-rspi", &rzg3l_info },
 	{ .compatible = "renesas,r9a09g057-rspi", &rzv2h_info },
 	{ .compatible = "renesas,r9a09g077-rspi", &rzt2h_info },
 	{ /* sentinel */ }
-- 
2.43.0

