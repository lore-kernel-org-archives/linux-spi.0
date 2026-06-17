Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2273A5E7E;
	Wed, 17 Jun 2026 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688253; cv=none; b=oa5BwNmevsnRorGRCt7q7BeTnHKBmCCqRxd07n0RhT9L99ONMbkTNacx7cQovyoZvPxZfXbI10KXZh2zFkMIN/0etlRljnCayR9bslXaoFQ74OlM5kK3o1xK5rC0BaEguIvPHGXyBTtvor11j2A6d5jGr61cS0CCOorUvWN4YvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688253; c=relaxed/simple;
	bh=pJG4VEBaAFZFItD63ALFLBYRv/YpfATrtNc/60IRy5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jKUKkg7RAPd6DiJr5zJW3SSv/gOPuf3dxLrQqFU7oVG4KfOiYll2Y35yIFgLvVAOUcXpdUv+bCLAHZDP/ANIj5SIzxVTXvQSjfBrU0M6HkJXnH3T7sYTQ7m/2gkb77kTwXot5e5I5fR0uwRwk5NpzbWMUcMdHMqEb/AgNzk3FeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0VK/F+S; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0VK/F+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781688250; x=1813224250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pJG4VEBaAFZFItD63ALFLBYRv/YpfATrtNc/60IRy5k=;
  b=V0VK/F+SmzVX4Ys3D7axYPld5Mc03D3WAYEUJ8mmZMQ78EmWtuKEN/D7
   xUn/7bP8eHZmsgk9ess5uQWG4XGo41YMgLdT6vB75XxWIaF+XRodu3a/A
   InFljcZTVnJOYFHysOka5FfgDKe/0IUr+Es0fbeOYZOaoWfoegfQ8+yvF
   K8mMEETySjfBgc4LZlIy7vSvcxlyObyE/LT6o6ElTFE+mhhkgtrjzHm1o
   J8UnrP8Hh69mnPBf87tTCIKyb98n60X+c8p2dYWy70pejI09feUM8XLom
   aO0DwXlobbrmKiKsQSWoyjnQzfybWr8DYDWoF/qFHHZ1HtpTGx2xJ/d5x
   w==;
X-CSE-ConnectionGUID: 2PN7HwibQB2QyTTBZENIiQ==
X-CSE-MsgGUID: Eaa1yJLIQd2VMad6M0amtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93141267"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93141267"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 02:24:09 -0700
X-CSE-ConnectionGUID: szj0vVYgR2aoBmOUQY44QQ==
X-CSE-MsgGUID: SpM5cTX8SiaoF0CnncONEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252971729"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 17 Jun 2026 02:24:07 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id C651395; Wed, 17 Jun 2026 11:24:06 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: acpi: Free resource list at appropriate time
Date: Wed, 17 Jun 2026 11:24:06 +0200
Message-ID: <20260617092406.2649384-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do unneeded "double free" (emptying an empty list) in one case.

This is not a critical issue at all, the fix just makes code robust
against any possible future changes in the flow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 76e3563c523f..8b1ad1efddb2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2975,12 +2975,12 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
 				     acpi_spi_add_resource, &lookup);
-	acpi_dev_free_resource_list(&resource_list);
-
 	if (ret < 0)
 		/* Found SPI in _CRS but it points to another controller */
 		return ERR_PTR(ret);
 
+	acpi_dev_free_resource_list(&resource_list);
+
 	if (!lookup.max_speed_hz &&
 	    ACPI_SUCCESS(acpi_get_parent(adev->handle, &parent_handle)) &&
 	    device_match_acpi_handle(lookup.ctlr->dev.parent, parent_handle)) {
-- 
2.50.1

