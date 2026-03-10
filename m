Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599534B1AD
	for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172203; cv=none; b=lUV2v2MwfQwgRM8AkE2qT333AXF++a4GIqgkVGvIkjXYt+gr4TcaCZPQA8EyMTKHbpto5cyARdcgzDLISwm4/wNo6A4Y14t2uL+lfzL/Mt2neUfCZhyEBxm4jfMmEolb1D6eqJdVxt2jf29DlMm4fTiTk0gus/gqJ0hC1FC0/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172203; c=relaxed/simple;
	bh=61cOWIluLg/ri0kKZLFIWkcAPP0PDIF1kYNAbzD/75Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIg1B33xyci6cUeLxUGGY0v/mpBD8rqYRQmfZM0W9LzT9+FFRsaTOvceashKhQkOrVfxef1CozZV/3T+iQOgG83KYCi7/FahHi9RQXfuyG7v+uXbyVj1oVlp/X2gmjnZO6PWG9XPiV3XOABmMzcVjGmRZRER5wNtw1M7qzrekto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUVPnUpu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUVPnUpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC239C2BCB2
	for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 19:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773172202;
	bh=61cOWIluLg/ri0kKZLFIWkcAPP0PDIF1kYNAbzD/75Y=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=aUVPnUpuvlUwp4RHysc462fQn4me0YVYvbhbzJufggMjzp05DwUo5Qkp7Wnx+cQvK
	 ZhoJcPCgtP3AtMoj8k9wCEHYI9AeYbRnakHmhpYubM6zpJ03fP+iCtIlZciP7P597P
	 3dkzQ01jsxTBzXl1lVB2umzWj51J1FlWQ0p2kNsRmgyo8p6i4NPV6RZ2GIqTWB/bJQ
	 hsoc5MXiNbZzGTnA+vlUNX9cgWmcAwFhje3e+eUbWYR1iNzWmm6qrTRplr/Sa/m6NX
	 ssO2aSr4IGGkqfc7pvg89RUi6tqQoKAQake9wsSg4Mk6MaxUBAXRorURuIOkZRIKk/
	 Iq+HqbfTdXs5Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a2f196cbaso59341231fa.1
        for <linux-spi@vger.kernel.org>; Tue, 10 Mar 2026 12:50:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJayyVLCWIANy9h4DAR7Micnommax2mJT1Ww44zz6siCQmoIw9QEJ1sccZytWKFTPOKHNnHIBE/7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJg5SCM2EKDSsb1XmLW4GDnXTijUHBXC/6JTzv+Slv76BEv3o
	vP8ItmUiuDxsWy5FIy+Gox0Q0NlYSpnkmCHLhlroBBWmtuos9goCTsm1EpQ7SyLZBrNQQmUJa4m
	6d1GJz0US51k8w9NQOwR3woFqkfVnaEg=
X-Received: by 2002:a2e:a54e:0:b0:38a:5402:a9e9 with SMTP id
 38308e7fff4ca-38a67dc914bmr84071fa.5.1773172201072; Tue, 10 Mar 2026 12:50:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302153559.3199783-1-wens@kernel.org> <177317166704.379398.1719490251066452420.b4-ty@kernel.org>
 <f3ed7b81-4e43-4baa-8a56-b18fa7f56436@sirena.org.uk> <CAGb2v65TyEkirWpfynKnSCiuOAyTW1FZQyXncnTFEHGGOQr_Fw@mail.gmail.com>
 <33204e68-5e65-4486-a473-79d09def88a8@sirena.org.uk>
In-Reply-To: <33204e68-5e65-4486-a473-79d09def88a8@sirena.org.uk>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 11 Mar 2026 03:49:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v67N3svujuzPZ7uwv7kYbiah2iJFW3jZS2kmMmRvV92L9w@mail.gmail.com>
X-Gm-Features: AaiRm53gGy9JdNfY71v2inWqDsCjb0-wpAlLC2cqpxhEcDisNL_wKASMji7aaAA
Message-ID: <CAGb2v67N3svujuzPZ7uwv7kYbiah2iJFW3jZS2kmMmRvV92L9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
To: Mark Brown <broonie@kernel.org>
Cc: Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 3:48=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Mar 11, 2026 at 03:44:01AM +0800, Chen-Yu Tsai wrote:
> > On Wed, Mar 11, 2026 at 3:42=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Wed, Mar 11, 2026 at 03:41:07AM +0800, Chen-Yu Tsai wrote:
>
> > > > [1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newe=
r SoCs
> > > >       commit: e2f93f45d38f7b6dacb44203cfc7bb5d7e287b8e
>
> > > I'd have expected to take this one?
>
> > Normally you merge patches pretty quickly, so I thought maybe you weren=
't
> > going to take this one.
>
> I tend to leave a week or two if I think it's likely someone's going to
> review.
>
> > I can back it out if you want to take it through the SPI tree.
>
> Probably safer for conflicts.

Now backed out.
