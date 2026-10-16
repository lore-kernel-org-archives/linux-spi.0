Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325E2D3A7C
	for <linux-spi@vger.kernel.org>; Fri, 16 Oct 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141400; cv=none; b=Jk9NtaqKp3hNxG8h0bb5QhtnkpFALubAKNA6efy4e/DfL15N75zWkCdTQrmr7bEQMq7cHIjt4up4utR7jRpiK13rCL/SBGwuzgluhP/xDlzxH0q5qI5PoMlXgreph9Wq2+mW9J8r+FCv79wk5x+vTDBTYP/APy55ZKcSdxOaduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141400; c=relaxed/simple;
	bh=ZT/sWpmVZ48A0UV1NDljoImwkaY+rB5RM0fdLed9wk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJUjxVWoSh7kwPq8+pubWcBtPjgmBgGFRSbvB13HfHYDnSf9BjhyjTivnnyS0HolzuECInxK5/AK/rNUX8GnHK5UYc2XN8n2RK3D+/lp4bEfXiCAjnxdJZU2Vr4YH6yjoHeIedJ8xbZ9uAUYcyJ+VX3WZTHCm6Z4EYiuFuIc7jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BEtx/5et; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BEtx/5et"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 554BA4E4124C;
	Fri, 16 Oct 2026 08:55:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29A726075D;
	Fri, 16 Oct 2026 08:55:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB4AD10328B9B;
	Fri, 16 Oct 2026 10:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792140952; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZT/sWpmVZ48A0UV1NDljoImwkaY+rB5RM0fdLed9wk8=;
	b=BEtx/5etcejUtTY5MTUNcRWY/zuaQF4HOE5w+eoWKzFGhMri+rIsxGQ35KauvM5TCdNPVN
	/x/Dl3eKK8stSz3LgVTC9F7xZpXMorpV0A7D8sI9WkcdYFJwoi1nAo0hWB4LJwudLVXZ6c
	gSm1jgBmzRa+kGJBBrtctfPA0ZNOaHRYfcXMqoikgSqNWwHTwzq1EnD6WPTEYKy8Hd14tk
	EgXMwfRxsvSkABA9bKuQovl5JNXQCHTOqyYseDyQ9WGAum5Dc47hfqOBB+lltQuqTzjxrP
	Uts1BaA7t8hXpzD8qenXED+qUsaBUeuzHkWC/3mtvQwnbi+F4xspo7mx9muBXw==
Message-ID: <d6490c5d09075a152909c2be00c2a6f23256c61d.camel@bootlin.com>
Subject: Re: [PATCH v3 6/7] spi: cadence-xspi: Add support for panic writes
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
  Takahiro Kuwano <takahiro.kuwano@infineon.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger	 <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, Kees Cook <kees@kernel.org>, Tony Luck	
 <tony.luck@intel.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
Date: Fri, 16 Oct 2026 10:55:43 +0200
In-Reply-To: <f6008943-c4cb-43ae-a791-31965f374ffd@sirena.org.uk>
References: <20261014154301.157755-1-paul.cercueil@bootlin.com>
	 <20261014154301.157755-7-paul.cercueil@bootlin.com>
	 <f6008943-c4cb-43ae-a791-31965f374ffd@sirena.org.uk>
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

Le jeudi 15 octobre 2026 =C3=A0 13:09 +0100, Mark Brown a =C3=A9crit=C2=A0:
> On Wed, Oct 14, 2026 at 05:43:00PM +0200, Paul Cercueil wrote:
> > From: Tanmay Jagdale <tanmay@marvell.com>
> >=20
> > Advertise support for panic writes. When a memory op is received with
> > the 'panic' flag set, the driver will then work without relying on
> > interrupts and without sleeping.
>=20
> We check device properties in cdns_xspi_supports_op() if the kernel is
> built with ACPI support, that ends up using of_find_property() which
> takes the devtree lock which means there's a possibility that we might
> deadlock (eg, if we took a NMI or the CPU fell over at the wrong
> moment).=C2=A0 This is probably thin enough it's not worth stopping the
> entire series over, it could be fixed incrementally by storing the
> values during probe.

ACK.

I have an extra set of cleanups in my queue for spi-cadence-xspi so I'll ch=
ange
it there.

Cheers,
-Paul
