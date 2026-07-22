Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BAE3E5A22
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784691677; cv=none; b=Fy516XH5IEciIC1/7WKtLZCs1PNyficxxrUmqqmin8ZV/1t/IormKaAc/V0b8le6oAWDiYD7w/1Mu9P8HKnHS1ULJDCToKr3Xhou4A6cW3ByJte65+DhizGr7RGQulz2AUXnCz0gr9sOWO3fhxGhp97ETbxiQKCa0Pm1cljGsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784691677; c=relaxed/simple;
	bh=omr1+5FGqP/4cAjLJuIvC7am2JBR6QvgB8tGwxi3xIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sF9mmkkGE4zTOxWLN769wqabwEXmErYcQlgdoij2Ko46EhCdgDXF/YLmISZvAWTFHdvVk3GCnthKbAuqB1pHGISiDoCaBgY+WdToRhLGDYjwGlhcPZQhXwso4Ydd+bWlRumgs7302+i7u6bE3zVfpkUecfDPVOiQUSkSLuTMWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAjMGWjo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAjMGWjo"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so110831285ad.1
        for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 20:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784691673; x=1785296473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMsLP/6JMCFywbSNUxwQOz2CeAVV57hRVViNt75YJiE=;
        b=HAjMGWjo1cFnZNC9vmWxdr6dgguJJZcbOmA56CgQHS25PFjXFYuOu2hXFvrqk6igyi
         JVaZ5s1DVoZvJ6pP8e/AI7kAky6nDMk0x8KscIjMsJSHctne0/tMUyBF6p12ynJjzU1Y
         ZNhZgQ8esURuefcLXEUnYkRtWxsQWMsDF9yFdSuE2LljBJInz5rd6+TsxmdaO+EIrshH
         tUeqyrbn70ItGJjpAI+AeJ8zX0E8SDLU0DXo76EdRazJmRPvIrnmkmluuEKVWYF3m1G4
         5hT0OgFSRN3ShETl+iae6t6uk5gj7ljzLmAetlloe/SCVYVB4ELA3G8S7Z4bcPs3+Q8o
         6rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784691673; x=1785296473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMsLP/6JMCFywbSNUxwQOz2CeAVV57hRVViNt75YJiE=;
        b=mPNvpBH3eGaU6c7UucvQObak9hqT9YI+jJ7vxf8gPPMvmY9rzuZmX+cZSubsSaqiNs
         G6qDZkfLX+MZPcnCKVjsabxx0FN8URp2lt8ancKe59NbXJ+/DecckMAaS8XQ7mNcPDg6
         X75KOr5W7+/YbXpVMMQoFYgvEYwahBOhPV9ejg3Jaw53SSn2QwjvuOLqVM2RrtpFie1b
         +tl0/4zAsLegcIT6khNNuKGsgb7+GT9Ap6eQMF9CBbpyPzsD0NL477mVMnNB0HGBWLto
         b6mIG5h93ljM4etjkEw95L0IxzPnMw5uUaH8qM1bMlcZaJS3fokXmxg0iKEvsopYgsXR
         3LRQ==
X-Forwarded-Encrypted: i=1; AHgh+RowzK1r2NitkL3f5QNq0RIB7ifxLBpu0R/jt21KOPzFVWIbbxTY90kA2IpS/CJGpJgM4kMMtnUwW58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVTyXogsdVijp7RAN9cv8HrII+clwZ/hLGwZxR8dL+SRs0T6ga
	Yp/pmBnzMZtQz8ZO2vjWXsBgtiHaKQ7EQKtYWYXNw7Pluq9V3LCLTfs=
X-Gm-Gg: AR+sD118FRvgromXNn/A7YF4LVpbJf3diyagK5gbrshiMUis6SvhgxSGGOf1lrj2lPq
	bhlHuWagFzDfMHxcBsIwffFrivzioJXtCNw+kpbldn4Ay8PXyf/uawT8MEFRDsWHZRF8q6NWJvW
	5XEConKn9qzVhkqFytMWt+fszWgHx7OBP5Mz2Jw1ntWNBbXO/SizHBbMHOIn8e3zUbwNfVs+SYD
	1+ibdBXbq0ufcdV/Vx1VnuSCyACiGtZwxK8InCr7Z6rbQ5DfttSM+41KqsCgPCiyUuTRoPRbCXd
	f2ZxmYbRr0v/m+/53yKcc/8ACRVPLzHtk0SgvBGgVys5up47lpUClts5QGaBvUP+bYC7rlLPz4j
	1eV668Abu5yeYLe6CElwsTr9O2Og3e2qJ9GWO7e4bcZc6EUAsALI8OS9j7FbnPSIBlUUm4/Ipeb
	Cm8dy2X+PGZR0oh39lorrnX+Kgcok=
X-Received: by 2002:a17:903:1247:b0:2ca:de3:15e1 with SMTP id d9443c01a7336-2cf34a0a682mr225407425ad.31.1784691673137;
        Tue, 21 Jul 2026 20:41:13 -0700 (PDT)
Received: from t-rex ([2401:4900:adaa:53ec:4dd9:f3bc:714a:d631])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc193f8sm7523404eec.1.2026.07.21.20.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 20:41:12 -0700 (PDT)
From: kr494167@gmail.com
To: broonie@kernel.org,
	dlan@kernel.org
Cc: elder@riscstar.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	surendra <kr494167@gmail.com>
Subject: [PATCH] spi: spacemit: prepare both DMA descriptors before submitting
Date: Wed, 22 Jul 2026 09:11:03 +0530
Message-ID: <20260722034103.12190-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: surendra <kr494167@gmail.com>

k1_spi_dma_one() currently submits the TX DMA descriptor to the DMA engine
before preparing the RX DMA descriptor. If preparing the RX descriptor
subsequently fails, the function jumps to the fallback error path without
canceling or aborting the already submitted TX DMA descriptor.

Fix this by preparing both the TX and RX descriptors before submitting
either of them to the DMA engine.

Fixes: efcd8b9d1111 ("spi: spacemit: introduce SpacemiT K1 SPI controller driver")
Signed-off-by: surendra <kr494167@gmail.com>
---
 drivers/spi/spi-spacemit-k1.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index 215fe66d27b4..96b41b67fcbf 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -278,25 +278,25 @@ static int k1_spi_dma_one(struct spi_controller *host, struct spi_device *spi,
 			  struct spi_transfer *transfer)
 {
 	struct k1_spi_driver_data *drv_data = spi_controller_get_devdata(host);
-	struct dma_async_tx_descriptor *desc;
+	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 	u32 val;
 
-	/* Prepare the TX descriptor and submit it */
-	desc = k1_spi_dma_prep(drv_data, transfer, true);
-	if (!desc)
+	/* Prepare the TX descriptor */
+	txdesc = k1_spi_dma_prep(drv_data, transfer, true);
+	if (!txdesc)
 		goto fallback;
-	dmaengine_submit(desc);
 
-	/* Prepare the RX descriptor and submit it */
-	desc = k1_spi_dma_prep(drv_data, transfer, false);
-	if (!desc)
+	/* Prepare the RX descriptor */
+	rxdesc = k1_spi_dma_prep(drv_data, transfer, false);
+	if (!rxdesc)
 		goto fallback;
 
 	/* When RX is complete we also know TX has completed */
-	desc->callback = k1_spi_dma_callback;
-	desc->callback_param = drv_data;
+	rxdesc->callback = k1_spi_dma_callback;
+	rxdesc->callback_param = drv_data;
 
-	dmaengine_submit(desc);
+	dmaengine_submit(txdesc);
+	dmaengine_submit(rxdesc);
 
 	val = readl(drv_data->base + SSP_TOP_CTRL);
 	val |= TOP_TRAIL;		/* Trailing bytes handled by DMA */
-- 
2.55.0

