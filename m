Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D8392C21
	for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2026 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329563; cv=none; b=PjZ4ZH4V2mPxDxfsd4kDHrkaACHYe6lXvu+kWSq4zKBoKkQiW+jVA3GeyDgXx0g5x8Nhx8KTwZ5qFTWbsWBazVhPxP2qISXlIdIuCiey/xSbbtWw6gOb2/pCeMOHDkvW5/2IHXNPKXGSH0ZA9OUYY3MbEksy5uAMS6aOkgFje94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329563; c=relaxed/simple;
	bh=7vVwrsIHf6aHmWOyHU2Az280abktl9uVuRAps8/BsoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=imuBsBvqtF5DkDMcI9t41x47n8IA34OwybMYTQQZGJIYzKexAAK3USb3kr7NOB6bzqv57T4tevxZ0p119p0lur99MwslcoW1REFBJIAo8GTENTXwIKJA+9sHhp5uc0zhG/D2jNTrvsVdVuC14FHSi8RQTCBx51TuJ6zcx2ISQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U1u0vcPS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U1u0vcPS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B09F51A1020;
	Fri, 25 Sep 2026 09:45:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 835886073B;
	Fri, 25 Sep 2026 09:45:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C531103282AA;
	Fri, 25 Sep 2026 11:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790329558; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EOThfG1gAEQrdHbmqd9U2MHSe1d8X1Jx4rb69pMs/X8=;
	b=U1u0vcPS0rl4z2+2fhX2VGhVdHFt5eSkTXIxrhry+eSFu7QOpEtU9vCK2f9IYzl8ajgjLg
	Kcn+Klbb4KJLqYMMRcFDbrBR3ckaE2OHtDU8y5BMPf7ADpMoFmdkrvDx5D2HZMfUL9ptTE
	ztq1fekIUw73uu79IhccWuBuvsEdgrqHk/8D6MZpaMIncWO2fRsXmAVMbTuPin4zcpEp1S
	a+dcG5iMctAIaGVE4RzzcVB1sV/EfKO2By3dRvRMb/aUXLt1JJ/0cv9apHwoQydLknN2hp
	2AzOVrDyYH8CA5qwTZ4D0ZA/ODweTBwZWDOoFmpULIPl3cJjGcMY28vs9WP7kw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Fei Xie <fei.xie@horizon.auto>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Parshuram Thombare <pthombar@cadence.com>,
  linux-spi@vger.kernel.org,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
In-Reply-To: <67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk> (Mark
	Brown's message of "Thu, 24 Sep 2026 19:55:58 +0100")
References: <20260921093701.1341766-1-fei.xie@horizon.auto>
	<20260921093701.1341766-3-fei.xie@horizon.auto>
	<arFEjzkHGMbecWWV@sirena.co.uk>
	<20260923061211.1608907-1-fei.xie@horizon.auto>
	<67f4e1a4-fc0e-4b2b-b41e-8dbb33227302@sirena.org.uk>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 25 Sep 2026 11:45:51 +0200
Message-ID: <87pky1ll4g.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 24/09/2026 at 19:55:58 +01, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Sep 23, 2026 at 02:12:11PM +0800, Fei Xie wrote:
>
>> The difficulty is that the hardware ACMD sequencer needs the complete
>> multi-operation sequence to be described before it is started. For
>> example, the SPI NAND core currently submits PAGE READ, status polling
>> and READ CACHE as separate spi_mem_exec_op() calls. The STIG path can
>> execute those operations individually, while the ACMD hardware combines
>> them into one programmed sequence.
>
>> Would an SPI-mem operation-sequence interface be a reasonable direction
>> to explore? The NAND core could describe the ordered operations and
>> polling condition, and the controller could either execute the sequence
>> in hardware or fall back to the existing individual operations. This
>> would keep NAND-specific knowledge out of the controller driver.
>
> I think that makes sense, that mirrors some ideas people have had for
> optimising SPI mesages in general - submit the sequence to the driver to
> see if it can do it in one, falling back to just running individual
> operations if that doesn't work.  See spi_optimize_message().

The spi-mem operation-sequence interface seems very complex to handle
correctly IMHO. I fear such a solution would also require major rewrites
of the core. It is always hard to make fit hardware in code bases not
thought for them. Most of the time being spent in I/Os and wait states,
I am wondering how much would be saved by packing the commands. Do you
have benchmarks?

Thanks,
Miqu=C3=A8l
