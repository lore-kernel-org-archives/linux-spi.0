Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5EE4F30EF;
	Fri,  4 Sep 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539029; cv=none; b=TBiqmvjrhMt3bbFSgz1rbRt6BS2PDsHtgVJuEVNXXsGEbd8+fCEH1WgCgVW8UK7ILtIphJ991KNVAkfUC4dtZY028OaFOxaFS4RNSmJGNdJGHbRQguH0yieZ9OvMXKKEdb2PZQlT8OBq8IFlz9xwLaBe+j11mxU+bE4se3a6EfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539029; c=relaxed/simple;
	bh=qox0mNd0jSGfH1qTJ42nyWyA+xF9tK8i+jADmR2ChNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ImdFIC8l7KUKlJsVcdSmGJHP//MUqKnZYJquY4gfonkpMu01zcOGATaz78vHybhL9sEPHJc7DknWQhKb5pqOiH4JgEXb7M8Br1M+DKvKNhAYJ5Un0pAj6EaNQw1+RSfgKpyLi9TRiF19+JB+7lHsB8Axdrrn6iEh9LI5jlG0Ymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AxI2E/r9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AxI2E/r9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D13391A19AB;
	Fri,  4 Sep 2026 16:23:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8E71F6057F;
	Fri,  4 Sep 2026 16:23:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EF0E11C79C68;
	Fri,  4 Sep 2026 18:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788539020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=beA9Hwr4TwjUwiJxPVmXZ1FsjfJHk0fAVCLyi9HMpZ4=;
	b=AxI2E/r9I3pQTt9xZjQWKK1WHdYdyrMzUaJOcuKbbaVruQUbop5q7Y5O22DP+kzbCXVvOW
	Xksi3xx2Ky9a7cuTFBXyRL4hIawKAVjWwIEcsnzsVe5Da8BelGT9MtZyXhszla35yHL5Qz
	lJ8NqhmKWeLlrv5QmL+h2Hze1p8oz6d25GOqwF+FrGIA/Lx8GH++eJ1BK00gUrJ/E9rhz5
	9kbw7myXGgvZvOipcR5Q/4R2h1eT1lwhQg5LB3RaRRKM9+1ktZF3aYBRv8xlm4TZAUbq5X
	/x7LUwcgZdADqYsNr7oH4z3A+e3LcUc7NE6EtMes3lr/mwO9U+dRz/hb5gHfDg==
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
In-Reply-To: <20260825171737.776052-17-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Tue, 25 Aug 2026 22:47:35 +0530")
References: <20260825171737.776052-1-s-k6@ti.com>
	<20260825171737.776052-17-s-k6@ti.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 04 Sep 2026 18:23:36 +0200
Message-ID: <8733vp0yuv.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Santhosh,

> +static bool spinand_try_ranked_variant(struct spinand_device *spinand,
> +				       struct spi_mem *mem,
> +				       enum spinand_bus_interface iface,
> +				       u32 *tried_mask)
> +{
> +	const struct spinand_op_variants *variants =3D spinand->all_read_varian=
ts;
> +	struct spinand_mem_ops *templates =3D iface =3D=3D ODTR ?
> +		&spinand->odtr_op_templates : &spinand->ssdr_op_templates;
> +	const struct spi_mem_op *best;
> +	int ret;
> +
> +	if (!variants)
> +		return false;
> +
> +	while ((best =3D spinand_op_find_best_variant(spinand, variants, iface,
> +						    *tried_mask, NULL))) {
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
> +			templates->read_cache =3D best;
> +			if (spinand->all_cont_read_variants) {
> +				templates->cont_read_cache =3D
> +					spinand_find_cont_read_variant(spinand, best, iface);
> +				spinand->cont_read_possible =3D
> +					!!templates->cont_read_cache;

I believe you almost addressed the concerns raised in v7 about
cont_read_possible, except what you do here is still a bit dangerous
since you could re-enable continuous reads on no_cs_assertion capable
controllers. I believe you should clear the flag only, never risk to set
it, something like:

if (!templates->cont_read_cache)
    spinand->cont_read_possible =3D false;

With this fixed,

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

I believe I will take this patch only after Mark takes the batch before,
which looks mostly good for my non-spi-expert eyes. Either Mark shares
an immutable tag, or I wait one cycle.

Thanks,
Miqu=C3=A8l
