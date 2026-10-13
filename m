Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AA3815E1
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879922; cv=none; b=lfa4Mc6Fv6r9L5QPq6iZjaAok7QmOXx04fYKACBbD6kEAzDfdceX0/T1BcdH1EHiagGl2o3mG8aa7iG1ikd9acTb5XHcbxTPsMBJXCrGjHNBnycwRVZ+HI/NZOQSTN/I0oYYRp4U0Gn23J18wV8WutRRI5VMk+5wkXg0ajTsPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879922; c=relaxed/simple;
	bh=c/VWEj0I6jlLeO9SzoXKPfAZN3aS47qQ69UBEMQ+oC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JnLYQzQcFQUKrfRcdpcrhiuXK2Uo44OXY4R+yNL7cUFZfKlkLMoiLJsJm6/Qkahl2iPSt0RJa2J/n+s6d2s5L8LFIcgRlc8yftTYE3sRsCFg/BYpE/VMptYOnn22qBb/SWJnTF86s+hsmIOnhUDxS64Te/UIVAu9MFQ3I7NP9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zWbkaoId; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zWbkaoId"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A01691A1110;
	Tue, 13 Oct 2026 08:25:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C2DC60362;
	Tue, 13 Oct 2026 08:25:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8960211D70602;
	Tue, 13 Oct 2026 10:25:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791879917; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1PoPJ3DJcosvCsZQEhxoej+1PxwmM3Lju5f0jGzpqcg=;
	b=zWbkaoIdGA24lSQPQIulKy6ElH8P0hblH1xcFXJqReF/bVjtFPY8dYt0ohT9Ar9+D1HV8P
	hywsBvv5UNe2z2bWTOpUI+IoVZAKncfeuag19BPcjBp4svZEf/yNLp/dIczlruMYVttW/q
	yZQtIpI0TO3GxcpTHRyj4LoQ8IAx5je/+H8FEU8wt/2/Kuyybqb/ayjNbWHH9suT/xMioJ
	NKmCO6gFEIW8wxAOkCs6sZLybY2jJFn195eQiCN+NiYkqb4YdSjFdzvSel/rq97THJ4u0p
	cG79UxQ9t9+pxCBiCSoe2ggUC2vbq8FEiYA4JvnQLqJozniFKcG9fg95eN63GA==
Message-ID: <5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
Subject: Re: [PATCH 1/5] spi: spi-mem: Add support for panic mem writes
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
  Takahiro Kuwano <takahiro.kuwano@infineon.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger	 <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, Kees Cook <kees@kernel.org>, Tony Luck	
 <tony.luck@intel.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, Tanmay Jagdale <tanmay@marvell.com>
Date: Tue, 13 Oct 2026 10:25:07 +0200
In-Reply-To: <asdVM883VTQy7WvH@sirena.co.uk>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
	 <20261005081141.33688-2-paul.cercueil@bootlin.com>
	 <asdVM883VTQy7WvH@sirena.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi Mark,

Le jeudi 08 octobre 2026 =C3=A0 10:32 +0200, Mark Brown a =C3=A9crit=C2=A0:
> On Mon, Oct 05, 2026 at 10:11:36AM +0200, Paul Cercueil wrote:
> > From: Tanmay Jagdale <tanmay@marvell.com>
> >=20
> > Add a 'panic_write' flag to the controller's capabilities struct.
> > When set, the SPI controller indicates that it will be able to send
> > commands to a connected NOR or NAND memory in the context of a kernel
> > panic, which means without sleeping and without relying on IRQs.
>=20
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -398,6 +398,31 @@ int spi_mem_exec_op(struct spi_mem *mem, const str=
uct
> > spi_mem_op *op)
> > =C2=A0	u8 *tmpbuf;
> > =C2=A0	int ret;
> > =C2=A0
> > +	if (op->panic_write) {
> > +		if (!spi_mem_controller_is_capable(ctlr, panic_write))
> > +			return -EOPNOTSUPP;
> > +		/*
> > +		 * Only support panic writes if we'll go through
> > .exec_op().
> > +		 * The regular SPI path (spi_sync(), etc.) explicitly
> > mentions
> > +		 * that it can only be used from a context that may sleep,
> > which
> > +		 * is not the case on a kernel panic.
> > +		 * If this changes in the future, this could be reworked,
> > but
> > +		 * for now this will have to do.
> > +		 */
>=20
> This also needs to ensure that the queue is idle - we'll still execute
> spi_mem_access_start() which flushes the queue, and we've got runtime PM
> operations there which might be a bit challenging in a panic situation.

Does it though? The kernel is panicking so the queue won't be processed any=
more,
it should be fine to just ignore it.

ACK for the PM - I think in the V2 I'll just bail if the controller has aut=
o-
runtime-PM on.

--=20
Paul Cercueil, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
