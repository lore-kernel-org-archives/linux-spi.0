Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749129;
	b=Cy1aZNJRhn+PitBVdKTslOSWK3jKnhWIwidpkFnvKvA9217fTU5PvZBIjSps7o+1oBTR
	 0DNtYU2L5APHE8Ocbjdz72IObVFZaCWHRmKq97voqxxfgIl0n6W/IwD3S9FyF5z0TT45v
	 kNZvDllKANFmQJXKhtPBH6F3gJpasdUNABS/GKQijqwhOMD9GUwa3K+4LVEo5LKS7ZbfW
	 BP7OpKkdmcVECzK0HUS1ZboZd9wZT2oM9M6FsWEGfZe2eYj81SCwwQbV9qmYNzEUt4+jf
	 x0JIxCR132zcHN3uwnnsxbXw/NkNzJpU8iwVS3cwFUb7E8jSYPatAvIbQZneV2BB77g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749129;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=hGktRpAovBNP2O/hbEpgY8U5f/oq3Xu2oDGMSALMQuM=;
	b=bnR+fyZVtQf6bam0sM5LYFXnwFOx5BgZz4a5ozwa2gFoM3USjnCVrrteZxTjCNETgQ/u
	 rWjPfc2qS7q24OOdKdGUl8/DiIDa76MivupxccPwwyR7HzA9fam/aMBytDOLfMzgw38hY
	 sacbuk9wDEwIZD7AkEidH9puzNLscJOD+ADF4eeSbqVydlMd2wBXbvQ24iVctPxnxa1zD
	 FMPTqdx/cRUND4iI/cJz4cR/tDMas2QxTe502Me45fSaKJGCesl96Mfi9p7hvkWuzVD3K
	 UlK8OaisKAXopJa9L0PBKZhqp1IeimzJVHlIO55LX8uh25/phIoyALCXq/VkWiBTjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DW8YfnRJ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7F606A31B
	for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 09:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8C7F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DW8YfnRJ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 93E97C6344F;
	Fri, 23 Oct 2026 09:53:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CCE860398;
	Fri, 23 Oct 2026 09:52:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 426EB10328BF4;
	Fri, 23 Oct 2026 11:52:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792749124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hGktRpAovBNP2O/hbEpgY8U5f/oq3Xu2oDGMSALMQuM=;
	b=DW8YfnRJV9XAKi/jv8v6qHBDZJqJ+626gsZ4gcIQRZnswwef9yBaCgHKequgDHpGIWmcVd
	uyHh/UlBRIM8CmqkHC8iRJs7bcLcei4bf+xD0XWyUcYC+kFx9OnF/OCIdCuofu3SpD8o/3
	fhQhRRwHpZ5my1R9rKmSZW2OyenqBggHnYNicZUUQF2PVG48NYRU9UzOgM+9pjMg9ACLyG
	7ErYUw9qvvmDwHPoxzYHgwS/PdFjHx0RzGL2UjE4j3oiKXgOutmo49asaLNsI60gVuT9dS
	QvBDz4ds4xvIOFgiyvwXFsZfEeMqRw1TURbcP9z6Q4mmPggB5H8KXrd2D6ncxw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Takahiro Kuwano <takahiro.kuwano@infineon.com>,
  Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v1 1/4] spi: dw: Add DDR (Dual Data-Rate) support for
 enhanced SPI mode
In-Reply-To: <ZQ4PR01MB1202C6B2531173B2D395C619F2642@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
	(Changhuang Liang's message of "Fri, 23 Oct 2026 09:42:56 +0000")
References: <20261022102614.75696-1-changhuang.liang@starfivetech.com>
	<20261022102614.75696-2-changhuang.liang@starfivetech.com>
	<87bj8mqaof.fsf@bootlin.com>
	<ZQ4PR01MB1202C6B2531173B2D395C619F2642@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 23 Oct 2026 11:52:00 +0200
Message-ID: <877bj8pwvz.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


>> > --- a/drivers/spi/spi-dw-core.c
>> > +++ b/drivers/spi/spi-dw-core.c
>> > @@ -46,6 +46,8 @@ struct dw_spi_enh_cfg {
>> >  	u8 inst_l;
>> >  	u8 addr_l;
>> >  	u8 trans_t;
>> > +	bool inst_ddr;
>> > +	bool spi_ddr;
>>=20
>> If I understand this correctly, spi_ddr is quite a bad name because it m=
eans
>> address and dummy and data ddr (but not instr). Can you try to come up w=
ith
>> a better name for this variable?
>
> spi_ddr is named exactly that way on the register field. Perhaps I won't =
change=20
> this variable name, and just add some comments to this variable=E2=80=94w=
hat
> do you think?

This is a boolean, not a register bit field. Please use a name that
makes sense here. This is the part of the software that people must
understanding without deep hardware knowlege. You can keep the hardware
name for naming the bitfield operation if that's relevant though.

>> Also, if my above understanding is correct, you must provide a
>> supports_op() callback which would refuse any xS-xS-xD but allow xD-xD-xD
>> and xS-xD-D modes.
>
> OK, I'll add some filter conditions.
>
> Best Regards,
> Changhuang
