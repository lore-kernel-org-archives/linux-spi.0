Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3684F7986
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539118; cv=none; b=P7iAVwviAsT851KfZhak9mm2H5MbK0DXRA13GqsKgZc1qAVfJscUCD/YtPsU8C+zxLQec0aydrv06iwHGkjKCJHzLeVFKrDAGqnrMuvrAFF/cmO1/RVpbllaAMcnJsbs008XA6YswzEQ1knqD97tZqfVrGQwlfwWORW0IciJIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539118; c=relaxed/simple;
	bh=KpKl3UVi9Fq7dKiIeQaxU6LbPlOWOfgwtqgdEjyxlmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENbFAZ9Kc2L6Q2CktQND4s465iI9v1AL/5iiPfPST46jOvmOZkypk0OeXMXlpxns/Aa78akMetKA1DT6XOqyH7+gn7KLSpXhSyePJXG2YcSXVeaGU46eRyJHvCiy6EPx8sOAenMk4+ouThF9hB0FoZHIuel2ABNAg7jvOMhvKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G+ANkK2H; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G+ANkK2H"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2C6104E41512;
	Fri,  4 Sep 2026 16:25:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 015486057F;
	Fri,  4 Sep 2026 16:25:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82B0211C787BD;
	Fri,  4 Sep 2026 18:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788539109; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iyGbuXlnEHu5IZ2Y67+lbl3dPNb3QBxNs0BWA67Ll5g=;
	b=G+ANkK2H6/aFhwPmFuRcpqZ3mwSHSh27XhVyoIdKGhKiRh/20momsiWHTh1jGlCagjl9cp
	un/H+5TyQwux9KIktJkpzPZ6jCT3Z6rwB/tVCpsCuNWahE1y3jJagSC4rqIvV5Tb2ypt9T
	onqcj3ltdvwMCbcgYcUzvmLyn29Pi3ZLAJkQkBWtEZPh+Lh/5POHGevtKB8qf8cCwGbOsT
	HCm0aLkvWmbkj0uzmUAYID3fLTUjOakvSH7bgymRSJGFFgt+UNfSADXosw9xS+AiaxW5si
	qACcfiALENuz0P6Dm/Gs1y4cPv9XOk5T3bn8+gLIbQsV2VAjGjFM8HAkfgqQ5A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,
  <sebin.francis@ti.com>,  <u-kumar1@ti.com>,  <a-dutta@ti.com>
Subject: Re: [PATCH v9 16/18] mtd: spinand: negotiate optimal controller
 operating point before dirmap creation
In-Reply-To: <8733vp0yuv.fsf@bootlin.com> (Miquel Raynal's message of "Fri, 04
	Sep 2026 18:23:36 +0200")
References: <20260825171737.776052-1-s-k6@ti.com>
	<20260825171737.776052-17-s-k6@ti.com> <8733vp0yuv.fsf@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 18:25:04 +0200
Message-ID: <87wlt1yof3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3


On 04/09/2026 at 18:23:36 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> Hello Santhosh,
>
>> +static bool spinand_try_ranked_variant(struct spinand_device *spinand,
>> +				       struct spi_mem *mem,
>> +				       enum spinand_bus_interface iface,
>> +				       u32 *tried_mask)
>> +{
>> +	const struct spinand_op_variants *variants =3D spinand->all_read_varia=
nts;
>> +	struct spinand_mem_ops *templates =3D iface =3D=3D ODTR ?
>> +		&spinand->odtr_op_templates : &spinand->ssdr_op_templates;
>> +	const struct spi_mem_op *best;
>> +	int ret;
>> +
>> +	if (!variants)
>> +		return false;
>> +
>> +	while ((best =3D spinand_op_find_best_variant(spinand, variants, iface,
>> +						    *tried_mask, NULL))) {
>> +		*tried_mask |=3D BIT(best - variants->ops);
>> +		spinand->max_read_op =3D *best;
>> +		spinand->max_read_op.max_freq =3D 0;
>> +		spinand->max_write_op.max_freq =3D 0;
>> +		ret =3D spi_mem_execute_tuning(mem, &spinand->max_read_op,
>> +					     &spinand->max_write_op);
>> +		if (ret && ret !=3D -EOPNOTSUPP)
>> +			dev_dbg(&mem->spi->dev, "%s optimization failed: %d\n",
>> +				iface =3D=3D ODTR ? "ODTR" : "SSDR", ret);
>> +		if (!ret && spinand->max_read_op.max_freq) {
>> +			templates->read_cache =3D best;
>> +			if (spinand->all_cont_read_variants) {
>> +				templates->cont_read_cache =3D
>> +					spinand_find_cont_read_variant(spinand, best, iface);
>> +				spinand->cont_read_possible =3D
>> +					!!templates->cont_read_cache;
>
> I believe you almost addressed the concerns raised in v7 about
> cont_read_possible, except what you do here is still a bit dangerous
> since you could re-enable continuous reads on no_cs_assertion capable
> controllers. I believe you should clear the flag only, never risk to set
> it, something like:

cf. Sashiko's: [High] Unconditional overwrite of `spinand->cont_read_possib=
le`
bypasses system capability checks, risking unsupported continuous reads.

>
> if (!templates->cont_read_cache)
>     spinand->cont_read_possible =3D false;
>
> With this fixed,
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> I believe I will take this patch only after Mark takes the batch before,
> which looks mostly good for my non-spi-expert eyes. Either Mark shares
> an immutable tag, or I wait one cycle.
>
> Thanks,
> Miqu=C3=A8l
