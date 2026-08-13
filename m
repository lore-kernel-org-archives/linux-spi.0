Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A243BDB8
	for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608043; cv=none; b=K+itEndNWJFB7o+CCfyjSrTOUjluQUz6ywaFgzvEVfemqpX79+xsXISxpyy6eOyHKjwGyp63UjjpO4AKjcrfIi3DfIHeENvq0RqeZE9hNAlBLvGxb0TvK6wDvw2Bo7IkIX2UwtpU1p1ZUsoZ754eky6SRbbtJMylKnIyV2tDbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608043; c=relaxed/simple;
	bh=j0aRTTtn19/B3QDJ23hcTk+zoLtJ1b0alR1Et7ms4B0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QQpKUC0TFdYTvpXqtiVQa9Pc6aY0OJyhsVWnxXQ639YaWOlBI3NsakdtAb7ejHdZTBY9pZj5nu0W54k6kYQp93DPxuksioffk0suc21rhL0X0RjIWhNxRSVqTTboenTjyroolspiXVRcbjpNH2ruzLaN7+L7aqz/8QIPv+yhx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ufP8VHah; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ufP8VHah"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 861701A15EF;
	Thu, 13 Aug 2026 08:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59D0F602B8;
	Thu, 13 Aug 2026 08:00:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AB5D11C4DA82;
	Thu, 13 Aug 2026 10:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786608030; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Vu1I83CnZIHvvoR1PbXWxMi/QaYDMKy7JaNHneju1vg=;
	b=ufP8VHahpanRL9IaHzNx3fOWYNjS6wwde8X1tPuw+liX071mzngS32gZbGAKOqp/2tjsIv
	tlu8DP/m/xnBCaZpUx3fvnC4HtBPCGoFG+qF7exhA7paGAwcxwl4ovVRBv/y/zd8niGJ42
	0izxhoSNe4xWJL5QohHiCjn/gk4HV/cttL+FY8f3eInzgfs13JmRr7HdsKVLhn5ymEl7jv
	f0GmUTSW2dWBXyHfmib2ek4XtEMy5YpRMFceyQFdrwrD47oTXQJRAIVZqCBZXEH5nsqNYP
	Y/u3lfiUr0GhRK5D98uiaEkGybB85aH5LpFjYJ2qQhwPSAxUJ0LJ4TMNdrZsPQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/5] spi: ma35d1-qspi: Improvements and DTR support
Date: Thu, 13 Aug 2026 10:00:20 +0200
Message-Id: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAwA0F+RnBewLTrxV8YOsUaXg9olKoL47
 xaP7/JOMFZhg7Y4QXkXk2XOcK8C4o/mkVH6bPClr8vGBUystuBEoeodbslWZZrwb0nQxW6IFH2
 o3wQ5SMqDHE/++V7XDfGGanlsAAAA
X-Change-ID: 20260813-perso-ma35d1-upstream-qspi-1cbfcac2367a
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

I am in possession of an MA35D1 NuMaker board. The SPI controller has
been contributed, but:
1- it lacks a DT descriptions [1]
2- it does not work with current clock driver [2]
3- it can be improved
    
Link: https://lore.kernel.org/linux-arm-kernel/20260813-perso-ma35d1-upstream-dts-v1-0-bb237fd7c3c2@bootlin.com [1]
Link: https://lore.kernel.org/linux-clk/20260813-perso-ma35d1-upstream-clk-v1-1-e78e5e6172ea@bootlin.com [2]
This series is addressing #3 by:
- reusing existing helpers
- refactoring a bit the code
- adding DTR support

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (5):
      spi: ma35d1-qspi: Remove redundant reset operation
      spi: ma35d1-qspi: Move speed setting to bus configuration
      spi: ma35d1-qspi: Allow several command bytes
      spi: ma35d1-qspi: Add DTR support
      spi: ma35d1-qspi: Use the existing update helper

 drivers/spi/spi-ma35d1-qspi.c | 108 ++++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 40 deletions(-)
---
base-commit: 1ec281b42ee249cfe9bad52a54149de29ed6aa78
change-id: 20260813-perso-ma35d1-upstream-qspi-1cbfcac2367a

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

