Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF5403AEE
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093228; cv=pass; b=e3p01XTjGQ8NERq3dHNHu/eSfsVzqypRiNmrf8zmX0tpEIjjslmavk2ptMjLsD6xuhHHGtR0imvGU/tDpkej5vXL0rgZaLV0joLwqDj8S2B1waj5gr22sjrmneFhbos7zVl4C7bKqkcHkuoAHPxN3iVdaPmedAcg933gt+CSIQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093228; c=relaxed/simple;
	bh=rPBVbarQJunKddhuJZ36mYpeExA3zm9sIRg7kXIiufE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qY8XVQqjMi9b7KTjvVhlFsctxkCBEl1cPHievq8b+Dia/PihAjd9X9JUD8AOf90AG1yXp2HwcEqIM0pk6gz3GfzPHZ/Ry85jWmi2kX23zic7akH7yemBuanFSsffXecTgmihGkHTL12kHr5s2oBEV/h0Vqt8u95zEgFGt2m46uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp2UbMvE; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp2UbMvE"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6605469c263so768172d50.2
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781093226; cv=none;
        d=google.com; s=arc-20240605;
        b=eMMoiS8DaCi5TIDcm/OWzhIIlvC+PYoBSgACVcO/jQebaDyT0K3VOBb1iIfAjpsrIz
         0iT48XouTip2zCyBVejQUBb52MstA7tjZ61kvDmPtGWoIcSWWJ6h3383RENuerC9RfPM
         wTLiFFzB36/XNXjL11p+5Hxuf1Qh0CKsQgcb+a/huhq003r3i7T2CcdQOFDSKOTkzQn9
         wSrzn8aEHGcgQqgQu1YN6xo/xqR3THWkOX6HdIP5Qcc2LHmNcTwzrqECNXMzqD1aMm4J
         fWZcPACv4ICwHJ/h/ih569D2qrrZN2mOpqtUZrLFdQXmJOc59PcBJKFeMi18ivdAXqSc
         xEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rPBVbarQJunKddhuJZ36mYpeExA3zm9sIRg7kXIiufE=;
        fh=Lb3TB91kddmpe86gUuiDduDzvS2Hfr8fGLVXwIuczOw=;
        b=GqMQkddOacrMDIH3JAZhfRlAz9hDRtCAydp/z1vjJnB+3Q6zJnAfxT3Lik9n0lndDn
         VUm1Zth1pSLkUrRlLrgtFoKFrcSUjkkterFSqY+5tiIQx23pQVZ8oOUS9SLDJvHPAwGj
         Ll89OF+aF07QSGizf69sFbDir0aRkg2URTW4zDhakum1xYaatoNxfaWVuZcubLSpCz5z
         rIIamYr8ot6HUSGv3J440N3Y7hmYOFKD0BxEzbflgt7MHOanhEAASF5p9+JAegGq3Qju
         B35wfcNaLTJL4Q4Ky0JBJ4bs2PYZQ64IuxoQeAQL8jww3OheZvIxgLFiaaFg2B4Txr5X
         PpoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093226; x=1781698026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rPBVbarQJunKddhuJZ36mYpeExA3zm9sIRg7kXIiufE=;
        b=Sp2UbMvEwjbwDOyXCQgs+QC1ubM+FItEiywFLw6LhQ8aitjrJvWCAdWlOaOBtSnp34
         p8o3l+Q0zSXjP4zsmpOeh8yBltFJusF87r6aP2/M7NpXFMuwH5ZH0PJ5EhGXKU7n4jnw
         C45g8cKfy6Gza32RrLXDXDfFqedaPykhS67MJ3KGDR78Az/NSS8rzj/eSXARKFkPD8Ul
         80FZjgmX4G/VmfYcoRgyjtaMRbMtbiuwpQ9DWtdV2T5sUt1TsAuZ1Sd0i2N9dqThjkLJ
         bGUJipQC8BpVWCh034SX0aesOCJoxwbf1u6CDQGEtn20ES6ytNVdMkEmlt9kKixmeNQE
         XYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093226; x=1781698026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPBVbarQJunKddhuJZ36mYpeExA3zm9sIRg7kXIiufE=;
        b=QaXD3RfnrZHm+xbBpeDpJHOHiEjtpca2tyEtnp9tG3OXbtBi7GnfzAxbmEUYEZ6/le
         Sx3vTCjZbfyqTJMDUedLbZJhNJjertUBrK4isBS6+s+bCnyJW2q5yPvkhJcDsJ77KATG
         QskzSb6yXWNmgcSTvIKInL4nl8K1wlTiJHC9pCJwnKBDJtlrEDdtqS+G3yDXh6uSHIrp
         +QsXNV4g38pmbg+uyyvh532CLx4c8VIhmGUZVBc5grMHeC4wfqPzn3nOYHdmFfIqVLyx
         /k4xhq73AT55FgQgK+ni+D8l+1pjh/+zyFGK+ZGKsW9W9/fMxGPwn2Z05udJJi3Bj6OR
         +Otg==
X-Forwarded-Encrypted: i=1; AFNElJ9xAC+l7AVu7HHBs6w2s9G/eHsP56O1VhZtu10Mn4SrDxKeyHXJa7MkWhbSrf77zHJfTJt9Q7YfjTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7RdfMRFLBMAvzDQk54NwSHav3Wy37yAYWGESndre8LMyaBB4F
	eRF4bEFKJIz2yzfcJ4MYzxXWjXygmEuVZl8orbgIZbf0OK5veEP8Lz1RQaIR7FA184BVq4i+2Kk
	hdYECIjLyELnf3Lc9lSD9jErkcAS8Egc=
X-Gm-Gg: Acq92OEoCicwqtmlEEVM8O2ij8YBBJZ8j3BzfHDyd85zi6mHqVvFRXTrwbfMW8q+Rs5
	doF0ZR104+aH3YyRmexTXAYPOtIudasBQC8WY0EAeW1udHopYCnC9PJLeMqhkabMReOdowo4gC5
	+Ej3/EQEmfXVgzCUjnU5SJDHa94hyC36enkwLr5gU+cGOgh3Vkup1BZ3z2C3df7Zb5Oz6bZ8Pzt
	/4PmCGMpngHF/9AZhjB+XJCJSOvXkSpp7iZK5iW1VEjWOfjV2u+OHKr+EzA2+/Md/H1JOqzqWSm
	zvQgR3uzGoTzgfFb0Efv
X-Received: by 2002:a05:690e:134d:b0:660:433f:b0e6 with SMTP id
 956f58d0204a3-66108356dc3mr21625926d50.26.1781093226210; Wed, 10 Jun 2026
 05:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609163919.3321228-1-tmaimon77@gmail.com> <20260609163919.3321228-3-tmaimon77@gmail.com>
 <ff53862950a6075c43bb8f1e47c14389d6fc7575.camel@codeconstruct.com.au>
 <CAP6Zq1gBcSEQznnQ+awrqacBXjTOWELQsMLDXL1yw8_daCzMOQ@mail.gmail.com> <8a059e3a4a3338bc03829071a720012bd426bf6d.camel@codeconstruct.com.au>
In-Reply-To: <8a059e3a4a3338bc03829071a720012bd426bf6d.camel@codeconstruct.com.au>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 10 Jun 2026 15:06:54 +0300
X-Gm-Features: AVVi8CcbfduWf3TegsXkab0KWg7M5FV7yhmspd3KQakMOXk24-UcA1-8_To79Tw
Message-ID: <CAP6Zq1ic6nvk4JFTf1Re1ySqsYmWdP0ZcGOuUWccS0mfY31Mtg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: dts: nuvoton: npcm7xx: Drop redundant FIU clock-names
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, 
	yuenn@google.com, benjaminfair@google.com
Content-Type: text/plain; charset="UTF-8"

will send V5 soon with message modification

On Wed, 10 Jun 2026 at 14:58, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Wed, 2026-06-10 at 14:56 +0300, Tomer Maimon wrote:
> > On Wed, 10 Jun 2026 at 13:49, Andrew Jeffery
> > <andrew@codeconstruct.com.au> wrote:
> > >
> > > On Tue, 2026-06-09 at 19:39 +0300, Tomer Maimon wrote:
> > > > The NPCM7xx FIU controller driver gets its single clock with
> > > > devm_clk_get_enabled(dev, NULL) and does not perform a named
> > > > clock lookup. Drop the redundant clock-names properties from the
> > > > FIU controller nodes so the DTS describes only the resources the
> > > > driver actually uses.
> > >
> > > The devicetree is a description of the hardware in the form documented
> > > by the bindings. Generally it's not right to discuss Linux drivers
> > > here: they're only relevant in the context of Linux, but the devicetree
> > > binding governs devicetrees over multiple projects.
> > >
> > > From a quick look it seems that these names are not described in the
> > > corresponding binding, therefore no drivers should be using them and as
> > > such they can (and should) be dropped. A driver would only be worth
> > > mentioning if it did use the undocumented names (as that would be a
> > > complication).
> > >
> > > Can you please rework the description?
> > do you mean change the description as follows
> > "
> > The NPCM7xx FIU controller nodes reference a single clock,
> > but the FIU binding does not describe their clock-names properties.
> > Drop the undocumented names so the DTS matches the binding.
> > "
>
> That sounds reasonable to me.
>
> Thanks,
>
> Andrew
