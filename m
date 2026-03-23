Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49D3947A6;
	Mon, 23 Mar 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274704; cv=none; b=hgPxCacOYYx0+FYeNdWqgs9mqqt9hkg5lwQMuGgcsxkwtzIbDdwkr6cu/BgqDCQkzKKSw73REZkRZWh99TM6zJFCq1eFUgy9OUS37eF0QCJgV/QnHI5MDeosGyarjx7VNRqmTR+SdCwGn2zkVXYI9IqmeFzZu+kHqGWs7o0KjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274704; c=relaxed/simple;
	bh=+6JAnqgvLbCSLMxeRMOC3mfdsHu0U8+mHf/+OubjbUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iP0ExpMJz1tb4YuNi60/p6khVH3DrLJrLf5HnLGYQe925Zoo7EHrZsP+BbnALbqJ9k+mxn2T37ACuJxDfrBpYD2+PTdM2lbW5KrfZobpgXoLlXyeDmWxZIES/AQouTXixN7GZZN1j9d97FahpMdTD3qaeYHjXaQwmCQHj7IXnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIjFrYiy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIjFrYiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774274703; x=1805810703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+6JAnqgvLbCSLMxeRMOC3mfdsHu0U8+mHf/+OubjbUo=;
  b=WIjFrYiyw2FGf0Wiw1GHLBP2Vhkxmd3LR45c5yemfmsbtQ1GH4g8RYln
   iWu+IZLMGDLhhBfC6zaiJd2cCf/SQ3WQGUnB6iHOVJoP5pAIeSKrlw7KE
   nv++aFpC/Lg8yXkIh0Bu+8isp9MQGL539qSGC6dC6jN8hy6uWEjjaG2x0
   /lqro3ooSF+LSSNRu8Ydy4PZT6pgvt96dw5kgx4D15RnAnTdz8x41KvAJ
   jtkwuvium9nxJJ/pxdZiVNEp0askn8uyZ6EQK3eFkHV8KAxhu/jPBBe26
   B900NjLvdWr0O+rRYY+EVUWLZTIvSffyj+xh4TI8ZENDav9rVHJo7voTf
   Q==;
X-CSE-ConnectionGUID: ckb7GsxzSm2lUjXxny0F+g==
X-CSE-MsgGUID: pyB19DCqRhKQ1kUtpHmzgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75337558"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75337558"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 07:04:57 -0700
X-CSE-ConnectionGUID: JQmpqqk7Q6WjoweX5NapEA==
X-CSE-MsgGUID: 9NqlkHQDQZeIOzJ4fmLfkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223107048"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 07:04:55 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6CB4D98; Mon, 23 Mar 2026 15:04:49 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Replace open coded variant of spi_bpw_to_bytes()
Date: Mon, 23 Mar 2026 15:04:45 +0100
Message-ID: <20260323140445.3496736-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__spi_validate() open codes the functionality of spi_bpw_to_bytes().
Replace the custom piece by the call to the mentioned function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 200d942c85bb..cd1561d84e73 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4222,12 +4222,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		 * SPI transfer length should be multiple of SPI word size
 		 * where SPI word size should be power-of-two multiple.
 		 */
-		if (xfer->bits_per_word <= 8)
-			w_size = 1;
-		else if (xfer->bits_per_word <= 16)
-			w_size = 2;
-		else
-			w_size = 4;
+		w_size = spi_bpw_to_bytes(xfer->bits_per_word);
 
 		/* No partial transfers accepted */
 		if (xfer->len % w_size)
-- 
2.50.1

