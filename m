Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195967;
	b=t8272sa+RTTceViPmv8ys3fZ7o61S7pIUht+r+xx+N63kVsTavxGBIh4x9O1Dh0HFM+x
	 Xqk5pruqNhty+wQWE+BF00CUZLjjBygDZJiBiNU6+OxieIsnYFBmgjvtUIiKR+h+9g2g0
	 jYJTp6WrOYsRv0QsDIC6omdYbip6R/ywcYq1oun+787e/TyKlNBnkkE8TSEklU6zCQiNg
	 BXZKr6t1ZA3tbWAvsZUWAM9W8zcbvuLzf9NSeh1JDe3/ltTGYjPDy10SvaTfubRMrZtov
	 alDpQ09PLKstOUseUjybnO/jg6kgOKI4rnFNZfGYMYkaqiwacxtbhVd6HRPg60aRUlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195967;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=BB+XzUMxzQ0SnhM/sFJFKaRajnW0lj1598vyXvwnOP4=;
	b=AgsJ64iUDDBs3UJAaI0SZeusJl6N/ZyCktC+P5GDohaMCOtPf76MOXpnZf1GQbCnqscT
	 rDVXClcSuYXEQ4gTr4wG1YXebgQxJIJw7Oc2BXWZfvq2rQBCTOm/hjR0w+hqTYoweRbim
	 FQsWJgtEBmVe+h8o65rIHmBgQ6hEZJvdvic55elsUkV8p8OgNJMI1bHJJ47IyrH/vDjai
	 RebHdTyTcylhvqQBLNQymDwG2DQeDUiV1LLKVnhiiDDXoO2Nb9scmcJl2tLCh3XF/RWS2
	 EE2/8JK3TQocCqP+IUiFtp7miRlGJxSEVJVeVxEz3JMucrg1tm2XTS6Pd63dJT58mMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=A5RsB8tT;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B94C606A333
	for <linux-spi@vger.kernel.org>; Wed, 28 Oct 2026 13:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B94C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=A5RsB8tT
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5C9391A137B;
	Wed, 28 Oct 2026 13:59:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 27ADC60769;
	Wed, 28 Oct 2026 13:59:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 900DD10328A20;
	Wed, 28 Oct 2026 14:59:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793195954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BB+XzUMxzQ0SnhM/sFJFKaRajnW0lj1598vyXvwnOP4=;
	b=A5RsB8tTyNgDLEDTiX203yTl+5N75gBBEYltuIcZa5k3tUz3xYuCJBkzGB/vp9WmGmJ9kg
	BWKiFART8WIKzuX1GvYFAoAu5xFeaypJT8Ur/GACFsjZheLVtj2z3z2vfYTyKTzvvEWEIC
	xU3/u1GeFy6jZh2BpzN8JkuAgTSOwbyYmj/1DvXXnh3466E25xLU5Fewj9jIde50Vu7q7D
	cfZvxFQg6DiMzi9QRVPYtg/YVk7n3CxRKH9bdaqiF9gSbA89h8+6SbikyTOhqbZG1VWylo
	9O1vnehH2gpXqormk2L9dcMw+oHUsjpvytees8+85DxGYqHT+jxszXiRftV6Jg==
Message-ID: <7f27a8b7624ddbd0f7d32c27fe3f58df48a08c0d.camel@bootlin.com>
Subject: Re: [PATCH v4 0/7] spi: Add support for panic mem writes
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
  Takahiro Kuwano <takahiro.kuwano@infineon.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger	 <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Kees Cook	 <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G . Piccoli"	 <gpiccoli@igalia.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>
Date: Wed, 28 Oct 2026 14:59:03 +0100
In-Reply-To: <8c8cf14d-954f-4b33-a0e7-8524b1596845@sirena.org.uk>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
	 <fdc79c99e3045635841f68c89fec3b9d9e2f7233.camel@bootlin.com>
	 <8979e4ad-5209-4fb0-bd3e-95919849d2fa@sirena.org.uk>
	 <cf96edf1cba37b775817d4df5f759b10e71c73da.camel@bootlin.com>
	 <8c8cf14d-954f-4b33-a0e7-8524b1596845@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Le mercredi 28 octobre 2026 =C3=A0 13:25 +0000, Mark Brown a =C3=A9crit=C2=
=A0:
> On Wed, Oct 28, 2026 at 02:15:00PM +0100, Paul Cercueil wrote:
> > Le mercredi 28 octobre 2026 =C3=A0 12:59 +0000, Mark Brown a =C3=A9crit=
=C2=A0:
> > > On Wed, Oct 28, 2026 at 11:42:33AM +0100, Paul Cercueil wrote:
>=20
> > > > @Mark, do you want me to wait for -rc1 to send it to you?
>=20
> > > Please resend any new feature work after -rc1.=C2=A0 Please also do n=
ot
> > > misspell my name.
>=20
> > Your name is not Mark? Or where did I misspell it?
>=20
> You added a random @ to it.

I do that when addressing people in emails, I thought it was universally
understood. I'll refrain from doing that from now on.

Cheers,
-Paul
