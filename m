Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4B3CAE68;
	Mon, 27 Apr 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296494; cv=none; b=KLU32wJsPw9Xql/Saca6bS9jLg8aVXNcMhriVtIarsyEpoJwhm/CXLFQVbffusg2Y6bCwmiaNjSe/h5RjlEi+h5Sn0cBmQVQiXJn86pPtFtsTJ3Q9VZplEC5ewGhU4tzKVZitOIHF91ez5d/jkrgfm33aFBsn0Nc/32HtwEaSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296494; c=relaxed/simple;
	bh=t+YbMxhDEFBqxdOaao9a2i/12aQWgAwFHh50CUJtreU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=niNnw2UTVDMpyGXIjA1HxgsDZir1yN3up4qj0rTQYdzpDmzS/G1zeo9ESx1uR50KsYB63hqDeCXa30aw7LnnbaQVnt0bSDKlDCfzILpaNRyl12wigPtcBzd+k1I+G/Ss9CVXkJXEvTOIQ/y+koffGTSPdiLAu8JMsHgHzEOicsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cxvs/Dzr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cxvs/Dzr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BF5A14E42B2F;
	Mon, 27 Apr 2026 13:28:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C652600D1;
	Mon, 27 Apr 2026 13:28:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F2DD107281F7;
	Mon, 27 Apr 2026 15:28:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777296486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t+YbMxhDEFBqxdOaao9a2i/12aQWgAwFHh50CUJtreU=;
	b=cxvs/DzrYqeR3GWDvFgxxpZ0c8S5K+wK2Y0ri8esgmJX9ZqI26je63Jg1k1kIMtPdm3iLT
	uVAlgQPevpm5G4USDptHNU8Q8VcfPlzloz4SMfWcDyi2VBOOq1zMuovIPhoCISSygVcGlF
	IisvkT/0Eo7GoQdOH4EsqOmmnfpmUG6eY5BChtSMoYdnwbwvp4Nt1Uz/436Hhn0El2qdyl
	Fb40mq3m2QoWGI6wXGnubAgAjeDVcPEG8Fdcsbx0OmPx+ILLaG+8MDdSbvemn0d5WHwrG0
	WMh2RZ310ibY9RN8qMt9OAwx96O3ouiDdsxAmyrhIFmh7ESTv8ZTQQ4mZDAxAw==
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
In-Reply-To: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
	(Miquel Raynal's message of "Thu, 26 Mar 2026 17:47:14 +0100")
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 27 Apr 2026 15:28:06 +0200
Message-ID: <87mryoh6s9.fsf@bootlin.com>
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

> Mark, as agreed for the continuous read series, I will offer to you an
> immutable tag with the spi-mem patches, if you agree I can include the
> spi-mem patch from this series as well (once the discussion on the
> approach/naming settled).

As discussed, I am preparing an immutable branch with the spi-mem
patches of the "Winbond SPI NAND continuous read" series.

This series is related but I wanted to double check with you: can I take
the spi-mem patch and include it in that immutable branch which I will
share with you for inclusion in the spi tree?

Thanks,
Miqu=C3=A8l
