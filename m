Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D73B6363
	for <linux-spi@vger.kernel.org>; Fri,  1 May 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644003; cv=none; b=RlkvQBvRmQGTgaNY2PoBgGKHjYIP0fVdxT4mqTHwMtI27DS+fEO9Kc/+VLvEk5ykIqd9UeZIKl5CkXdMq902CZHA6tG0DU5yRvpeV3CQqKHLL9in/1ULHeJRzfg2zhffoWIPGeeqvgp2mgIwA/LMAv6YvqOXPPLMPHac9TJQMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644003; c=relaxed/simple;
	bh=KyuZZJR4P+3viFsaf+3v9ITJ1YxHUVlIISu9qYGcGWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pHlR8owoJRQ/dKYvByO93ropg+21Kjt/VxOFH2bSpeLU8z7VZYBG5s6J2QiSwZ64zMdHpfJYUQk8hLstMm2ko47PV3YV5Jn4GJbFfdbsRyvlkRP3R2KaM0PoJnV7/yFoO8qetYPh+mLxujF6bGNzkjLZGoiUe5TvhnkDwQoU670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si14YlYE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si14YlYE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so16088065e9.0
        for <linux-spi@vger.kernel.org>; Fri, 01 May 2026 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777644001; x=1778248801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNOGLSnwE1t6HIl67zIcI4mTCSe3nqPHRh9GxNxgyWw=;
        b=Si14YlYEcT1V3uIaer3RkAlFnrcAL3fDOAaE4pLJ+OQ0YnIMlGfOQcB+n6f9ak+O0h
         KpeVmVAsYAsYVrBnM/nhq6T/UXK/9QX7MoDRHd+MlH4hJPpPp/8cRNG+yFgXgm6L8dMk
         EziPiX3QlKtFJ5cJNPqY9UNmWPQ3n9cB6+PDxSOGiKIG4xmPrmnsqY6qRm+KSPc1nnlz
         te47MRXve2z4T2BqwlfKEr/wgyZkXBg31hNNon6refupWZnArz93x4UEXJMYMpAwEYJG
         pk5R1j8/a+wKbopM6R3iSdUbsXD4EsVw/5gLB96sDzMHgH0wGTfTwh1vlDx2g3KlENCU
         ZWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644001; x=1778248801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNOGLSnwE1t6HIl67zIcI4mTCSe3nqPHRh9GxNxgyWw=;
        b=OYRfivJE/NlaKUIwIE8udWO2o+y5xP4NCIQ1AQJmP4gk7fEqKRrUqKFqV2oBp9xxmw
         N/js4eL+pbh0IQ0gXQBQgth/7O3+U1CGVDdN8hj+1k6ECQvCxr32HjieE3AJ5Uzp2LC8
         eZ8Z7ovcXM9LBBRfx2HDBD53QmdUXtG4Lqc076EOSxQgiLt6SNuZk6cUxl59MD6aCqpf
         XATIUkvOuVH0gJV5X85OwdOx9+eoN16z7glc+7cGaI0nAgfH81digsWWZPuEZy4dZCE2
         LEkThWarAJLqsvICKRKVqjN5t7Q/rskX1Bv0JcQzHf7+R3S/JtwOW/ZZhSdOpYNIk+ln
         6EUA==
X-Forwarded-Encrypted: i=1; AFNElJ90Qic0rB4pnKZHkovM5QjzFZ7/rIlEvUuubkE7AIfQjVTqkMorcilN4uQlI/g+P4yVHAAakV1FTRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAW/naHC20dx/j9cogxsRRMIE2mcfaCUe2utkoowLPjd9ltuJL
	z+fic0tMKPkcvJMaBeQ7XsqMzqdstiGlJdAprEWhPZrMYpVfRHn/WznR
X-Gm-Gg: AeBDiesdmb3Btu8O5scu5nuhUkHNzBdB0NxyW/hA+vmc9oDNYqpPr6d7BTgenpfUlnL
	CYcQLXDKRREvbUnWJD7Ok9ngCD+8jJrgybXb0tB5YknhyWtYDFU6aKsGWVm5K14UNKtY8tFKSt4
	gNP3rQTY90WhLqT8wtSI8zFAyyr7LzAQqxjvlFb8k+d9yQlWBVMyrclaOG+CtMaCh/msZSTERGu
	pL3U+0ODu5tLtVWv/P8afUP/bDFaJmznfofmP7XY/lo4KOs6U09JlMLd15qisd5ETgkOKk7h5se
	OHZkAH1yMA7J00IB/ooKyw7E5SNZ2uzpYetit5VDUvDusy9IEyCmEO9jfXmRf7tdG7pOaYI+bG3
	GxtLfLG9wkqnoJostkHlgqrjAQodvrQCXnELDssNQB0ZR3TEAIKYj2l9aCJXIZx9cyaPZmK8Ndi
	ehsG6e3M+TAUDqnFu98DKTGK8ctHCR6Y4afwhxlnXxPNR/bV18Zl1IHo0BV2sM0GKaSxCGfdkmr
	dIg
X-Received: by 2002:a05:600c:4ed0:b0:48a:54a6:b29f with SMTP id 5b1f17b1804b1-48a84451fc2mr106947765e9.17.1777644000526;
        Fri, 01 May 2026 07:00:00 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b768fdsm4823539f8f.33.2026.05.01.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:59:59 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 0/3] spi: imx: Three fixes for the i.MX SPI driver
Date: Fri,  1 May 2026 13:59:48 +0000
Message-Id: <20260501135951.2416527-1-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series independent fixes found in the i.MX SPI driver.

These are:

1/3 fixes a precedence bug in spi_imx_dma_max_wml_find() that makes
    the watermark-finding logic effectively dead code. The function
    currently always returns wml = 1 because of how the !-operator
    binds to the modulo expression.

2/3 fixes a missing return on the package-1 failure path in
    spi_imx_dma_data_prepare(). The error path frees the
    dma_data array and the package-0 buffers, then falls through
    to "return 0" - the caller proceeds with a freed pointer.

3/3 makes spi_imx_setupxfer() propagate the prepare_transfer()
    return value. Currently a -EINVAL from mx51_ecspi_prepare_transfer
    (e.g. on a word_delay overflow) is silently swallowed and the
    transfer proceeds with a partially-configured controller.

Regards,

John Madieu (3):
  spi: imx: Fix precedence bug in spi_imx_dma_max_wml_find()
  spi: imx: Fix UAF on package-1 prepare failure in
    spi_imx_dma_data_prepare()
  spi: imx: Propagate prepare_transfer() error from spi_imx_setupxfer()

 drivers/spi/spi-imx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.25.1

