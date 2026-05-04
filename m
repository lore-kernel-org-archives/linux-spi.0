Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE13DE458
	for <linux-spi@vger.kernel.org>; Mon,  4 May 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904488; cv=none; b=CtNcV7TPTbsSRwLROXc06dZhzhzMce8PFfoSCt9XPvFNoh8zQMfyqCEvBmaVqblU21uDeTS/cDQMsD+eSFxtdKetxCNXFhUrtiSUDqJb3C3kgcO/XA9MVHnQe7jRMN9W/MPYhzBIuFaSLWJQrDaRJonDsI9LjaXDlU72478aJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904488; c=relaxed/simple;
	bh=5wOwuVvefdU5ZTRUm0XTEf89qcddrLF3nFm7eExiqLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XYPEk7J50z+26Hw5i+StwiUIZgqt/d9UB10lbnJNnylcdPCUVPoy13ypC1KmwTmoyR+hOtyAaeFwEww1/k82Peo8LiBSYe3iN10OwD0DZWeW3WPh+ODT/4QqtakgDGnrZ+Y8onn843Yol2ZswHyHvnRP4+RdgZDIv5C1pLJCxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Kyhunzos; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Kyhunzos"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so25664995e9.3
        for <linux-spi@vger.kernel.org>; Mon, 04 May 2026 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777904484; x=1778509284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6YVwSs5jEunYIFmliOy6CPtzbx28+OMoZtmtntomi0=;
        b=Kyhunzosl9YvBtAbqtPkBv01KJp0U+egsfqMsgtqFTnJE9tdrO6lAzqmhmHo7tmLoe
         WU68bbSx3a8TIxnQZJLci0kaRAET7UpICCOmg1z3ZMHM/yc2GNZ+0NnbpXlYCLC0l59o
         wiCrGMb+1GVMK3HdPEQB3FEifd2hZ4pilM/cysmA4US7cx9kWk/VN5ZlysjGxUJoRFZl
         XR2N4sl3s+YHLFl5yWtggxbDoy5QOQbtd8/ZhYg7B3rFvSXY/lnN34QOvztcjSXf/zCx
         bSBJJ9C1hwW77E8aLNWES4Ww4GCE1QNrmLbGeHrp21t4qofbgLkZL65ecEgq5pg5Cb+o
         /2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904484; x=1778509284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6YVwSs5jEunYIFmliOy6CPtzbx28+OMoZtmtntomi0=;
        b=V8BPvdCS+ZHGGKIaCpbVnQ2Lsa+whRDLn5af4FGdUa97nco45wTQl6aveCedL6Tz1W
         qVOtH4f2EdML61niIIU8ODNzPUECPqAiW3apLqiLAXgkw/VV3QLbhynQiOdNt1XYOomg
         r3BKMOAH2sS0w3v4ekQQOAkIdMrlpDTCkZRkSHS9PLwjpKBxkKEnfjvYm9VEXyqNgZXB
         G87az26Cdma0+CMrgW9nDEHJxPngpXgQx3ue1n0ss0wV1kpkGSamZ0zGYurnoq5uFJZD
         xII8RVVzz4OXGvI8S7g4aIjjqTow1XZckRVfuHEJawRVlkfQJ3Z5+dyp+ctKfGLdEHJk
         07mQ==
X-Forwarded-Encrypted: i=1; AFNElJ+w0xtYpXVT71coiBT7wGFfKW70CAfS+Arr4XFsxJ4ulAh2G+jZcokUAQ6aThPZFY8rZUKhH+As9So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bJlroKS9BHZCXgRWCxcW4B77FfNrQvBz6zX/wemZc7dpKOuD
	r7QtvqXpXdhnWC9UIS6qnswAfUiY8pP2bvbhSPe178+nw1ceYZQp53HPgy1ESP0wDHM=
X-Gm-Gg: AeBDietRCHwTrWfFXjP7B7oWpCBvr/COBMTuNBbcSHVgXF08WkvmGiziStPcIBKUOKZ
	vjcldB+QLh2OtMD+PhZGL9poG3mHsRVLYVIzwiXaSqOU4bPHO+YRK0EAZjlaxbRVoF5u8JBR/U0
	cMZHCdvHLNLVsytFOgZ02mBzmYWlWSIkBZxZxJPK+l4f+Iw2eNpfe3VHnXlsW48WzX47yjepq8u
	A4GocYznWkTZ/MvtpSv6n4nbpnPLUi605ah686iYoxg9uCqGjIR2L0Zf7iiRHtrPc+kiqTg5nYm
	pDh3pgOjENMbHMD11vVvyIe68iv7XgAL6kwgWPE9uvIiNMT+xo88tIM2qJrQQliZpkByFkOcT1G
	Yyau8fF/1x6aDc2u7xliWvoM0/rekrxaHvbWdyxtuIEkwa2kxD5odEwUjBf8tWd/+/FaSF8TX/P
	EFVNK3/r3p3xf/2XXlRzulXyEHkgg7ZmHwaPDliW6LebKeMtYuZUoAtKZa7Y6zGnimg9B3Yf6in
	GfdWkoQHn3hLhZX5VbD/+/+Sg==
X-Received: by 2002:a05:600c:c170:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48a9852e515mr156429485e9.3.1777904484336;
        Mon, 04 May 2026 07:21:24 -0700 (PDT)
Received: from localhost (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a8fe94be1sm102456925e9.1.2026.05.04.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:21:23 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: Consistently define pci_device_ids using named initializers
Date: Mon,  4 May 2026 16:21:17 +0200
Message-ID: <20260504142117.2116978-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12488; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=5wOwuVvefdU5ZTRUm0XTEf89qcddrLF3nFm7eExiqLo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+KtdGgGNLmB00W/cEQb1+hTNgxLK6SEACtxjy 0fnD7B93eGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafirXQAKCRCPgPtYfRL+ Tjh3B/9qS0LYm/MOnw9wq9fNga6vjjEVRxfF5YmONbruT5wsOvWGALwdTtk7WcpJT0QWh8IHNdw CmK0IzIho9lTFhW4OA1DyI4yGkcNqyCq16JWWmGZD1D+4KLtuCyA9DaSIpKd/btI4WruMESfgz9 tAsCwUb+WBdETQTX40qUNLyyV36waPoZCLtMmMpCBXLGZFicp25Cj+t5/EHMMewz1MX2a9lFHft ZAxPSg5z2i8tPjAXXcL2SsPJZzD+HqjmP6Thjv1AJ83QNMiWF+J4snXxbMVy5fb+XgB6V8Aj+6C NL2h9QGGM70mink/0qMCfsfyI7KF/GI0c/f+GCSn7FA9Y2zf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the various struct pci_device_id arrays were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using named initializers is more explicit and thus easier
to parse. Also skip explicit assignments of 0 (which the compiler then
takes care of).

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But IMHO it's also a nice cleanup
on its own.

The anonymous union will allow changes like the following:

-	{ PCI_VDEVICE(INTEL, 0x4b84), .driver_data = (kernel_ulong_t)&dw_spi_pci_ehl_desc },
+	{ PCI_VDEVICE(INTEL, 0x4b84), .driver_data_ptr = &dw_spi_pci_ehl_desc },

(together with the respective change in the code when the value is
used).  This gets rid of a bunch of casts and thus slightly improving
type safety.

Best regards
Uwe

 drivers/spi/spi-dw-pci.c       | 14 ++++----
 drivers/spi/spi-intel-pci.c    | 66 +++++++++++++++++-----------------
 drivers/spi/spi-pci1xxxx.c     | 42 +++++++++++-----------
 drivers/spi/spi-topcliff-pch.c |  8 ++---
 4 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 72d9f5bc87f7..7f002d5e5b88 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -185,15 +185,15 @@ static const struct pci_device_id dw_spi_pci_ids[] = {
 	 * exclusively used by SCU to communicate with MSIC.
 	 */
 	/* Intel MID platform SPI controller 1 */
-	{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&dw_spi_pci_mid_desc_1},
+	{ PCI_VDEVICE(INTEL, 0x0800), .driver_data = (kernel_ulong_t)&dw_spi_pci_mid_desc_1 },
 	/* Intel MID platform SPI controller 2 */
-	{ PCI_VDEVICE(INTEL, 0x0812), (kernel_ulong_t)&dw_spi_pci_mid_desc_2},
+	{ PCI_VDEVICE(INTEL, 0x0812), .driver_data = (kernel_ulong_t)&dw_spi_pci_mid_desc_2 },
 	/* Intel Elkhart Lake PSE SPI controllers */
-	{ PCI_VDEVICE(INTEL, 0x4b84), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
-	{ PCI_VDEVICE(INTEL, 0x4b85), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
-	{ PCI_VDEVICE(INTEL, 0x4b86), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
-	{ PCI_VDEVICE(INTEL, 0x4b87), (kernel_ulong_t)&dw_spi_pci_ehl_desc},
-	{},
+	{ PCI_VDEVICE(INTEL, 0x4b84), .driver_data = (kernel_ulong_t)&dw_spi_pci_ehl_desc },
+	{ PCI_VDEVICE(INTEL, 0x4b85), .driver_data = (kernel_ulong_t)&dw_spi_pci_ehl_desc },
+	{ PCI_VDEVICE(INTEL, 0x4b86), .driver_data = (kernel_ulong_t)&dw_spi_pci_ehl_desc },
+	{ PCI_VDEVICE(INTEL, 0x4b87), .driver_data = (kernel_ulong_t)&dw_spi_pci_ehl_desc },
+	{ },
 };
 MODULE_DEVICE_TABLE(pci, dw_spi_pci_ids);
 
diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index d8ef8f89330a..8c429c832ddd 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -66,39 +66,39 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 }
 
 static const struct pci_device_id intel_spi_pci_ids[] = {
-	{ PCI_VDEVICE(INTEL, 0x02a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x06a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x18e0), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x19e0), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x1bca), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x34a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x38a4), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x43a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x4b24), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x4d23), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x4da4), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0x51a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x54a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x5794), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x5825), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x6e24), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x7723), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x7f24), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
-	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xd323), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xe323), (unsigned long)&cnl_info },
-	{ PCI_VDEVICE(INTEL, 0xe423), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x02a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x06a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x18e0), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x19e0), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x1bca), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x34a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x38a4), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x43a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x4b24), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x4d23), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x4da4), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x51a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x54a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x5794), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x5825), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x6e24), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7723), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7a24), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7aa4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7e23), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x7f24), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9d24), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9da4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa0a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa1a4), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0xa224), .driver_data = (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0xa2a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa324), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa3a4), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xa823), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xd323), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xe323), .driver_data = (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xe423), .driver_data = (unsigned long)&cnl_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, intel_spi_pci_ids);
diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 8577a19705de..af6ed78493e3 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -173,27 +173,27 @@ struct pci1xxxx_spi {
 };
 
 static const struct pci_device_id pci1xxxx_spi_pci_id_table[] = {
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0001), 0, 0, 0x02},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0002), 0, 0, 0x01},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0003), 0, 0, 0x11},
-	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, PCI_ANY_ID), 0, 0, 0x01},
-	{ 0, }
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0001), .driver_data = 0x02 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0002), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, 0x0003), .driver_data = 0x11 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa004, PCI_ANY_ID, PCI_ANY_ID), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0001), .driver_data = 0x02 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0002), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, 0x0003), .driver_data = 0x11 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa014, PCI_ANY_ID, PCI_ANY_ID), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0001), .driver_data = 0x02 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0002), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, 0x0003), .driver_data = 0x11 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa024, PCI_ANY_ID, PCI_ANY_ID), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0001), .driver_data = 0x02 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0002), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, 0x0003), .driver_data = 0x11 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa034, PCI_ANY_ID, PCI_ANY_ID), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0001), .driver_data = 0x02 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0002), .driver_data = 0x01 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, 0x0003), .driver_data = 0x11 },
+	{ PCI_DEVICE_SUB(VENDOR_ID_MCHP, 0xa044, PCI_ANY_ID, PCI_ANY_ID), .driver_data = 0x01 },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, pci1xxxx_spi_pci_id_table);
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 14d11450e86d..02ced638d8b4 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -207,10 +207,10 @@ struct pch_pd_dev_save {
 };
 
 static const struct pci_device_id pch_spi_pcidev_id[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_GE_SPI),    1, },
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_SPI), 2, },
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_SPI), 1, },
-	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_SPI), 1, },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_GE_SPI),    .driver_data = 1 },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_SPI), .driver_data = 2 },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_SPI), .driver_data = 1 },
+	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_SPI), .driver_data = 1 },
 	{ }
 };
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

