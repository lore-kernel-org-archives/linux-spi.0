Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6E403AF6
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092623; cv=pass; b=TFfc5z/EoKz8gZaf1MesAB/KUp3iWOxCfT0GcvYa2I7ky6/CReKoRHgv75pG0k9M2AAb5SeyWDXhZGJ6yJkwQdi9gn/RViQ+bf4hX1xhrBJCN3+ttQc0FULmLAZ9oYb5rIpQbOGS11PlyOTEuKitSCMicMmptKz9gs9OtGD1TrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092623; c=relaxed/simple;
	bh=g9gENECLjqpwTfBJQOObPdITxQAcT49QARwQwMzJgqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRDVTvvBxBBctVPbArcFKkf84FgfoAkw4SARiuMkkE2gHqWS1q17qRJvcvAl9Z/hBc8uSKwQfEm9TIhRoxAf6cBw+G0HMzsu3GgBa2Ylb80+xQNimWtiKNhhP+9l3gCRoI3UJE9fHjGGO5tULjX7B/dNji0mBJnhUFQupJcJmWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX/QY0mF; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX/QY0mF"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6608c1a4215so7494051d50.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 04:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781092621; cv=none;
        d=google.com; s=arc-20240605;
        b=T3IhEkwFSvwqKMAYJHO31LOjU6b+aQg86z1+WK+vsKFGkiC/dD7+sNxpUVJpUtfPqu
         SVVFYGlRBnyLH59+OEMhNNiAny1o6EPphZBJCTPGdXZHj5IieqNKiIN2tWrJnZFREHTK
         eIwyvX68jS5Vp6YvgF0RL2cgZsuZhMkqk3n+zmg/H+TirqvKrBdBNYQAdfkZLZoUgnUX
         EozX10KHXczN/Fz/Ezc05TCBa9J775AUl1OOCm/PzySNW18249oTt6aoT4jBn37poH6U
         Ermzd1Iwonk9FM9bFa1PP6EajiUH+5G6Q58j2jPcF+Up4v5ODCU3MUVbV7OeLNDwL96K
         82AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BXH8Qat3tlEctSHgaHbXW/OuqgxXWKUgbkKdMHQiIsc=;
        fh=x1rmYzAnmPZCvwkJhsJbIi1O88gNHhrsVfW1FL/iDFQ=;
        b=bIOq/f9VcCM08d4aJ4nmKfcJPJO6z3wUANdbpswyVCuJQC52r4nEcssHtbJi5//z7C
         l7erYhh4WzWJMum3Jm6kPo66Qxuuh228yXcsX+IHl6L3/SjUNCf3kdC38vHuIl8b3EmD
         XKGZJkHM+95HnBhrLVJjAM/q529eC05Dij5U4px8ovUrwR0BIQiqd5FsTuu5TnhcGlwF
         mBWRIVnzY37AykzqTWAXH1JiqEOKx6jXLroMJeo5gUyCJySuCbjgNKirBi5Bnr4xjWT1
         fh796EdUpxHaP4BBA0hMm1jqZpj7V5sVQaRwa41px6ImQurs+ycDLtMexq3phfnKzYzQ
         8kyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092621; x=1781697421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXH8Qat3tlEctSHgaHbXW/OuqgxXWKUgbkKdMHQiIsc=;
        b=PX/QY0mFn5ZIB5rtK5uS8JXLcUJ1lWpwbxLz+nU6Fcaru3NProQmylQkdujZkVuhFj
         PPoeOk8B+H6iSJwmuq426kOh4LuKcS5Ysom5xleXTrixSxnRQwobQ+RZIV/SWYKGsp7q
         /3OTvg0ImLK6y2GQnMHl3KdCDel3+UMjD6uBd3tP0evMstMOP0NqMb7+Qq33u9nyxXNe
         1r72cONiIvq+yz/tsNbybXg7PeCxzypLzfHW7jFdCFLQFmCSkd3uFuqzO55DkR/3E3Hd
         pGCLvrol+1yy6D9x05W76G+2WFDcjnbSYXItY+LZmLqHN8NU2xTTGlZ3v8PBKuhx5wvr
         VvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092621; x=1781697421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXH8Qat3tlEctSHgaHbXW/OuqgxXWKUgbkKdMHQiIsc=;
        b=qQ0IQyLlQ9LTKBw8ywc7gq/7JO4MGHm3cucI1XOY0g0y9S4OYX59gv2Rl8NrQzQyTD
         f08xJymj00eaDnfPX52mz1p8CZVz+KPnO8YVMLAbE/hytS/dLnsavdDXOJ+SNE4FPvkW
         MwelCwOu9xK83MaG5sFGIieK6UAhbOSMr9bZhFGY/CrzmiMZ8uZ4LmK+1pi2oZOkiw9S
         V20yasbGUM0o9Mg8GylEv9jYKRHDgdpkMKIOVYuEUwAWbeIqGxyPsxgf0nAyGKGAoxf2
         1HE5JwuMcjNaYk+caji0jdJZbyQwuk3NHHZjyOlas7VbiISRyjY27CfsOM+SL9mKdP6O
         CDFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TO4jgKug3RNaOtYnIF2vU7U6jwtaTSvlsWlgWG0qUItaahgjCAMbt49RynwAi806Wltwf5bu0LPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7o+9K3oifss8sEB+rzdLEQMwpgsIrrN1v384xSj6Sc85fnsEe
	IRQL9h/Sn2SbHcyvf5q2OyBjXhBu4GdyvgG5hL3/K19rb35BRepUvcljuDnZgwZS/3pPIM9gUwS
	TE1cOOeaum3+9TLaBxA/mz0rdXdkVV1E=
X-Gm-Gg: Acq92OG+4AffjFyUoq4O6ITE3jEbiXRznRIPQLvpWTVpYiteiLPAQMLgQsoWPbo0DQe
	c0G2ebiNzGa04IGJakqO0HcxM9JPechZXZQbTCD2BNQZ7mw7TMD86dGBiCG7asLHbzZKLixnHfl
	oaWtSSBXpWNuMExFLLapw3HCUjrI//r1ki5xnretyoI8c+5b90bv9lIicl+2xgo2IJnWGp1JDg8
	5RVjmGKAxYlaOFu3l+WNFqxCaj4Y/m3/XrbcBwrmfhP1aElt5Saiqd9iOJqs6GqehjOzh7S8j5R
	QsJPEgGl7+Ip63ettVVxCU4rEO/v/Wo=
X-Received: by 2002:a53:ac87:0:b0:660:6e93:1958 with SMTP id
 956f58d0204a3-6610a1bdbecmr18780971d50.0.1781092620933; Wed, 10 Jun 2026
 04:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609163919.3321228-1-tmaimon77@gmail.com> <20260609163919.3321228-3-tmaimon77@gmail.com>
 <ff53862950a6075c43bb8f1e47c14389d6fc7575.camel@codeconstruct.com.au>
In-Reply-To: <ff53862950a6075c43bb8f1e47c14389d6fc7575.camel@codeconstruct.com.au>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 10 Jun 2026 14:56:50 +0300
X-Gm-Features: AVVi8Ce1xyKX-eTc7JFGyjnn8l2QiZByZq625HpF-ttuxQcOhnM9x3cJlI6wb60
Message-ID: <CAP6Zq1gBcSEQznnQ+awrqacBXjTOWELQsMLDXL1yw8_daCzMOQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: dts: nuvoton: npcm7xx: Drop redundant FIU clock-names
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, 
	yuenn@google.com, benjaminfair@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jun 2026 at 13:49, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Tue, 2026-06-09 at 19:39 +0300, Tomer Maimon wrote:
> > The NPCM7xx FIU controller driver gets its single clock with
> > devm_clk_get_enabled(dev, NULL) and does not perform a named
> > clock lookup. Drop the redundant clock-names properties from the
> > FIU controller nodes so the DTS describes only the resources the
> > driver actually uses.
>
> The devicetree is a description of the hardware in the form documented
> by the bindings. Generally it's not right to discuss Linux drivers
> here: they're only relevant in the context of Linux, but the devicetree
> binding governs devicetrees over multiple projects.
>
> From a quick look it seems that these names are not described in the
> corresponding binding, therefore no drivers should be using them and as
> such they can (and should) be dropped. A driver would only be worth
> mentioning if it did use the undocumented names (as that would be a
> complication).
>
> Can you please rework the description?
do you mean change the description as follows
"
The NPCM7xx FIU controller nodes reference a single clock,
but the FIU binding does not describe their clock-names properties.
Drop the undocumented names so the DTS matches the binding.
"
>
> Andrew
>
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> > index a16450abea0e..83cd10b47273 100644
> > --- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> > +++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
> > @@ -193,7 +193,6 @@ fiu0: spi@fb000000 {
> >                       reg = <0xfb000000 0x1000>;
> >                       reg-names = "control";
> >                       clocks = <&clk NPCM7XX_CLK_SPI0>;
> > -                     clock-names = "clk_spi0";
> >                       status = "disabled";
> >               };
> >
> > @@ -204,7 +203,6 @@ fiu3: spi@c0000000 {
> >                       reg = <0xc0000000 0x1000>;
> >                       reg-names = "control";
> >                       clocks = <&clk NPCM7XX_CLK_SPI3>;
> > -                     clock-names = "clk_spi3";
> >                       pinctrl-names = "default";
> >                       pinctrl-0 = <&spi3_pins>;
> >                       status = "disabled";
> > @@ -217,7 +215,6 @@ fiux: spi@fb001000 {
> >                       reg = <0xfb001000 0x1000>;
> >                       reg-names = "control";
> >                       clocks = <&clk NPCM7XX_CLK_SPIX>;
> > -                     clock-names = "clk_spix";
> >                       status = "disabled";
> >               };
> >

Thanks,

Tomer
