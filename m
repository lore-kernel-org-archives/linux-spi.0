Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE3426D36;
	Tue, 20 Jan 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912209; cv=none; b=DOX05sj8nE6Sm+TCZ9GbFiTUUKtlYNBiUNOJjuxiq/jJSDPSPz5tYu7pKkAULiML5RZEry/o0jg/MBVl/lIG1r8WF5Lh1vReock+jzaYfpnqoIUcjoNgYoO1Dq+GTHO1oA2kyqa+efDIB+3kuwCxq48Iqd07kTNMb8WWKj5Wyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912209; c=relaxed/simple;
	bh=zHXV6WREr1IPllh3rFRziDp3X5GJ6iJE4Dxm4IBYZa8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLA01CeAA0PPZzH506o7erONNDGiBA04qd5fiH7G0D/evxShsVmTJD5NZqWOx52upXMpVt5nF1HgN4HzOxXmlTdvMaq92DlX+syGvjcLmL5Gn2Uo3Fi3RtIAz4uuEB5rZMbYZT8nJdqtnt1isHC+pcbSxEFS3G/MSpOZaHQmNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 20:30:05 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 20:30:05 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <boris.brezillon@bootlin.com>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>,
	<pmenzel@molgen.mpg.de>
Subject: [PATCH v3 0/2] spi: aspeed: Improve handling of shared SPI controllers
Date: Tue, 20 Jan 2026 20:30:03 +0800
Message-ID: <20260120123005.1392071-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series improves handling of SPI controllers that are
shared by spi-mem devices and other SPI peripherals.

The primary goal of this series is to support non-spi-mem devices in
the ASPEED FMC/SPI controller driver. It also addresses an issue in
the spi-mem framework observed when different types of SPI devices
operate concurrently on the same controller, ensuring that spi-mem
operations are properly serialized.

Changes in v2:
  - Separate transfer_one_message() function implementation into
    transfer_one() and prepare_message() in controller driver.

Changes in v3:
  - Add testing information for both patches.
  - Expand commit message descriptions for the non-spi-mem device
    support changes.

Chin-Ting Kuo (2):
  spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
  spi: aspeed: Add support for non-spi-mem devices

 drivers/spi/spi-aspeed-smc.c | 134 +++++++++++++++++++++++++++++++++--
 drivers/spi/spi-mem.c        |  11 ++-
 2 files changed, 138 insertions(+), 7 deletions(-)

-- 
2.34.1

