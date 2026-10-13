Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058038642C;
	Tue, 13 Oct 2026 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870228; cv=none; b=VrzMfgQpzqqUAxIs9R7uHxDFfcD5E64/wdFQU/b/qEluDT1EZW1KjXmucTp8tJnsstH4xrFaCrOS9fyl9edWNbYac54hdrD8hB5jR6eMRpyPsZx14GyM7zB3MrZuR+VWP6bF7Xm28T2oVxFSf3Bk4QstOmnpnBbh/1kZb/lZDF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870228; c=relaxed/simple;
	bh=E0r9/DNrPZMzTNmudMTgbnQpZbNQsnHxxHUEhyAWIA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWsxCqUeQxHOZu+rFa8EwVsY7ab4cTrkTceu7mT4vRIrt+EHJQ6JTjY3PEqBeu1WU4oak+szy3tFjquvxPSAR+Mb7clqQiQJfTZlMoEExzzWaq/Qj+X8UAX9WHObIWZjkc0eF9DfgzKHGkpPhAQKQ5j3ofntR1HnS7ibvLEAQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=loFl8gVM; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="loFl8gVM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791870216; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=X96x8gYB6IeOXFCRdERXEh//QoAyO0YUh97Wo/O1Xz8=;
	b=loFl8gVMgxSmFAAGFz7cjctyh9nCLNurmO+dVjlokLchRaH+9wPxIjPi/GHySZVcrP1+URlZoXs8kBHjUDnZqS12CnRiBYbjJP4IB2RG2rcj7yPxrNGOfdqCnga+a1/uOIHS9ATK6osj9y2pWzuUlb+iW2hX4RGB+RKK8cDXHPc=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1350185|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0277461-0.000579512-0.971674;FP=784660944313140718|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.jb5SdIU_1791870215;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jb5SdIU_1791870215 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 13:43:36 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: ch341: handle transfers without a TX or RX buffer
Date: Tue, 13 Oct 2026 13:43:35 +0800
Message-ID: <20261013054335.75607-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <50aa0347-c729-436b-898f-7b6befcac9dc@sirena.org.uk>
References: 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mark,

Thanks for the review.

> Are you sure the actual hardware supports half duplex and the fix isn't
> to set _MUST_RX and _MUST_TX?

It doesn't. The CH341A clocks data in both directions on every
transfer and has no mode to disable a direction; the 4-wire mode has
separate DIN/DOUT pins. So v2 sets SPI_CONTROLLER_MUST_TX |
SPI_CONTROLLER_MUST_RX in probe and drops the driver-side NULL
handling:

	ctrl->flags = SPI_CONTROLLER_MUST_TX | SPI_CONTROLLER_MUST_RX;

Re-ran the gadgetfs + dummy_hcd emulation on top of v2: probe, tx-only,
rx-only and full-duplex transfers all still pass, no splats.

No other changes.

Weibin
