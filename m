Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CBA486431
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872800; cv=none; b=roReEq5HVdhg0u64mWZZQkB4c7kR0QIIBR8jZnLpQFytdhqgXC66dPZS7ZSwwtu2J+O/iJlJYhMhsgRcxxltWYk/VUaJTrgjbr2ApUYYlTMptDlGMoyvH9gX+y392eTO1Wbyw9Mp8ULYPloEkhMSSPxo1k9GPmjmAPgdQBtrBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872800; c=relaxed/simple;
	bh=s6+tQTA7eM+scFpAMzrbaCGiLe0m1KsihrjpBh2oaWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHQhGxHDjC2fXgZYlkHThy1cLUUEqr+uGk+LskCfYpFnGoX0Ku6BuM/BhtMvPHw0DNBUPKW1bcUFhgGZPJrzSvjGHv0HgD8eYp2lmV25Snfzrmv/Zg6vCHLS+u/SgVUujuLairv0RMScZ5Rt/p0iXwwDj3cIGkaO7jaT4u7iNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZUWSwCH5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZUWSwCH5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3EB551A18B7;
	Thu,  1 Oct 2026 16:39:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A7836035C;
	Thu,  1 Oct 2026 16:39:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D8161032813A;
	Thu,  1 Oct 2026 18:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790872795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zqO9wZAcpr/Xip1m0ECW+JKX9OkInYFz8R6jGpSZpwc=;
	b=ZUWSwCH5hIeRSW7iJp9LnRx2eQDRD3Pe7PvVf9XdlfTJcI6x3efnRyLVl0HbRxMAr+Eire
	372cp3SSp/9MJ4MqhrNjQrN/acJcaWJQEeKMF154bO8xwXZnzVqqVSCvG9EPofv7JRjo1S
	Ghb0hKezKZsTSbg+MhGwkm+v56UMSz2zVy9nsE22oqqhrQ0b09Bx9KNLydaJIe4B/ecG5Z
	b0b2o9/e1t2zY8N6wpOlW/QWLnlbi8loSAuFizHeYVSA1VddXNS4BB09dG+vVVwOU4TtNN
	r+WBC7sXq735w3W29MIbyh3Zh06u4Us1g2/DJ7vrYatZDu0iXKNZ3TW9Gywbpg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Michael Walle <mwalle@kernel.org>,
  Takahiro Kuwano <takahiro.kuwano@infineon.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Steam Lin <STLin2@winbond.com>,  Santhosh Kumar K
 <s-k6@ti.com>
Subject: Re: [PATCH 0/4] spi: spi-mem/mtd: spinand: Prevent SPI NAND
 continuous reads on am65/am62
In-Reply-To: <38290328-a562-4813-a9e0-2fafaa3874c7@sirena.org.uk> (Mark
	Brown's message of "Mon, 28 Sep 2026 16:08:47 +0100")
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
	<878qa7dzke.fsf@bootlin.com> <87mrt177km.fsf@bootlin.com>
	<38290328-a562-4813-a9e0-2fafaa3874c7@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 01 Oct 2026 18:39:48 +0200
Message-ID: <87cxttml2j.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

>> It seems like the spi bits have not been applied, can you check if you
>> can still apply them? Without these, people using this controller with
>> continuous read capable devices may observe spurious issues hard to
>> debug (due to the CS possibly not being kept asserted during long reads,
>> leading to the continuous read being cancelled by the SPI NAND).
>
> No, they don't apply to even v7.3-rc1.  I didn't see the immutable
> branch mentioned in:
>
>    https://lore.kernel.org/r/1FyLxEwWqNFzX@sirena.co.uk
>
> yet?

In theory you should have received a request to merge
the immutable mtd/spi-mem-cont-read-for-7.2 tag some time ago:

Subject: [GIT PULL] spi-nand/spi-mem changes for 7.2
Date: Tue, 05 May 2026 17:17:42 +0200

But that's not a big deal, I will rebase the remaining SPI and resend ;)

Thanks!
Miqu=C3=A8l
