Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CD476067;
	Tue,  1 Sep 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252569; cv=none; b=RoclGasCUh0aD7c81/Bn7VqHiSYfPObOXLVjeCHgQpSEigfMazjT6a2g0yGniBEYYrSzHYFTvuKoELpzyySdPjP9TpC8gCxJE4hCBLTFR6BNR4WxjnFvGOomqkipd8YZ2bcwwxIP+n1DT6A0SkytBZqTLmBRFMQ4OxJXg0SbAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252569; c=relaxed/simple;
	bh=xcQxu5+dHIbuL9wynISeyXgGDrujS4SlkcdvEsKTtEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=PEBwyjK3c287RR14uJEUsXV7NbTMk7mfwUZanIITHIaoMU6QWBRt3zPe6ZM2K/hhnmYphRR+rJT5PHsFtQ/+OJPfke9KK3bJGfajqvvAk64YYROBCsSo5hsdPwY8j0BxwIQbZBtmbFDdIC5mY3Z++cBlgzmFNt6zOjWA7dY08KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 8CFE4103;
	Tue,  1 Sep 2026 10:43:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 10:43:09 +0200
Message-Id: <DL3UHUKN6Q0Y.1HN2PJA78WK3M@kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: allow the platform to supply write
 protection state
Cc: "Pratyush Yadav" <pratyush@kernel.org>, "Takahiro Kuwano"
 <takahiro.kuwano@infineon.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Mark Brown" <broonie@kernel.org>,
 "Mika Westerberg" <mika.westerberg@linux.intel.com>,
 <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-spi@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tobias Jakobsen" <tjakobsen84@protonmail.com>
X-Mailer: aerc 0.20.0
References: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com> <20260831-spi-nor-platform-lock-v2-1-6cc75b909241@protonmail.com> <DL34U80UW849.3OYQBBTN7GRJ8@kernel.org> <bwwdwkT-nZT9pant-Nb_0PF8R531C5F2gDKrs-rZvW7MG1LHPf-MGmBH5YOSWTBnvZkRl4cPfXSzukcHaxoUZE1Ow0zvIfFCaOqYESzLjZE=@protonmail.com>
In-Reply-To: <bwwdwkT-nZT9pant-Nb_0PF8R531C5F2gDKrs-rZvW7MG1LHPf-MGmBH5YOSWTBnvZkRl4cPfXSzukcHaxoUZE1Ow0zvIfFCaOqYESzLjZE=@protonmail.com>

On Tue Sep 1, 2026 at 10:32 AM CEST, Tobias Jakobsen wrote:
>
> Hello!
>
> On Monday, 31 August 2026 at 14:37, Michael Walle <mwalle@kernel.org> wro=
te:
>> > +static int spi_nor_platform_is_locked(struct spi_nor *nor, loff_t ofs=
, u64 len)
>> > +{
>> > +	struct flash_platform_data *data =3D dev_get_platdata(nor->dev);
>> > +
>> > +	return data->is_locked(nor->spimem->spi, ofs, len);
>> > +}
>> > +
>> > +static const struct spi_nor_locking_ops spi_nor_platform_locking_ops =
=3D {
>> > +	.lock =3D spi_nor_platform_lock,
>> > +	.unlock =3D spi_nor_platform_unlock,
>> > +	.is_locked =3D spi_nor_platform_is_locked,
>> > +};
>>=20
>> If we can't unlock the flash, what's it's use then? Can't we just
>> clear the HAS_LOCK if there is an intel-spi driver?
>
> Clearing HAS_LOCK would replace a wrong answer with no answer
> (-EOPNOTSUPP). That is an improvement, but it discards information the
> kernel already has, since spi-intel reads the protected range registers
> at probe anyway for the MTD_WRITEABLE masking in
> intel_spi_fill_partition(). Userspace is then left parsing the Intel
> specific sysfs attributes to find out, which is the platform specific
> special casing this series is trying to remove the need for.
>
> If I understood correctly MEMISLOCKED is a query rather than a control.
> "check if chip is locked" with no qualifier restricting it to the
> chip's own block protection bits. On PCH protected machines the answer it
> gives is wrong: the region is protected and it reports otherwise.

This feels like I'm talking with an AI agent. Honestly, this is
rather discouraging.

So my short answer: I don't want to clutter the code just for some
weird behavior and my point stands: whats the use, if it's not
possible to unprotect that region. The intel-spi controller is
rather restrictive anyway.

-michael


> spi-nor cannot tell which controller it sits behind,
> so suppressing HAS_LOCK needs the same channel through
> flash_platform_data; only the payload changes.
>
> The reason it is a callback rather than a flag is that the answer is per
> range. On the machine I tested, PR0 covers 0x860000-0xffffff of a 16M
> chip:
>
>   query 0x860000 + 0x7a0000   -> locked
>   query 0x0      + 0x1000000  -> not locked
>   query 0x0      + 0x10000    -> not locked
>
> A boolean would have to claim the whole device is locked, which is wrong
> for everything below 0x860000.
>
> That said, if you would rather have the simpler suppression, I am happy
> to do that instead.
>
>> >  	/*
>> > -	 * NOR protection support. When locking_ops are not provided, we pic=
k
>> > -	 * the default ones.
>> > +	 * NOR protection support. Platform enforced protection is preferred
>> > +	 * over the chip's own, as the chip is not necessarily aware of it.
>> > +	 * When locking_ops are not provided, we pick the default ones.
>> >  	 */
>>=20
>> This doesn't work, does it? What if a flash already provide locking
>> ops?
>
> You are right, it does not. The vendor late_init hooks run before this
> (core.c 3063 and 3072), so atmel.c and sst.c have already set
> params->locking_ops by then and the platform query is skipped. A chip
> with its own locking ops behind an Intel PCH would still report the
> chip's answer.
>
> I will fix that in v3 by having the platform ops take precedence
> unconditionally rather than only filling in when nothing else has.
> Let me know how you'd like to proceed regarding HAS_LOCK clearing.
>
> Regards,
> Tobias.

