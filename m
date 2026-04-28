Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CED4317D
	for <linux-spi@vger.kernel.org>; Tue, 28 Apr 2026 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380279; cv=none; b=InRyzjE2ckQ9AMX5ey8kYqk26Fjagr9eBzA9Rg9b5GCEXugdpWTPAk6i2RRMoC+NKPDfJ7vAoS+Itvvdzq1LKIRrjImJw9ffyDKZaiDDCJ91gfOuEC3xSCZJedL34pCUuAuTEgMjrKJb7PqVIm8PNAPrnA2eQAEGcdlFvGmAeek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380279; c=relaxed/simple;
	bh=sz0zbVibYD3ws766mYrKtBGdJgj3I/pYhnlAXRz8F84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TPS45pPruQBjj87jP4/V0Hh99a1zZ1LXZUcZTAPtqmGCd7jDo4rxfdcRdsQE8wAwu0STUOiR4U93lQlni8TJQdb0MmGPfey6EDoz/HmawaKqwRa7NDSIuQ/5k2WAxcyky1zuVW0Kbu9zukb0vpL1lzdiJt68QfmVTFZguHV+bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q8UPeq/P; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q8UPeq/P"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D99644E42B54;
	Tue, 28 Apr 2026 12:44:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7804601D0;
	Tue, 28 Apr 2026 12:44:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7056210728B2D;
	Tue, 28 Apr 2026 14:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777380273; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sz0zbVibYD3ws766mYrKtBGdJgj3I/pYhnlAXRz8F84=;
	b=q8UPeq/PDsYwFot0SvyZRpslhROcaSLOmfgDwKPM9fMDqPvX6zFXnZXtm4p1jiwRuhASnv
	HruUr3EJBZA51npI3/aq4ibQoZzcS5YaWyz/4MkBd0ipYuYj1ef+G1s8lbrJCrP8dI8n8y
	uNM1Ca2SD1VJp7q0FWSn4OoeFrZ+wF2ri2hiqd7TIFfmarFFjcmJ82wjt8/LnWoalnicI2
	UVjDwVNAcnSVaglr7wmc1sztJYUPhS9g+oZv2Ay0xeM0YnuT2Q6C6smSWtd0+2k7FCkxof
	e7tINB0SofrQfyZMVgWqHarDKShk5qQ4114N+sScP8eo6Yc12ckDhvUrB3sFYA==
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
Date: Tue, 28 Apr 2026 14:44:33 +0200
Message-ID: <878qa7dzke.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 26/03/2026 at 17:47:14 +01, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> TI errata i2351 explains there is a problem with CS handling, SPI NOR
> are immune to the problem, but the CS being deasserted spuriously when
> there is DMA arbitration on long accesses (every 1023 bytes), SPI NAND
> continuous reads cannot be leveraged.
>
> Link: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
>
> I created a 2-page read setup for testing all variants available on a
> W35N chip wired to this controller. I reliably observed all variants to
> always (in my tests) report correct data, except the 8D-8D-8D
> variant *when setting an extended number of dummy cycles* (>= 12, so 24
> dummy bytes). In this case, I got the first 6144 bytes correct (over
> 8192), the rest being full of ones (0xFF), indicating the CS has likely
> been deasserted there. This is not exactly 6 x 1023 bytes (?), but
> close.
>
> This series shall be applied on top of the SPI NAND continuous read
> series that I am also carrying, but ideally not too far in the future
> because there are Winbond (continuous read capable) NAND chips mounted
> on TI platforms AM62 based which could make use of that new feature and
> expose the issue described above.

Applied to nand/next (except the spi patch).

