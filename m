Received: from mail-106101.protonmail.ch (mail-106101.protonmail.ch [79.135.106.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A938C42F;
	Tue,  1 Sep 2026 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251572; cv=none; b=ZA3LxS6CAvpX+jF7T8hTEBzrVtE23x0fM+BoBxFH3ABTPbMG0tCRyYiH/KDm/JYiv9W1ehP8GhmbOH0t2qhp3SnerntYPvl1apA4fEjQlUfCuR2DaXe6LsoeZD2dzqFxjs11C1bLeKN4K89jHuTLz3VBLp3yK9+dr41F+uhWyqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251572; c=relaxed/simple;
	bh=vFIRkRGOxQLx2UNx+9AtLq2T78ALmapd0H5qPthPplk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbOxnxIswP/QtW4po+dZdH6wQ+4TbHdPAlafFmlKSWA0xYvEBa9WCog6jHTak+zoPTaf4p+EWUu2M4Wx2H4nNYosrhOd62TClLVZttD7fwqvmGptpROZe94P9Eo70GfU67b9ui/N9pBlQrdqC4ONe0k7DGUDEhg0tpASYXuRnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=dlhQQQYy; arc=none smtp.client-ip=79.135.106.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="dlhQQQYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1788251561; x=1788510761;
	bh=xgTF6OOdZLsOJV9Zkr8Cucyb3bnKLcpcMmZZ/a9pfGI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dlhQQQYyE4J8sBkpX3O1xawfVra45O6/AVoyRqm2XdZwy4V/796N28nvFNFmrV5yJ
	 QEyJpvBZgjfQpbhnSM+ZBkqJDLgr/zO6Fieas+z85AYQ6N/8Mqf12X+9SBPjY0ZWez
	 h8rbC0QveUo/PSiGBPJ7/SJHLaxE2zpdVZMU5K1fS/oLruYzq2JDB1IIe3nSdwSaDT
	 CEhS1irMGHV6eZACoqyS/nmk+hZWBqKOkpztL5KdCKm9GN3F4hXBmdyWSfDIJuUh0h
	 W66Wn9yPWxvkqH41m0eUpvVpIjYHVcYZFW32wAalm7PR+5vJZtR6+AbX/PMN3qLxXw
	 PiBR7ns/a7RvA==
Date: Tue, 01 Sep 2026 08:32:33 +0000
To: Michael Walle <mwalle@kernel.org>
From: Tobias Jakobsen <tjakobsen84@protonmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Takahiro Kuwano <takahiro.kuwano@infineon.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: allow the platform to supply write protection state
Message-ID: <bwwdwkT-nZT9pant-Nb_0PF8R531C5F2gDKrs-rZvW7MG1LHPf-MGmBH5YOSWTBnvZkRl4cPfXSzukcHaxoUZE1Ow0zvIfFCaOqYESzLjZE=@protonmail.com>
In-Reply-To: <DL34U80UW849.3OYQBBTN7GRJ8@kernel.org>
References: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com> <20260831-spi-nor-platform-lock-v2-1-6cc75b909241@protonmail.com> <DL34U80UW849.3OYQBBTN7GRJ8@kernel.org>
Feedback-ID: 214933398:user:proton
X-Pm-Message-ID: adc3d59a08d785e63a22d8267bdc0c554b4af630
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hello!

On Monday, 31 August 2026 at 14:37, Michael Walle <mwalle@kernel.org> wrote=
:
> > +static int spi_nor_platform_is_locked(struct spi_nor *nor, loff_t ofs,=
 u64 len)
> > +{
> > +=09struct flash_platform_data *data =3D dev_get_platdata(nor->dev);
> > +
> > +=09return data->is_locked(nor->spimem->spi, ofs, len);
> > +}
> > +
> > +static const struct spi_nor_locking_ops spi_nor_platform_locking_ops =
=3D {
> > +=09.lock =3D spi_nor_platform_lock,
> > +=09.unlock =3D spi_nor_platform_unlock,
> > +=09.is_locked =3D spi_nor_platform_is_locked,
> > +};
>=20
> If we can't unlock the flash, what's it's use then? Can't we just
> clear the HAS_LOCK if there is an intel-spi driver?

Clearing HAS_LOCK would replace a wrong answer with no answer
(-EOPNOTSUPP). That is an improvement, but it discards information the
kernel already has, since spi-intel reads the protected range registers
at probe anyway for the MTD_WRITEABLE masking in
intel_spi_fill_partition(). Userspace is then left parsing the Intel
specific sysfs attributes to find out, which is the platform specific
special casing this series is trying to remove the need for.

If I understood correctly MEMISLOCKED is a query rather than a control.
"check if chip is locked" with no qualifier restricting it to the
chip's own block protection bits. On PCH protected machines the answer it
gives is wrong: the region is protected and it reports otherwise.

spi-nor cannot tell which controller it sits behind,
so suppressing HAS_LOCK needs the same channel through
flash_platform_data; only the payload changes.

The reason it is a callback rather than a flag is that the answer is per
range. On the machine I tested, PR0 covers 0x860000-0xffffff of a 16M
chip:

  query 0x860000 + 0x7a0000   -> locked
  query 0x0      + 0x1000000  -> not locked
  query 0x0      + 0x10000    -> not locked

A boolean would have to claim the whole device is locked, which is wrong
for everything below 0x860000.

That said, if you would rather have the simpler suppression, I am happy
to do that instead.

> >  =09/*
> > -=09 * NOR protection support. When locking_ops are not provided, we pi=
ck
> > -=09 * the default ones.
> > +=09 * NOR protection support. Platform enforced protection is preferre=
d
> > +=09 * over the chip's own, as the chip is not necessarily aware of it.
> > +=09 * When locking_ops are not provided, we pick the default ones.
> >  =09 */
>=20
> This doesn't work, does it? What if a flash already provide locking
> ops?

You are right, it does not. The vendor late_init hooks run before this
(core.c 3063 and 3072), so atmel.c and sst.c have already set
params->locking_ops by then and the platform query is skipped. A chip
with its own locking ops behind an Intel PCH would still report the
chip's answer.

I will fix that in v3 by having the platform ops take precedence
unconditionally rather than only filling in when nothing else has.
Let me know how you'd like to proceed regarding HAS_LOCK clearing.

Regards,
Tobias.
