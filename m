Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A137F73A
	for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2026 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187959; cv=none; b=mLpOfIVq/xIf2pPdTCD5McQuq0qRadS6qis1KK6GRExPCuWS1bIyEsrtlVEOzeKgVmHHbRPFywBHyWi+nNzyX4wSyUZlx5zNJnfAYLiCKFiioUrVzvQ8N2YVKJ7Iw7PadSkdJWuL29/4yS8pxpzQkvf/4wghpXHNmQNv/Sf05Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187959; c=relaxed/simple;
	bh=COLgNh6cBKr6HvVwJ8vottdhmUCts7vhGhFXHgm0VdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnOg8XHZjxt1OeqgDuAGjogr3A3MhlBAb3yIYe3214Knpa916vy/8awDuAan6XniMtJkfWWaXGyXGW9hQhbwR+KHKCcQuTdnh3Uxr5r5JrJtKrcXx+aQbs0X8jxsvczbKLxAapdUUe4LCR7qTeLzF1VfV63R1nlhMLWtC4cP3SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1ue8Dun9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1ue8Dun9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B4AF71A114E;
	Mon,  5 Oct 2026 08:12:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89156604FE;
	Mon,  5 Oct 2026 08:12:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE261103306FB;
	Mon,  5 Oct 2026 10:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791187951; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DxrPLHNuoTp6uL4jQVhRWLuES52892SNnqiNXDDDmIc=;
	b=1ue8Dun9YsnOwbjZTQ5DBjmyAyX5Abujbyi9oUPK+hE9k7kg0keiPq45MKLt3DLeYvKXmw
	zIk/ZKg/yunfh0wPpCzyhTPPCkavmmA0gcnnJpk49s4uYSBznRLu8IgH+dAhSboTwvdyy+
	FlHv3UBDeXrxtv8iT2p82nfCdJhapS7CU/P/894ebnxJiJd+ZdBBwfJaqO2tfrTToNBrEd
	ll3aQxq0hcQWVFQxA1QkPdjtlwdXB1oc0raSafkC71JQnEFZF0xWwMzpQpSDykz8wzt3vh
	YuV6glIpvfSFnJXyB65ZTiYGSCu5Wcpvc71a09GprLL09xTiYO7E5swyT3qfpQ==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 4/5] spi: cadence-xspi: Don't use infinite timeout in register poll
Date: Mon,  5 Oct 2026 10:11:39 +0200
Message-ID: <20261005081141.33688-5-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005081141.33688-1-paul.cercueil@bootlin.com>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The functions cdns_xspi_is_{sdma,stig}_ready() take a 'sleep' argument
which, if false, would result in the polling being a busy-wait.

But it would also switch to infinite timeouts, which we don't want.

Note that this code is dead right now ('sleep' is always true) but this
will change when panic write handling is implemented.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/spi/spi-cadence-xspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 7cf52bcb05df..09ed2afbd4af 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -374,7 +374,7 @@ static bool cdns_xspi_is_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
 		ctrl_stat,
 		((ctrl_stat & BIT(3)) == 0),
 		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
-		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+		MRVL_XSPI_POLL_TIMEOUT_US);
 }
 
 static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
@@ -386,7 +386,7 @@ static bool cdns_xspi_is_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
 		ctrl_stat,
 		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
 		sleep ? MRVL_XSPI_POLL_DELAY_US : 0,
-		sleep ? MRVL_XSPI_POLL_TIMEOUT_US : 0);
+		MRVL_XSPI_POLL_TIMEOUT_US);
 }
 
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
-- 
2.47.3

