Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9573EA955
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552270; cv=none; b=Am3d7+XEFHrufD1ECYVAw2jpiRYRGJH3mPkzzh5x4Fir7mW5OA2lTJydV3++uWQ7xUZeM7xwdU86j/sC4BVHhNcvO9+8VdxEk6nMg32JoLw58Ncil0NFxryNoIcuGxM1V92affRd/yeiTq0uzfuYxB/OTR8mELMuzEspM0DLe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552270; c=relaxed/simple;
	bh=Lsi/A++xhrGF04JgKe8hR94JWb7Yq8PNQFayVgZOH1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqu30JOwjG6pQY3RIQRzSpukvq8fgjN0K+JzTigDlhbC7Izk233RJoLVnbyXPJg/YqR2yNUNh6+ndtqbjBK+QIrjrNCsV0JeGzzXPISIJy6lpLndLDQaKRDodjUI3obDLf0tPKWsw5ZbU8H8iajIVNOPUmpnlvbxiB4XXn9qPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2df982e04c1so24853155ad.2
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552269; x=1792157069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAt8XDz6F5McT3nQ0Byv0pTFouwykBOXxklKXve4ubw=;
        b=eon0P01kXTPqOtWPFMDjUT3NNFuTuDW+EcQsRPQrGWf+n+7m9wBk/P3FO4dVaY+eAw
         j1rw5kwzvDQu2tZhITRjPqgQyS7wmVBy9IILOy4BGdAOkKNIVSht/0KslayE2SIq6Q6S
         s+bCv7o8vla01zIkhBVaLQXO6m0z5i1v8OrkM/zWfaw7SgdMr91NrIc8HqFuMRqU47f9
         /DbJwqhs4WAJJtACPwVbgU2LPRzkE1qUKDtQ/ngPtTM+CCwkYyoblAVHyQ4JBk++ZehT
         s2RkXX7MOQ/xzcI+pZeVmXE+X8g2J0be9Fbv4F3E8T5pf40kDKUg5VkNtG9bRYo+nGbf
         V3lQ==
X-Gm-Message-State: AFq9FYLgJK4aUwMMLGKvUxbQRrikrCyYB4YtOFlggs82qNOshy3nZPL6
	ixV6qLWKrcfSyrkJewC3KWjZ+mWmhyYsWjQu9gfg6wIM35nrcZeKC8r5uU5qcItCQIc=
X-Gm-Gg: AYBFou2h8TgD8+E7ls1W3CAdFk95IbS6Tzp9w25wc0EDc+0mOpv8tnCkr18UhAg9o4J
	k+rQ+vfcZXiiv+HWRGcauLddUsT3ezhRgWvLzBMvN8mM8fflBebgNetzWLm7ytJb1HZeT55He+j
	KOFtY2978TizAT4vvx4GoMwLAt4pUvHlE02CdICwtc3ITWvVQ7Fj8u9aS0oCiC2p7ARU181jJtn
	cKpFsavnWvh1ntxd8GyrFFEFLorV8JoCLBAlH5VOFkHJvntmPSiDHJ63J6T5XGEA71Dlh11kDgj
	mwI99v1Q5BY0WLW3xAlmDSnSqi9pRqAF5JVHMv51fS5UimMidI04sAyzOz9r6oqHQLlRkAj9smo
	8iUd1kd2TYNg/KG4R3+56h2yZqvg+nBGqAMD7W609Y1BkkvMHv0TVzfH3QJ65+f5nq+lC9LSWbq
	4KGAxz1JpAddliVUraF4y2elt6wwESaRf4n4aLhb+c/KH/ij8v8yuCWZo7KIU=
X-Received: by 2002:a17:902:f612:b0:2e2:c191:e388 with SMTP id d9443c01a7336-2e842e01de6mr15465345ad.59.1791552268574;
        Fri, 09 Oct 2026 06:24:28 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e2570sm9327705ad.79.2026.10.09.06.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:24:28 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 0/2] spi: use devm_platform_ioremap_resource() in sh-hspi and jcore
Date: Fri,  9 Oct 2026 18:54:19 +0530
Message-ID: <20261009132421.557758-1-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert these two SPI drivers to the devm_platform_ioremap_resource()
helper to simplify the probe paths.

Aayush Kumar (2):
  spi: sh-hspi: Use devm_platform_ioremap_resource()
  spi: jcore: Use devm_platform_ioremap_resource()

 drivers/spi/spi-jcore.c   | 14 +++-----------
 drivers/spi/spi-sh-hspi.c | 15 +++------------
 2 files changed, 6 insertions(+), 23 deletions(-)

-- 
2.56.0

