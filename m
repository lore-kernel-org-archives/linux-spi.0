Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211F3D9043
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070642; cv=none; b=YFA1dbAs4oGhdXJBlrNLz3/bGYK3/jTi4tdeHsbxND/KKkiQZW/y9mXojxIsdmvPaj7qL6FSgCBRGjfqnaDARvHZAWIceIq3zkXzefXlZZ2p9qER30oTiR5c+pJaMGcWNAH81PC86lQzVloJJXMyKWtV+RSg42Gb9PgEZGH6Zlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070642; c=relaxed/simple;
	bh=M5htvAmViX957xHCSAK2GcmrBWh1p/ZHsnU4sNBD3N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYRS2KuxoHu+E//uRYxGaFzZ3IOOWNGj5ys/8H8cGgMguud1dwM5SelUX7vjpy1W5Jz8g2H8CKqyeNU5OyGyoYwOunLEKpx+dSmBunluq9MjXvq6V8RF7fCdxUlX2s7cu2LdwWbChNeGsMZ7GoUiLzOqQEjYU6yI53yP1gJvM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fyhsg0n8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fyhsg0n8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773070641; x=1804606641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M5htvAmViX957xHCSAK2GcmrBWh1p/ZHsnU4sNBD3N4=;
  b=Fyhsg0n8zeH6EU3YN4rqRCEJU6huMq8/5yiPz193KkIrH5L6e2T5hC/B
   YHmlSYmV7YN+QHA68vTPNJEbmJ4x5djqJtzpYDkq0dGvkCMFCwLO03nGw
   W0i4h0fYa5ljGLp6vysiu4z0asZpvQf+IFCChmMOF0fNUVdd3JttJRk/l
   Ns1VrD5G7SiP4SjesRNXbA6g0Pb7mFPNvtLw1Eu5lWkFhebkn/+vboBnD
   bc/v3Txq9t3ZAeotUBnt/3VpOWXUb1PBPIQ0Tu0QiifYhTekLjQqsi4C1
   CaPD2z5G5HW7s4Hzdr/6TXGH12K5aimepIN/1ndANHdi7m+1yCGk5UfVE
   w==;
X-CSE-ConnectionGUID: bTdRfAlcR92F3pb8IIfE1A==
X-CSE-MsgGUID: u/8QHiUuTy6MCklITfRfig==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73119842"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73119842"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:37:20 -0700
X-CSE-ConnectionGUID: KMFX8YFsQEqbysauk9zDuQ==
X-CSE-MsgGUID: 7taZ6GSqTKKBdh8b2bu7zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="257715545"
Received: from aborzesz-mobl2.igk.intel.com ([10.237.140.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 08:37:11 -0700
From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	mika.westerberg@linux.intel.com,
	alan.borzeszkowski@linux.intel.com
Subject: [PATCH] spi: intel-pci: Add support for Nova Lake mobile SPI flash
Date: Mon,  9 Mar 2026 16:37:03 +0100
Message-ID: <20260309153703.74282-1-alan.borzeszkowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Intel Nova Lake PCD-H SPI serial flash PCI ID to the list of
supported devices.

Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 65378bae5589..31f1fdbd4666 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -101,6 +101,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xd323), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xe323), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xe423), (unsigned long)&cnl_info },
 	{ },
-- 
2.43.0

