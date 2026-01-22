Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11763815FD
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095959; cv=none; b=CzkKM1B4aCyGfeZQ1LW1OqUV9cw6EaC3CVbuSxcm766JDxeeVAfXESEqQMLqgJfIJkRmGkzem16ooPTVGEWWJaQhUZ1pur+hv4YfF7Y3IZss7FcG2PgXCVY2osI3q0AtzyQA1GiyWP2phYJCeXehpS1ajV65g2fRUxkZBvZi+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095959; c=relaxed/simple;
	bh=7lXXnHEPuM0BuYoFwX3ssIJy7hefUBgpSQE/mma1aoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiBxrxsrxRVkWh9UTBztHV3UsCnu+zfiyRyPqTSPi8fpb//NKIKQj1SGoQ+cBF1GbysB4fqE1P0TMWNZ1xP9S5ogOzpoZOX6ZfrephPHS6/wszT/G4NeDuZkS01S8lxCz/pIz1X0KakzLQ2I8FbCzqMVH8riK3jprAxZKee+Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITL7sEGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITL7sEGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A35C19422
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769095959;
	bh=7lXXnHEPuM0BuYoFwX3ssIJy7hefUBgpSQE/mma1aoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ITL7sEGKNLQUWPFxXv8PORXy68D6bLAay9H2kAyWFO1KU6Q68c2O2YhJHcDDt4f1n
	 z4CcpjUvU3yjXlCK8aL+1kTiZ4b+Xb5YIRqYBN5koRGstIEv3Ob78jWOD/dXanpeJm
	 83b53o1Djq0Os87URziP43dF5JStzGegiNubjeh5Ogq4NuSzxheCKCoUV1ELqwZLEg
	 JyAmrQd6aLJ/rJiyO0cmRMIS9iHDVv/FkhMzokf7xteLb0IXZ9VNt6FNsSNeQS3UuY
	 2XUBi14DNaP/SyW9HPzzvmzuGKvguJsR99cW6Jntovf+ltiGaOtm/ilKWJSamNcWJ+
	 34u7SLbhO8uWg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b883c8dfb00so93899366b.1
        for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 07:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBMw/CDuCkXLlyZ74YvIm7ONxeuD0HywrDohJ1FMWLc6P+mFbnO+dgFoplPSqfT2GlK1AwbXULlTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGK/rc9YOOeRAQLPvpgLABUkIUcGW+hDtfEJokZ+yKYT3eLFlQ
	yWwW9wFijCbGUvpczucz4PAqLrNL5Qej77Ot+J/6+sz/srFK6k+mRTHn9KrLSRDORlIzBjm2DuN
	xNuYJ8bV6EK4VO6jgbRHLn5V+HRW4OA==
X-Received: by 2002:a17:907:3cc8:b0:b87:79a6:4cc1 with SMTP id
 a640c23a62f3a-b8800260533mr727286466b.14.1769095957863; Thu, 22 Jan 2026
 07:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
 <20260121-schneider-6-19-rc1-qspi-v3-3-43e70fab4444@bootlin.com>
 <20260121230759.GA223990-robh@kernel.org> <874iodpven.fsf@bootlin.com>
In-Reply-To: <874iodpven.fsf@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 22 Jan 2026 09:32:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLWZWa=yAx0sHQckbGdqAwos3xdubnnuKMoZLWTXpv6KQ@mail.gmail.com>
X-Gm-Features: AZwV_QjqghEOf5Kx-CDBZNhnqQswnDxt-gZfUMoJqiAGUgnCeTOEtx6EblhCCIs
Message-ID: <CAL_JsqLWZWa=yAx0sHQckbGdqAwos3xdubnnuKMoZLWTXpv6KQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] spi: dt-bindings: cdns,qspi-nor: Add examples
 for testing the specific cases
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Santhosh Kumar K <s-k6@ti.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:35=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Rob,
>
> On 21/01/2026 at 17:07:59 -06, Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, Jan 21, 2026 at 06:04:59PM +0100, Miquel Raynal (Schneider Elec=
tric) wrote:
> >> It is very painful to modify this file because the core IP described i=
s
> >> so common, it has been implemented in many SoCs from different
> >> architectures. Both `dtbs_check` and `dt_binding_check` are rather lon=
g
> >> commands, even when restricted to a single schema files, and letting
> >> this file evolve without risking to break other DTSs is painful, becau=
se
> >> there are arm, arm64 and riscv platforms impacted and no way to check
> >> all of them at the same time.
> >
> > OTOH, examples aren't meant to be exhaustive test cases of all
> > possibilities. If it was me, I'd actually just get rid of all the
> > examples. They are generally just a copy from some .dts we already
> > have.
>
> I will align with this idea the day `make dtbs_check` (or something
> similarly simple) is exhaustive and cross platform :-)

Note that you should be able to build DTBs without $ARCH
cross-compiler. So it's less trouble than building kernels for each
arch.

> Maybe cdns,qspi-nor is an exception, but it impacts different
> architectures, which means the output of `make dtbs_check` is
> meaningless because it only covers a subset of the possible cases. Hence
> my attempt to gather all specific cases in the bindings, so I could run
> all the meaningful checks I wanted more easily.

I used to run this on all patches, but with existing warnings it was
too noisy. Once we get arm64 warning free, I can look at doing that
again. We're at about 300 unique warnings left and over half of those
are 3 platform families.

> I think this patch has its usefulness, but I don't mind dropping it.

I'm okay with adding the first example.

> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
> >> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> >> +    spi@13010000 {
> >> +        compatible =3D "starfive,jh7110-qspi", "cdns,qspi-nor";
> >> +        reg =3D <0x13010000 0x10000>, <0x21000000 0x400000>;
> >> +        interrupts =3D <25>;
> >> +        clocks =3D <&syscrg JH7110_SYSCLK_QSPI_REF>, <&syscrg JH7110_=
SYSCLK_QSPI_AHB>,
> >> +                 <&syscrg JH7110_SYSCLK_QSPI_APB>;
> >> +        clock-names =3D "ref", "ahb", "apb";
> >> +        resets =3D <&syscrg JH7110_SYSRST_QSPI_APB>, <&syscrg JH7110_=
SYSRST_QSPI_AHB>,
> >> +                 <&syscrg JH7110_SYSRST_QSPI_REF>;
> >> +        reset-names =3D "qspi", "qspi-ocp", "rstc_ref";
> >> +        #address-cells =3D <1>;
> >> +        #size-cells =3D <0>;
> >> +        cdns,fifo-depth =3D <256>;
> >> +        cdns,fifo-width =3D <4>;
> >> +        cdns,trigger-address =3D <0x0>;
> >> +    };
> >> +
> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +    spi@2400 {
> >> +        compatible =3D "amd,pensando-elba-qspi", "cdns,qspi-nor";
> >> +        reg =3D <0x2400 0x400>, <0x7fff0000 0x1000>;
> >> +        interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> >> +        clocks =3D <&flash_clk>;
> >> +        #address-cells =3D <1>;
> >> +        #size-cells =3D <0>;
> >> +        cdns,fifo-depth =3D <1024>;
> >> +        cdns,fifo-width =3D <4>;
> >> +        cdns,trigger-address =3D <0x7fff0000>;
> >
> > This one really just looks like a subset of the others.
>
> The fifo-depth possibilities are extended just for this
> compatible. Basically I captured in the examples every specific case
> covered with an 'if' schema.

I get that, but with that argument we should have an example for every
if schema.

Rob
