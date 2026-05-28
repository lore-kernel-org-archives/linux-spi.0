Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D8390CBE;
	Thu, 28 May 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960443; cv=none; b=Bv8iKnJO87Dtdi/LebpWgbqUvtUxBaKXQcatY0IhpCKMuCW7FHzAp8G5+gaQFlWdb7FqikZ7ZaYw0ViiOMudYqPs5+8oFqe5458olAmK7Cmb4oAJDNbzr8WR5fnUY/4kSCEo0vpdkF/F58VI6yj5gc3G5k1Bl+oaslsBkApbdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960443; c=relaxed/simple;
	bh=6MaINiaW9woTpfXqx4l+TlOHzXhBSQQdF1YgxoOLHSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7GiJ1uBJLq1Ej8NN34q99Pxwfl+5snCDzoDQRMFPGdOEHxfZVq6fBDEMagWjx9KcBIDzf/8LtHKLw8PS8s0mbkrz2QwKGQZe1fmA9dckBpyfPgkK+gSUQIlcW+uKYv9e4+SXLYYE9cggLfkQ3KH1Qb+qQ8q2v3thKpPQV6alxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v7zUT13w; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v7zUT13w"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B599E1A3704;
	Thu, 28 May 2026 09:27:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8669460495;
	Thu, 28 May 2026 09:27:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4677110888C99;
	Thu, 28 May 2026 11:27:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779960437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aFcPPmXLQabQsc1ycX/dsgPewGocQDCIFeeqSEgvr2A=;
	b=v7zUT13wBSF/FrDCrr/gSdvw1loLx4i9gR0SQTM1OV/1Re88co7SVpzbcDesEmczBWYGOm
	35VUfoUIGWVuqRWMNj07kQeYbKoop4ZL19mN4WUZCf1Xun3s5qpJ5mgxoSX13WIfPP+FkN
	KnBgQ3zi46Mw1jTRbvbeHx4uzrUEJV71e4UmowGcbsoRZPba2SAzIvNp52YnpJdHqdYQ6t
	dQqeJxLOgsFazm6351UmFSjRMiW0xgeR+lR39rnuGDbPUTgNgAD/wSpe7YtjKX0Q50wl9d
	/hefaXRUgr2UOro2MFwYNvcFQK5nv0KrwQ05j9Vw96cnU26nuMKZ7wtbwlD/dQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 11/13] mtd: spinand: run PHY tuning after init and
 update dirmap frequencies
In-Reply-To: <20260527175527.2247679-12-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:25 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
	<20260527175527.2247679-12-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 11:27:13 +0200
Message-ID: <87mrxjg9zi.fsf@bootlin.com>
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

On 27/05/2026 at 23:25:25 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Run spi_mem_execute_tuning() in spinand_probe() after spinand_init()
> completes. The read and write op templates are copied into persistent
> fields in spinand_device so the controller can write the validated
> frequency directly back into them. On success, propagate that frequency
> to every dirmap's primary and secondary op templates. Updating the
> secondary template ensures continuous-read dirmaps also benefit from
> the validated speed, not just the primary read path.
>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
>  drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h |  4 ++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index f1084d5e04b9..9b54e4607cfe 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -2030,6 +2030,41 @@ static int spinand_probe(struct spi_mem *mem)
>  	if (ret)
>  		return ret;
>=20=20
> +	/*
> +	 * Copy the read and write op templates into persistent fields so
> +	 * execute_tuning can write the validated frequency back into them.
> +	 * Tuning failure is non-fatal; the device operates at base speed.
> +	 */
> +	spinand->max_read_op =3D *spinand->op_templates->read_cache;
> +	spinand->max_write_op =3D *spinand->op_templates->write_cache;
> +
> +	ret =3D spi_mem_execute_tuning(mem, &spinand->max_read_op,
> +				     &spinand->max_write_op);
> +	if (ret && ret !=3D -EOPNOTSUPP)
> +		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
> +			 ret);
> +
> +	/*
> +	 * Dirmaps were set up in spinand_init() before tuning ran; update
> +	 * their op templates to use the validated frequency.
> +	 */
> +	if (!ret) {
> +		struct nand_device *nand =3D spinand_to_nand(spinand);
> +		int i;
> +
> +		for (i =3D 0; i < nand->memorg.planes_per_lun; i++) {
> +			if (spinand->dirmaps[i].rdesc) {
> +				spinand->dirmaps[i].rdesc->info.primary_op_tmpl.max_freq =3D
> +					spinand->max_read_op.max_freq;
> +				spinand->dirmaps[i].rdesc->info.secondary_op_tmpl.max_freq =3D
> +					spinand->max_read_op.max_freq;
> +			}
> +			if (spinand->dirmaps[i].wdesc)
> +				spinand->dirmaps[i].wdesc->info.primary_op_tmpl.max_freq =3D
> +					spinand->max_write_op.max_freq;
> +		}
> +	}

Unfortunately, hot fixing the dirmaps is invalid. When we take the best
variant, we select a maximum speed that may be lower than the tuned PHY
speed. We cannot just overwrite that value without consequence, because
depending on the boundaries we cross, extra dummy cycles may be
required.

I believe spinand_select_op_variant() shall be aware of the different
possible speeds. It should look for the max_speed_hz capability and not
for the base_speed_hz, and fallback to base_speed_hz in case of
issue.

Or otherwise, maybe we could go through the whole I/O variant
selection again after tuning, with the actual maximum speed set.


Thanks,
Miqu=C3=A8l
