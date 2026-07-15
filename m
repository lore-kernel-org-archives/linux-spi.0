Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89141373BEC
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154266; cv=none; b=YpAlBKATfEI9WtJKX2qWorR9kHDu4m6iCbo5FPtrrnsKBbnLtCGYJRk7rOI0HIIKiwoONer+12djDmqWhMmMNdEzJzgOaGVUHvfnH4V/gr8xTfzuZt7rHHiN5pmZV2LSCwIDAZLU7ZloLnH5NnnL8UQ5LxiHFSZ+R01wW7oxlfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154266; c=relaxed/simple;
	bh=d+ktqVndZJhCJrT8O2h4M5jsdq4wiPW+WKcCbzjTV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcQ/dTxA98vBkfA8HFHATYRtkFqQakXqcmyTu8VhSVyQC2fszRFLA1cpv0m+W73edLIN5FMaXNJvsr2z6JVvdmFsZLZ5PmVPIRpvvqluj2NuWZFtTwTbVzAaQ4n7N2+P6OZ+H7C9zrl2Ge+l/XZpIsdqXDJVZ7Tgoz5hqCkYvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0Wc1nws; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0Wc1nws"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so5235027f8f.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154263; x=1784759063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WEq6Gzmt1f2hEZj2wO18jW2AXF+11Es6P4mjwJfz0Q=;
        b=o0Wc1nwsyCrvK2SlkyiiD2Kzdg0ZHfdeFVVn6Sjwr5mcMxh2/wjrn/GLYcpU5qvt86
         GbepI8Dm1KMelKdQ8RQRE/FZJ9VM8xTgIFuf549AyDjSI9nvaVbwAuTVRUuUn0MZtpMK
         elZo2He8ex0QKDqxaDyPMWgF8bjhIzTSWspwofDMw1GGLOEpGlHUx4jBLB58UX6oN3LT
         RZakbWtXwGl4QhzBpJbKaavbNAt3xY0HA8k7pNu90VFDVNIWrPMeD16Scw9Bhawiiqvi
         pERr4AHkigkD3aO2VEcX6H1dJtEEimkkTu9v1ho2qu1B282pxrLO1hVlb2zdz+FyqgBY
         FdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154263; x=1784759063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+WEq6Gzmt1f2hEZj2wO18jW2AXF+11Es6P4mjwJfz0Q=;
        b=VEHZdO8V4js2n7M8aGjAZyXOL9+AlAblyNcS3yg/z/MpZSv6W5kkBJCtnlEV1RfMLD
         BTJG7/jbr4GrY5gXgHA6wVv7EH/YV6xzKeVJJN7ofyVvnhSAfVr+dNtv07fzeum3ye1k
         RprtY4VE6dGrWmCsfcuR2Xsz7ceroARnC53C+8bvi1hThGOqKUtbiGA9BO6qltDScirJ
         ns5q4BVkpGEEdoAGVNS2XEsosAijXSpLRHxxHKZyed1r+gdOJ386SMlMHKblC2air2R+
         YfsAW4Dyn4jmnJbTuL5zEQ8AZFzG2QoaH6p3FiBU5X3nFSoOS3HC1mEbwqVq9j2Z/VaT
         dxqg==
X-Forwarded-Encrypted: i=1; AHgh+RqBYBwPHsPs9zvkGc6rCGN5WyLZQJghKH5rROit32CHUgHqkwCWzTLDP5qPHDyRfxsdLu1YDm+hCgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbW+HLQCXXZnjCYD9C4yXZIpB7vwKysEmDyP91qFfh0sNL0ID
	sqdPEyPlk+LWvJMmfNKRsWXueyFUdHNoodrdKxu1LNiL6yoF9SeodIsJ
X-Gm-Gg: AfdE7cnNUTTKQQ3/UwgkdITb1Qboca23FxSsNzfeXsmcBbedn8H/i7+Ps4VJXahsWxA
	fZcx5LMvGwUaWXzL/iunfBDMsfGNvf7CH3N8cZChAGFWgvsDOozkw1b/O/sa6WRkmBCW1ZEyBus
	LQ3iI/9PaIvJ68LUJwFxVk/uogAOPgm/rImS4x9OBdGQOxbeAbQQx1B2gtq2qUEi0+JLoVZuu2b
	gDJDpVrFPzT8skC5R2vC0bDMTx2csYM+fQDq3uM2wXumsPxFdhTwHStD9eaHncPrJWO0B/v00Ay
	zBZSBWflPtB/9o0aqvkoPgl7nmsgb0cItLH37cLbu3+5vx1HH6kqoZJOmUDCPp41ZDEq9cMAIMp
	aYIAjjtIscLXvLJf2DXrLd7wMjzZcz07OT7hnLSewNUNQNdDYHVoZSB+h0opgliW8IoM2uT+2Zv
	LNfYEDtRWTqHn7GZRJehfWyYBVkPVQjVKx/NkPBD4pp1tUwfQlAPUhnpqJTODVfyNMODnQ1598L
	kpy0QONX77+dwYu2irr0DSLs7U=
X-Received: by 2002:a05:6000:1acb:b0:47f:4893:d17f with SMTP id ffacd0b85a97d-47f4fcd5c16mr5321708f8f.22.1784154262632;
        Wed, 15 Jul 2026 15:24:22 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:22 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
Date: Wed, 15 Jul 2026 23:24:11 +0100
Message-ID: <20260715222417.2997712-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add XSPI_CDD1BUF0 to the xSPI regmap volatile register table.

XSPI_CDD1BUF0 is a data buffer register used during manual transfers and,
like XSPI_CDD0BUF0, its contents are transient and should not be cached
by regmap. Mark it as volatile so reads always access the hardware
register.

Fixes: 687cac9559d8 ("memory: renesas-rpc-if: Add RZ/G3E xSPI support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 3755956ae906..104c28532c20 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -34,6 +34,7 @@ static const struct regmap_access_table rpcif_volatile_table = {
 
 static const struct regmap_range xspi_volatile_ranges[] = {
 	regmap_reg_range(XSPI_CDD0BUF0, XSPI_CDD0BUF0),
+	regmap_reg_range(XSPI_CDD1BUF0, XSPI_CDD1BUF0),
 };
 
 static const struct regmap_access_table xspi_volatile_table = {
-- 
2.54.0

