Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33034E5337;
	Tue, 13 Oct 2026 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889272; cv=none; b=pQ2bygVWtZlwcadKHDY+Z6x0lh1Atnrvoj/ASMtKYz+abCCh+UjODHT+1ys04lLbVVkVlhaU3UNckfpqWopgF3H/sJnwqmxwvSQrH9sQwTIaeD3V50jVODBboTlUuaCGIZhy8Gqmz+WJmMjPI7Nm5ZnhQz6T9BkYHhuxRa2HndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889272; c=relaxed/simple;
	bh=pRsd0+ITU/DhENFNJeUWb5wGX0cdOh0IA/UVGxrV/7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3+OdJyRRLIQWxQAzfUVMGhdndtvQTxv1jGuWP0gRELfp4VX38bezTciy5qIXnImCkjZBG8ccrhXjdpXyAuFO380Zaj5VAQplouXr9E8HA+sHrysoZS3DM1amNi1+gt3PBOIzelgkdpXA96t1oEWddpLQIIifavcV9GG5YRXOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pa6q+aFW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pa6q+aFW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 17FE04E4120A;
	Tue, 13 Oct 2026 11:01:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBD8E60362;
	Tue, 13 Oct 2026 11:01:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF66D11D70DB0;
	Tue, 13 Oct 2026 13:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791889259; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pRsd0+ITU/DhENFNJeUWb5wGX0cdOh0IA/UVGxrV/7w=;
	b=pa6q+aFWWBhpNbm91Cl8fTXViS2r51JQPutE+sx/neqqdCtEyFAs4GgOssai/IU8VWqWZ1
	t4tSjUnFkSTzrR0tLAu22j5TN1aQrzF7MEe+mx21XPeGFwVYhEWXoHCPUmD5yvP2whUG2A
	kOtRXPhSsx0fsmvskVnGBbVRGIGGx1UKGS4MbqhmYIqKYyrfEpSAHu6OLC4ORq2QK6v4i4
	rQpAOq/lyFJJxtm8L4vepYNp/VAchjDNCCXV6DeRldcbbLw0m3zIF6x58iMtwdMVPUTbqH
	ulUYuAkDJhGApzlQLsmS7dSVkqGfM3YLYTXF9J7cF+LlcddIQQWf1DcMGe0AyQ==
Message-ID: <0d2f1d4149cd136ace8c1f08dc48ea7f25c5975c.camel@bootlin.com>
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
Date: Tue, 13 Oct 2026 13:00:50 +0200
In-Reply-To: <eb16cf0a-6b7e-4ea3-89c5-61ba0729492d@sirena.org.uk>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
	 <20261005081141.33688-2-paul.cercueil@bootlin.com>
	 <asdVM883VTQy7WvH@sirena.co.uk>
	 <5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
	 <eb16cf0a-6b7e-4ea3-89c5-61ba0729492d@sirena.org.uk>
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

Le mardi 13 octobre 2026 =C3=A0 11:42 +0100, Mark Brown a =C3=A9crit=C2=A0:
> On Tue, Oct 13, 2026 at 10:25:07AM +0200, Paul Cercueil wrote:
> > Le jeudi 08 octobre 2026 =C3=A0 10:32 +0200, Mark Brown a =C3=A9crit=C2=
=A0:
>=20
> > > This also needs to ensure that the queue is idle - we'll still execut=
e
> > > spi_mem_access_start() which flushes the queue, and we've got runtime=
 PM
> > > operations there which might be a bit challenging in a panic situatio=
n.
>=20
> > Does it though? The kernel is panicking so the queue won't be processed
> > anymore,
> > it should be fine to just ignore it.
>=20
> Do the other CPUs know they're panicing yet, and what state is the
> hardware in?=C2=A0 I'm a bit nervous about assuming panic got things into=
 a
> good state.

The other CPUs are stopped, yes. At that point there's no SMP, no preemptio=
n, no
IRQs, no time accounting.

The hardware is supposed to be in idle state, and the way we ensure that is=
 by
checking that the controller's io_mutex / bus_lock_mutex are unlocked. If t=
he
SPI driver was busy when the panic occured, we just bail.

Cheers,
-Paul
