Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86C33A3834;
	Thu, 13 Aug 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610165; cv=none; b=Hy0b4a6RJ8gh2KtE7oGvj52R8ipAm5+B85jUgAs1g7y7li4SykXKo7lcQZQ3D+9A75ffPZjeKk9E2mAH36R4+uFXFvlx99Vv0B/Fe+Vf6ESpxJdxds5bC6U9GJx3fi600CPCV4QlxKo0dJxdRKZeoYRtBMLjXlK8Vfuw5cOTSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610165; c=relaxed/simple;
	bh=EMrrOf72bwBbKga5jC7K8G91L5VCS03knmIVhlsnldo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P+EyizDoI5LVdtOVSKWDUHKNO9h3ivZBr6zc2lI/Qq22CFFxh8EC8SRTDWhFHWy2ZSICOv9Krq2kXMGAhNO/Jd/ep0y+GE0Qz0PSvvZJJD/1J7gfpJ6GYKxEXoE/le1U8MkXZ6OaoRIh30JZ+/yC4SnM1v+EWLwfGAkJ0B+koaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ULJrxkpT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ULJrxkpT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4C5554E411E8;
	Thu, 13 Aug 2026 08:35:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 07351602B8;
	Thu, 13 Aug 2026 08:35:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6327811C4DB29;
	Thu, 13 Aug 2026 10:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786610156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GpGUXUL/3ly8tG9nRmn5kJJy+CYafCrEj7bnx6zV2Ro=;
	b=ULJrxkpTfkC1gSTd5Svscu84GOvHJL0Qbxf0I7MS4nIoWKp9Ia5RtDkOVGsjsyGgkF1W4O
	0Mot+07TLuIDyFdkJ7c2ah64hwK2L4E2lgY7X08p7t+be+k93Q5WvIG+odZn7nyYCTs7o7
	uKTSKxWqs/GGWqcFP8q4U2+FZUF08nFdiS/TskZyoNFVhsCLWMw2iMmEcVbDvaqkPMlNtk
	H418GcTautbj4ZZTB6O4hKo+4tpmIVO5XZD947t1p7NsYTRxEjDbIIyfZ78P5nkqvTBidA
	XXfqcatSLZu+0j+DBVz7HvcMMQRURDbRapI2iDSTjLbpUJvYuOfnLhRXpCxY5Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v7 16/18] mtd: spinand: negotiate optimal controller
 operating point before dirmap creation
In-Reply-To: <20260811183313.1550425-17-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 12 Aug 2026 00:03:11 +0530")
References: <20260811183313.1550425-1-s-k6@ti.com>
	<20260811183313.1550425-17-s-k6@ti.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 13 Aug 2026 10:35:52 +0200
Message-ID: <87bjb6l8nr.fsf@bootlin.com>
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

I have only one comment on the spinand bits.

> +/*
> + * spinand_try_ranked_variant() - Try controller optimization on variant=
s in
> + *				  performance order.
> + * @spinand:    SPI NAND device
> + * @mem:        SPI memory device
> + * @iface:      bus interface to iterate (ODTR or SSDR)
> + * @tried_mask: bitmask of already-tried variant indices; updated on eac=
h try
> + *
> + * Iterates the full read variant list in descending performance order,
> + * skipping variants in @tried_mask, and calls execute_tuning on each un=
til
> + * one succeeds. Ranked iteration finds the best available variant witho=
ut
> + * re-trying already-attempted ones.
> + *
> + * On success, sets spinand->max_read_op and updates the matching
> + * odtr_op_templates.read_cache or ssdr_op_templates.read_cache.
> + */
> +static bool spinand_try_ranked_variant(struct spinand_device *spinand,
> +				       struct spi_mem *mem,
> +				       enum spinand_bus_interface iface,
> +				       u32 *tried_mask)
> +{
> +	const struct spinand_op_variants *variants =3D spinand->all_read_varian=
ts;
> +	const struct spi_mem_op *best;
> +	int ret;
> +
> +	if (!variants)
> +		return false;
> +
> +	while ((best =3D spinand_op_find_best_variant(spinand, variants, iface,
> +						    *tried_mask))) {
> +		*tried_mask |=3D BIT(best - variants->ops);
> +		spinand->max_read_op =3D *best;
> +		spinand->max_read_op.max_freq =3D 0;
> +		spinand->max_write_op.max_freq =3D 0;
> +		ret =3D spi_mem_execute_tuning(mem, &spinand->max_read_op,
> +					     &spinand->max_write_op);
> +		if (ret && ret !=3D -EOPNOTSUPP)
> +			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
> +				iface =3D=3D ODTR ? "ODTR" : "SSDR", ret);
> +		if (!ret && spinand->max_read_op.max_freq) {
> +			if (iface =3D=3D ODTR)
> +				spinand->odtr_op_templates.read_cache =3D best;
> +			else
> +				spinand->ssdr_op_templates.read_cache =3D best;
> +			spinand->cont_read_possible =3D false;

Why do you disable continuous reads? I know it is not the same as the
read template, but it only differs by a few dummy cycles, so everything
should work as expected. I believe without complexifying much the logic
we should be able to support it.

Thanks,
Miqu=C3=A8l
