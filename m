Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C724A207C
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968108; cv=none; b=ok3HPPwUxmg1JpAhYOl79oIg47Sd+2Y1/q5KhBzlOwU2ZBOvNYelT3BcZKuDlDzM+yUwMbKkcwrvSsVBqDvA/aQSrUafILEzJzHyYuI3qcUP+kq4WWDPXl3G0r87wX4e+V9H3uCwIkkX7J4dqTbprrgytW2ccUFRU1zapvS49D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968108; c=relaxed/simple;
	bh=p1ESfnGJs632WJQwDweeEKBejwXJXmPDIvvHT8ekolo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGrIFJ0fOfoE8raFYW0hN76tRTFREON7/FyPCZn3C2ZN6dpTbq1wFDpCOLX2nYhpY+EVwc1GCk8dl4hB4gYnUYNic+aBoKZHXDukDP8irVyEkJUGJDFWZRzyjSf/DgFj8mhIG1VDxbYZGVI9X1iyCEQKgNEnNS4NxhX4wvOZWsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qoM3nBbU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qoM3nBbU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C9CEB4E4120B;
	Wed, 14 Oct 2026 08:55:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 907C660368;
	Wed, 14 Oct 2026 08:55:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5E78103286A7;
	Wed, 14 Oct 2026 10:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791968104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p1ESfnGJs632WJQwDweeEKBejwXJXmPDIvvHT8ekolo=;
	b=qoM3nBbU7T4hs5LrPD56Yg1Uidle/RVUP5cbW/a7PJaA/jWSyc/z7YKUWKWt3fQOv3ylNJ
	auQl7PxshL80uMOhPny71WP06UzMVP7OQcgCSTwD1yU+n9Fi27Z5ZgLoeXdn7VqTF5vk2+
	FygxKKNluMWd3wOEYeb6lhQFt9vaVgzNtPKhHVY1AMPdnjoeVqExQ+MflejRCiSEB6WRoI
	kUpWs9RNjd2F/eMl+xgDJ2s4rpfZmhpnW1npRj1zRO0VvOmuppfpf7Gjyz0aLkz12mGnSb
	q6udCSuHkCKUPy3B/meWQxZcLSCu8cO5dspyR1wT5MAJRz7i4k6ZM42eDD0+Xg==
Message-ID: <74b2030cb64f8c25f95d51894d3296f180a34e01.camel@bootlin.com>
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
Date: Wed, 14 Oct 2026 10:54:56 +0200
In-Reply-To: <629a4f32-2efe-4212-ac1f-f64c487caa63@sirena.org.uk>
References: <20261005081141.33688-1-paul.cercueil@bootlin.com>
	 <20261005081141.33688-2-paul.cercueil@bootlin.com>
	 <asdVM883VTQy7WvH@sirena.co.uk>
	 <5c94b88bf7123e5a32d5c4bd77217e6a40683c83.camel@bootlin.com>
	 <eb16cf0a-6b7e-4ea3-89c5-61ba0729492d@sirena.org.uk>
	 <0d2f1d4149cd136ace8c1f08dc48ea7f25c5975c.camel@bootlin.com>
	 <629a4f32-2efe-4212-ac1f-f64c487caa63@sirena.org.uk>
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

Le mardi 13 octobre 2026 =C3=A0 17:00 +0100, Mark Brown a =C3=A9crit=C2=A0:
> On Tue, Oct 13, 2026 at 01:00:50PM +0200, Paul Cercueil wrote:
> > Le mardi 13 octobre 2026 =C3=A0 11:42 +0100, Mark Brown a =C3=A9crit=C2=
=A0:
>=20
> > > Do the other CPUs know they're panicing yet, and what state is the
> > > hardware in?=C2=A0 I'm a bit nervous about assuming panic got things =
into a
> > > good state.
>=20
> > The other CPUs are stopped, yes. At that point there's no SMP, no
> > preemption, no
> > IRQs, no time accounting.
>=20
> My worry is what happens if we didn't actually manage to stop the other
> CPUs - in theory we've shut everything down, but I've been burned by the
> bug being IPIs breaking.=C2=A0 Perhaps it's just not worth worrying about=
.

My understanding is that the panic handlers are written with the assumption=
 that
everything is stopped, it's up to the calling code to ensure that it is tru=
e.

-Paul
