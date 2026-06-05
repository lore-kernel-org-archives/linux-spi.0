Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF76405C22
	for <linux-spi@vger.kernel.org>; Fri,  5 Jun 2026 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640172; cv=none; b=PzGNRewr3NL1AORikm61e8uoZ2xQp7f+C8vDb/tCfAZSM/TjeRvpN0JRgN036w22F57ArMFNPz56scG26yruwAkcGr3NfSEegGbaLrsURp6otxyO06+5dMCOZpoIe3UfDhtEkAozelXayDYVDQLrzeA4om9TyZ0UJSZNpvZheiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640172; c=relaxed/simple;
	bh=tooW/XxqZtgoRZGuqoPGpyAcWluv8ktlW6V5MDUZHPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rV2T/hwyF74NAi6NyLXP22Lb/MyqRJsU9Jb3uFu8AvDr+K4PgBZz+4JZIjjMNupGvft9UsGO8Gr/GHdSeLa1aFirOZa1iRFdA/ylDMVDSpaTHzx76AFe1dMnVTZAIgHcNcx9Rq64BW+VjRivVVwbXjIl5LBlbBed5EqfFNSQ0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cHzlsZS2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cHzlsZS2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F13254E40769;
	Fri,  5 Jun 2026 06:16:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B77BA5FED1;
	Fri,  5 Jun 2026 06:16:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E923106A1EE4;
	Fri,  5 Jun 2026 08:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780640163; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=deiuXUFDNSX7cfC+kx+/zdue7rrj2MqboxTE2cMg8zE=;
	b=cHzlsZS2hSySMxs5YUSmcxkzm4CHL4ifkBgF3iZ+s0sxiTlqKSFgF3Ygfz6DjgQr2eS/N6
	dQdX/HnAaJ6AuiDDIRsOpRXSdkppcayDYo0Bv9zJ6dUAS5xT9DRhyX6hmupWwkr5oiZXIS
	aLvyCQdark05GVxMuc5TdJm9W5NfjBTcYsfnxbZiDysCviCZwSVWrpoW1LX95R63CLrTk+
	Juo/BjZ5OutF7onvPh5K1UEOuyskhoaGcqrS9EdYXll1ThE6jYJ3jKDotEIzWwOWhqXw9D
	RNmF+7TlRBdVFRZXG4XCvNnBGZ/yftz4c+MbbEh8eAQt1EWy6xLbSjHkQ9OLog==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 04/13] spi: spi-mem: add spi_mem_apply_base_freq_cap()
In-Reply-To: <354e81b1-3070-439b-b404-20a2c30bd774@ti.com> (Santhosh Kumar
	K.'s message of "Thu, 4 Jun 2026 17:40:26 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-5-s-k6@ti.com> <87fr3bhqkk.fsf@bootlin.com>
	<354e81b1-3070-439b-b404-20a2c30bd774@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 05 Jun 2026 08:15:57 +0200
Message-ID: <87fr31wm02.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Santhosh,

On 04/06/2026 at 17:40:26 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Hello Miquel,
>
> On 28/05/26 14:13, Miquel Raynal wrote:
>> Hi Santhosh,
>>=20
>>> --- a/drivers/spi/spi-mem.c
>>> +++ b/drivers/spi/spi-mem.c
>>> @@ -398,7 +398,11 @@ int spi_mem_exec_op(struct spi_mem *mem, const str=
uct spi_mem_op *op)
>>>   	u8 *tmpbuf;
>>>   	int ret;
>>>   -	/* Make sure the operation frequency is correct before going
>>> futher */
>>> +	/*
>>> +	 * Ops not configured for maximum speed are limited to the conservati=
ve
>>> +	 * base speed; spi_mem_adjust_op_freq() then caps to the device maxim=
um.
>>> +	 */
>>> +	spi_mem_apply_base_freq_cap(mem, (struct spi_mem_op *)op);
>>>   	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
>> There are many more spi_mem_adjust_op_freq() calls in the core where
>> we would
>> not apply the base frequency. Aren't we missing these places? Wouldn't it
>> be more appropriate to call spi_mem_apply_base_freq_cap() at the beginni=
ng
>> of spi_mem_adjust_op_freq() ?
>
> Moving spi_mem_apply_base_freq() into spi_mem_adjust_op_freq() would
> affect operation selection.

Yes, and that is precisely what we want.

> spi_mem_adjust_op_freq() is used during variant evaluation through
> spinand_select_op_variant() and spi_mem_calc_op_duration().

And this is a one time specific initialization path. There we need more
logic, probably.

> Applying the
> cap there would cause all candidates to be evaluated at base_speed_hz
> rather than the actual max_speed_hz. As a result, variant selection
> could converge on a different operation than the one that would be
> optimal.

But this is only a single place. Whereas in your implementation you push
the complexity in every place using the spi mem interface, I don't think
this is wise as you will likely end up with many unseen corner cases.

Thanks,
Miqu=C3=A8l
