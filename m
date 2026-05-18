Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79D32470E;
	Mon, 18 May 2026 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098237; cv=none; b=YOR0XWp17H2ThR/Ay2W1Cj/Eu5rrTGCqVK1Nhetr/a+f/w60PvW9qO4xFzRXo5rUgH+tYQcn00WEzKyrjMbU3aDAflffWaN55ZyHxhXtmIo5Fawz4IbaUklwqP76yvYcTwuHv8Bs2u9m2Sq9oAJyXiR7SsxhAmmY+3U7CDrcfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098237; c=relaxed/simple;
	bh=VR3HjHZKlgk4KvP/74BWjWHauAGczhypFDRSgEoqDhQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mM7Lk9LAZ7jTArV7oOuHYliRhBNNymfcqaBWobeCPiCW87V0YBWMqC7X1UG/NJl8leRXxOfFPKS4pGfbvTaWKkzcG9Y6+AmkNJD6qMDIXWsxKv0/tLi408rt5HiPsqsBAPX0QIk8F6MUa5GnAx1DjypRmuV7V+6tK79BwfUmhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 May
 2026 17:57:08 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 May 2026 17:57:08 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
Subject: [PATCH 0/2] spi: aspeed: Fix __iomem annotation and VLA parameter
Date: Mon, 18 May 2026 17:57:06 +0800
Message-ID: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series fixes two sparse warnings reported by the kernel test robot.
The first patch fixes missing __iomem annotation on an MMIO pointer
parameter, which also caused a redundant cast at the call site.
A VLA function parameter warning is also fixed in this patch series.

Chin-Ting Kuo (2):
  spi: aspeed: Fix missing __iomem annotation in output transfer path
  spi: aspeed: Fix sparse warnings for VLA parameter in calibration
    helper

 drivers/spi/spi-aspeed-smc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.34.1

