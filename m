Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786859;
	b=jrl6uofltr3eHYcUdMek0Os7bYLdszTmtmItapEReYidYioyL5oSqX+N2cnNSxWHHTpu
	 3FvIJltLudJzLbtr1ccQnV+c7Zi9/FjQuu2TR9W8fVORhruPbEV1VwYGvF6jfDpplzIH3
	 14mv8PkvAzCR/uvbsucivkd9YtHA6V0mzreTVtrvVWsjWHRbKhvhuRd76RneUrSeCumTQ
	 iZJcq7nuPBe8GtvvCsVxm5cBhnLYF6Ju1VhDLVOECZeWlbCpjmjKp0XU/gCAU69VFtfo4
	 ih5aJGYLtJ8zBtFf8vYW7KwJyJGm1+IDOcPQLGQGti+I4B6TX0caz7woOQQSubtowww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786859;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=hgPMTyozEX0Bob23rV+PxYM8+DzQbrvzgXYzL5B0Tso=;
	b=uilvKZKnNrdaVHHA+IngXvBWhXxiqEwY8tAerSh6Ah3S+maldbMJZCtJ1ttk4R8CAHxA
	 ODTWV82fuO29c6tr4glGEJLQkN0zdRyttvmNYliOWF9IEgaJ4FjY9BaKQGeuZOH+6pN6p
	 VJUD9OcNLuqT44mAC+RsUMeAnI6Ifu/FkzBHLL47CmogLOfczoc8QV9M7YZScCllghYco
	 J7ClGHYp3tyMxwi9Y3iNZdBWzWu8LjY/olcKLG20w++6cUn8Ko658yXlmfFq1vHpjgI/j
	 yuMnUtvQebDH7BLuAgTZteSDqiKnSRWcfMtg2maw7vXCFrEjmSz6RIH6F9rmy8GBOyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VuGgTG1h;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3D606A31B
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 10:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CED3D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VuGgTG1h
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5E1661A1452;
	Wed,  4 Nov 2026 10:07:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 31AD960770;
	Wed,  4 Nov 2026 10:07:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F146B103291CE;
	Wed,  4 Nov 2026 11:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786856; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=hgPMTyozEX0Bob23rV+PxYM8+DzQbrvzgXYzL5B0Tso=;
	b=VuGgTG1haXL/EbQWSGc6mcJ4P28e5ym2QyUNVQ2iYAyavjG0IugbfOQDAT24Dt0UHoRH3n
	Br7YSPiL1Jtg7uqNTo2lnJWkWpR+QztYov4XyiGxx91FXr72gkWKbqrwAwiIrhndESQY4U
	+ecyZnqH5g1kAnGWwYtJKyBIgcGSmY6bKUCrKxMM+bd9m7eO8+0h8SFPPrX+/XHtH8F25M
	cgWAsFWIDq1kBfZfub7ew05UopP+VdPysVyhUTLTBFsHQBb6Wav1W+AL/Mwitrn0ZGX0j0
	Mirg6Qbofgbft9oMvVlWhDCDGRm0fTB1Ub/CuDLQhUq4G0uxN8Bb5D8YqNdURw==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 0/5] spi: cadence-xspi: Fixes and misc. changes
Date: Wed,  4 Nov 2026 11:06:38 +0100
Message-ID: <20261104100643.162694-1-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

This patchset adds two fixes to the Cadence xSPI driver, some cleanups,
and adds a workaround for probing the Marvell IP on firmwares that use
the base string.

I understand you may not like the workaround, I hope the fact that it's
tiny makes it OK...

Best regards,
-Paul

Tanmay Jagdale (5):
  spi: cadence-xspi: Reconfigure to STIG mode before SPI message
  spi: cadence-xspi: Inform SPI core about size transferred
  spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
  spi: cadence-xspi: Rework resource discovery
  spi: cadence-xspi: Add workaround for old Marvell firmwares

 drivers/spi/spi-cadence-xspi.c | 105 ++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 40 deletions(-)

-- 
2.47.3

