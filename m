Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902153CF058
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508350; cv=none; b=EuuFxgDSCQ9uFJVuGkQrBoI8TBKZKMCgf898FUX/EI2284vZ3KJ/EUnc1XJSSxh/UeSGSx0tyXnCbgGCYQMt47rg2hy01Kht/6ZGi7Urcpe39nj0l2ndcAv0cdlxUdOsSbXPIblL27760YT/jg0IbhuqcBgw9/rG4m37GCFEnts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508350; c=relaxed/simple;
	bh=0r9RU/RX9+0fMVub0FLUJ/c2kPAlu3ZbUrrVbFmEVtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7tmJK+taswiTM6GmzKcxIbrTSK8MNXcrW9q+40LwKh7LixKiVlJfSOMEREuEraaZ2HGKy2ZJaWYVSnaf2Y6KHnJnAe3Pa+zup5UIDNOiF74eZauPUcfS4oksrR/U8ivJJ3u1PSzA13ouzvop3IqUzL3779ZN5WgJ5XMRScenUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7PPd22u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7PPd22u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368101F0089C
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780508348;
	bh=0r9RU/RX9+0fMVub0FLUJ/c2kPAlu3ZbUrrVbFmEVtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S7PPd22usbLXBVl9jDTQ059NO0oHQofIn+K1aPjBCyT9LpfNGMp/gblzj/99kb5ds
	 RyNtsNxtIgMwXQdh6bR97DKg8Q+1HC8AYAr/dsv7nmn+suJ55hkk65ZWtpjTNSQMuO
	 rayazDKDkrtCL6PHfdoVlyyENmBEbbXtiEJvMfhZNCYuS5oczkvvN9xKXGuQ4/kjjA
	 VlDnlQVuFqbRc8gp2L8xY9LJgUxbeZOAXDpT8XJE7as1D698ZXR17VLlLdCanbKOHu
	 kzBaricDEcOesqgL4wD2wQysLVaeY3GvemtLOGdldguYSM5wAld/v5ukbvE2l/3fWX
	 uOOAMVK4/1SrQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so7825588a12.1
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 10:39:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ww8iumkzLwwUub3g/B4hPTE5Wn57sC3wTLr9AcJT0++DyL5MW8T6gRoL2T0bBbUe8H6u0n/L0gag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQx6Uo0FqHfmTTRK1I3Jzs4gar5oMpFKprUoRSvG7XPcPMBIc
	yUAtr1Wc2avS/CEXaTjsULgBzP8RonG6qRaD8hm2NiCNLeDtkQkbs/bvvzxXtRrn/Pe2J/qjF+6
	HfetE2H2+O5VUQadf85Wh/FKlWOUU1A==
X-Received: by 2002:a05:6402:2711:b0:68a:c8c8:bf70 with SMTP id
 4fb4d7f45d1cf-68e72e11b8fmr2505455a12.26.1780508346916; Wed, 03 Jun 2026
 10:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527175527.2247679-1-s-k6@ti.com> <20260527175527.2247679-3-s-k6@ti.com>
 <20260602164945.GA475455-robh@kernel.org> <87zf1by5oc.fsf@bootlin.com>
In-Reply-To: <87zf1by5oc.fsf@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Jun 2026 12:38:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJwxgcFOB=kE7bVQYDn740-w4RppMF5W-3Ne9=9qV9OrQ@mail.gmail.com>
X-Gm-Features: AVHnY4Kf2I230VuAd1puqsHwde0Bn2izk7qL8QsSDkUDH3frwdNb_AgO2H9KCZw
Message-ID: <CAL_JsqJwxgcFOB=kE7bVQYDn740-w4RppMF5W-3Ne9=9qV9OrQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning
 pattern partition property
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Santhosh Kumar K <s-k6@ti.com>, broonie@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, richard@nod.at, vigneshr@ti.com, pratyush@kernel.org, 
	mwalle@kernel.org, takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com, 
	a-dutta@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:01=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hello,
>
> On 02/06/2026 at 11:49:45 -05, Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, May 27, 2026 at 11:25:16PM +0530, Santhosh Kumar K wrote:
> >> PHY tuning requires a known data pattern to be readable from flash.
> >> When no partition is explicitly identified, the controller must search
> >> all available partitions to locate the pattern by label, which adds
> >> overhead and relies on label naming conventions outside the
> >> controller's control.
> >
> > I agree 'label' is not the best choice. Software should not care what
> > 'label' contains. It should really be 'compatible' instead.
>
> But compatible does not seem relevant in this case, right? We are just
> flagging the location of "some useful data for the controller".

compatible is what tells us what a region contains and how to use it.
That seems exactly what we need to define here.

> >> Add cdns,phy-pattern-partition, a phandle property that allows the DT
> >> author to directly reference the flash partition holding the PHY tunin=
g
> >> pattern. The controller uses this partition during calibration, avoidi=
ng
> >> the partition search entirely.
> >
> > Do you have any data that this approach being "direct" is faster? In
> > fact, it might be worse. Instead of searching just the limited number o=
f
> > partition subnodes, you now search the entire tree for a matching
> > phandle value. We do have phandle caching, so that might save you
> > here.
>
> True, but besides performance considerations, I personally do not find
> elegant using a partition name/label, but maybe that's just personal
> taste :-)

I agree. That's true for all the partition nodes with only node name
or label to go on. We should fix that at the source. However, you
already have to support using label, so anything else is supporting a
2nd way whether it is compatible or a phandle property. Is it really
worth it here?

Rob
