Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118E397338;
	Tue, 13 Oct 2026 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880717; cv=none; b=f674rQ9/1CBiA+AvoRUXt75W+PhPzZsEK5gGH4VrIx4W4vRkYuZneUuDsoRp3s2hvPFk13w0hGDLzKMedZtFBhnqh694xKR7oMLb7I1hxrQqEZmEfUIe2J/g1g3IHrZWP8zz/6BEZDzebRwtSDxXYtw0XQ9nb9G+0lhKrNcgfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880717; c=relaxed/simple;
	bh=RpeNoDvshEPKQHNFCw3NB9iFY+rznp6mIlL4Ztajov8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UiiW42KO9MflW3/oawyjKlyiCzhjSrUpW9Ir17IQXkkcoC8vpVzuNXkRyEI4GvVGJko41/HtpkWEgGjyuRzLk9nEWrDLoraG3ji95tIqrHcsTcyLVsR7kInMUt6carW5khWHLefKXh107nRSD/4ViFqLn7z7533+DENk79rCxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=trUPMfwt; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="trUPMfwt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7386E1A11F3;
	Tue, 13 Oct 2026 08:38:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45FB760362;
	Tue, 13 Oct 2026 08:38:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AF9F11D70D49;
	Tue, 13 Oct 2026 10:38:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791880712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+DQ5XhuQFUkS+jrGMmCGyWuQqerm6QYFmNhdS9TLPcY=;
	b=trUPMfwtL4EghKq6qZ44gN5sKerFIWChpxT7eMzei421yKAA8jTCalYH55cPojq4WVKWeL
	OAcDkrc4BCZl/ZOxsYoICikNTWjQ01XC42ZXnLHMRFhP3+NayydbuwR2Rx3N1RQ3SqD4/J
	gvLxB3lkzGuhnndlMt0uD4c8Xe3JyWY2g2Tn/0hk3a2CeM91j6FnOEbnAzBKr35edyQjvm
	1FpbHmvtr4Pljw38zn2bd8Ub4UTD/PJciOuP3RuqMljoOolfjqii7W+Q2+w3f5voZI/BGC
	rDgxG6SICt2euhCERCy85Izw1Csf6IkcEZCYz4Ap3gqtMdmFcaXiGXQSem28AQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <mwalle@kernel.org>,  Takahiro Kuwano
 <takahiro.kuwano@infineon.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Kees Cook <kees@kernel.org>,  Tony Luck
 <tony.luck@intel.com>,  "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-spi@vger.kernel.org,  Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH 1/5] spi: spi-mem: Add support for panic mem writes
In-Reply-To: <5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
	(Paul Cercueil's message of "Tue, 13 Oct 2026 10:25:07 +0200")
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
	<20261005081141.33688-2-paul.cercueil@bootlin.com>
	<asdVM883VTQy7WvH@sirena.co.uk>
	<5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 13 Oct 2026 10:38:26 +0200
Message-ID: <87y0c2vvul.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 13/10/2026 at 10:25:07 +02, Paul Cercueil <paul.cercueil@bootlin.com> wr=
ote:

> Hi Mark,
>
> Le jeudi 08 octobre 2026 =C3=A0 10:32 +0200, Mark Brown a =C3=A9crit=C2=
=A0:
>> On Mon, Oct 05, 2026 at 10:11:36AM +0200, Paul Cercueil wrote:
>> > From: Tanmay Jagdale <tanmay@marvell.com>
>> >=20
>> > Add a 'panic_write' flag to the controller's capabilities struct.
>> > When set, the SPI controller indicates that it will be able to send
>> > commands to a connected NOR or NAND memory in the context of a kernel
>> > panic, which means without sleeping and without relying on IRQs.
>>=20
>> > --- a/drivers/spi/spi-mem.c
>> > +++ b/drivers/spi/spi-mem.c
>> > @@ -398,6 +398,31 @@ int spi_mem_exec_op(struct spi_mem *mem, const st=
ruct
>> > spi_mem_op *op)
>> > =C2=A0	u8 *tmpbuf;
>> > =C2=A0	int ret;
>> > =C2=A0
>> > +	if (op->panic_write) {
>> > +		if (!spi_mem_controller_is_capable(ctlr, panic_write))
>> > +			return -EOPNOTSUPP;
>> > +		/*
>> > +		 * Only support panic writes if we'll go through
>> > .exec_op().
>> > +		 * The regular SPI path (spi_sync(), etc.) explicitly
>> > mentions
>> > +		 * that it can only be used from a context that may sleep,
>> > which
>> > +		 * is not the case on a kernel panic.
>> > +		 * If this changes in the future, this could be reworked,
>> > but
>> > +		 * for now this will have to do.
>> > +		 */
>>=20
>> This also needs to ensure that the queue is idle - we'll still execute
>> spi_mem_access_start() which flushes the queue, and we've got runtime PM
>> operations there which might be a bit challenging in a panic situation.
>
> Does it though? The kernel is panicking so the queue won't be processed a=
nymore,
> it should be fine to just ignore it.
>
> ACK for the PM - I think in the V2 I'll just bail if the controller has a=
uto-
> runtime-PM on.

Maybe pm_runtime_get_if_active()? If already active it returns 1 and
you can proceed.

Thanks,
Miqu=C3=A8l
