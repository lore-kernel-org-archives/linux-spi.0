Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3EC384228
	for <linux-spi@vger.kernel.org>; Tue,  1 Sep 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252772; cv=none; b=NeVZmi0Zx4rEkRAqrz+lroq08cNe4+QnN9xsRfKWY39SpPoehrxDIvNXgS6UWA5MQxV3HkIfgeV9Xyx5qtj9xrg0IsPBxtxccNduizGcDyNl2xbTaj3PUK75P1domk2qfiv69ui7ZjmHsxty2Mqkq7xJLEm2zPsq6bW6+crkJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252772; c=relaxed/simple;
	bh=Ely+8qEWUZ8LAcQDW+oMioD/wdydds9TQPREi9VZaz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjksM4GmXPFHu2x4AktDM+KbU4Sm/n92HdQH0DiSLuqReDJ2XVtoQzCYJYpjR+B8gimKP8plufSUkrTqkri5z1dB0kXoCWuSdVt8UWR2kLDZlwJIxmFbmKoFZOIl1xwQ4v1MoG413P0Wfbi5VTJOjCYPua/uePQAmUTOmN8Q7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Fnc1sKtM; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Fnc1sKtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1788252768; x=1788511968;
	bh=Ely+8qEWUZ8LAcQDW+oMioD/wdydds9TQPREi9VZaz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Fnc1sKtMo7rwkEJsxA09F2ooKpAALHmiVy9avBVWXf0WeScwthNmBdieFQla+Hrb5
	 jDr7TIOs+kmn1iwca0yp4Et6FBgvrKvvN100t4Ha2zOYp8VHKDO9xuKGL7H3fEB0HZ
	 tQbXUV2jtMwOTyUT5w2CgZbyjl7JwHqwPlVP81vO153lG7XB796g56XjNY4CcHDjFn
	 bqQeLp5Cy8sEyQ/55EdLcCxJgLWEhQT4Fw9ysIHGo+Ek38cjiu68iH/wGkKDnM0+iW
	 A0+lkJJM/oglgDndwbA3MmmrNBwtk0lXsalymPtUcoo7pXwwDGpm/9v5H9rd08QIY+
	 ugpNXNLBwcRDg==
Date: Tue, 01 Sep 2026 08:52:43 +0000
To: Michael Walle <mwalle@kernel.org>
From: Tobias Jakobsen <tjakobsen84@protonmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Takahiro Kuwano <takahiro.kuwano@infineon.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: allow the platform to supply write protection state
Message-ID: <NApbcrAD9xywxhssnr1w9hLntPOFyzs9BcW69a4ItinN0dKRCKsiEQ03xpTR0vo5aty4BDD7JjzUE8NH1OImzxL-OOf9GiHDe27_aWWzDBA=@protonmail.com>
In-Reply-To: <DL3UHUKN6Q0Y.1HN2PJA78WK3M@kernel.org>
References: <20260831-spi-nor-platform-lock-v2-0-6cc75b909241@protonmail.com> <20260831-spi-nor-platform-lock-v2-1-6cc75b909241@protonmail.com> <DL34U80UW849.3OYQBBTN7GRJ8@kernel.org> <bwwdwkT-nZT9pant-Nb_0PF8R531C5F2gDKrs-rZvW7MG1LHPf-MGmBH5YOSWTBnvZkRl4cPfXSzukcHaxoUZE1Ow0zvIfFCaOqYESzLjZE=@protonmail.com> <DL3UHUKN6Q0Y.1HN2PJA78WK3M@kernel.org>
Feedback-ID: 214933398:user:proton
X-Pm-Message-ID: bbd1bcf378a5854f4d0c441df69344155bc5f42e
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, 1 September 2026 at 10:43, Michael Walle <mwalle@kernel.org> wr=
ote:

> This feels like I'm talking with an AI agent. Honestly, this is
> rather discouraging.
>=20
> So my short answer: I don't want to clutter the code just for some
> weird behavior and my point stands: whats the use, if it's not
> possible to unprotect that region. The intel-spi controller is
> rather restrictive anyway.

Already disclosed LLM was used in translating and research/execution. But p=
oint taken. I will bow out.
I never intended to write a patch but was asked.
My intention was to merely report a bug.

