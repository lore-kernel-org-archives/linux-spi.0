Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF23C5550;
	Mon, 10 Aug 2026 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373002; cv=none; b=uXpfkf2RWuShMgtIAkqe4Lt2hbenVg01Bq1hRlx3nSRTqQW8Kw4MHEpxCDyonIysyC1er19Q9QEHXPkBUBMWd5KC7VBh+RRisu0MWWdbdZcZU25DCoxzDi2o78O+DCwOSNwrQ9/PnOXVjg14oh7aRSj2l/5CAFBGWPGX7HBC/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373002; c=relaxed/simple;
	bh=D2Sr1P62du5HEB8+F67mwVajqLsw7Ib650hKLf5Ldek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sDqsq2riicrEZ8cX0PZsUSNbZp5U9YpMWAoxtJLbpLyn1Q01VXCgq9NE5NIjBos0XE1MCTXX/0vwk11bsMhSIDDH8C+2qzZPysQtvujMEUYYKPRU43nHqaeGyLBBRTfNMhbA9GdRBHzi4ADmC7huLLLipYrLJzOQnr3IBnliaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ixyRUP3V; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ixyRUP3V"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 109361A1525;
	Mon, 10 Aug 2026 14:43:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D0C586033B;
	Mon, 10 Aug 2026 14:43:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C0DA11C4A92D;
	Mon, 10 Aug 2026 16:43:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786372993; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DFcmzTxcfvHvsND/GxU4BOG9tZi3TmHLVO3tfLXELVI=;
	b=ixyRUP3VJdZ4Xt0yFsjWxqDi8+Dr492tC1T4SfoUVox5rNxOI5nQniHRkV8d7WEEhCr1da
	c0RM1LdCGMi5VX67mf1kJQgzt5I9vRzqdxWHeP93senNma6CjswrsVYlPgJGNu8vSO3DN1
	cpkQGTpmgWgyzMphNK8euhsT45LQWebCKOzIuZ/LImPJNZHP/Qz/XQt8+aGdI7CNOLfNYl
	RQ0OZugTVj7K6OaCyLoJ2wHJoA+a0yn6AGiBconIdWqLEfBWdIfzHS/iPjeiORojKe0xZH
	QPqOpXOcOxC0Q4KneUN84rlIuGWoqzqEtc6oLzovpeDt3heuZpGcfWKPEQvjDQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  praneeth@ti.com,  u-kumar1@ti.com,  p-mantena@ti.com,  a-dutta@ti.com,
  s-k6@ti.com,  linux-spi@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 0/3] mtd/spi-mem: Enable DQS support
In-Reply-To: <8a729209-3bf9-4f2e-8870-1cbb64a95184@sirena.org.uk> (Mark
	Brown's message of "Fri, 7 Aug 2026 17:14:37 +0100")
References: <20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com>
	<8a729209-3bf9-4f2e-8870-1cbb64a95184@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 10 Aug 2026 16:43:09 +0200
Message-ID: <87zeyuox36.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

>> Mark, as agreed, you can take the spi-mem patch through spi for this
>> cycle, and I will pick up the remaining spi-nand patches after the merge
>> window.
>
> As I said on the previous version can you please send something that can
> be applied?  The MTD patches are failing to apply.

I though you had issues with the spi-mem patch. This version still
depends on Santhosh's work. I will send an update.

Thanks,
Miqu=C3=A8l
