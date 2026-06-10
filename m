Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B913FCB3A;
	Wed, 10 Jun 2026 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092708; cv=none; b=urlAAbJzwlI+m6zQGJRwB/hhy1Uj1AKCn/OdvtiQj/6yN++meDruehNWdVOEFGYO0ALYpfpN2qv9sfp/8ZFABpT+up4/TirfLXOxX55oKdkKyoa/U0MNBaHsfvqK3GgER+M9sYkkY2jZ0x06fD9h/mpfxHMmx68TBcFVk/G4FHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092708; c=relaxed/simple;
	bh=S7/vvy/4SDu/u0Hw6EJPP8AspWB98Zz5HHFD3gc8zf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9zYBpd3oGrQl7pymYrtYCuqaQop2dV2C6oUN4PjHh7ZIBetx2j3pAaQvW5DkHD7TVvfiO8ufBYVKE4Jgt82r2Sfcroh+sObKcjxvn2PLPuj+gfBLypwI4Fay0ba+N6zr7+DIollr317cX9yMHl7I8hQxfy5axJxMCM6cOnVa00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=e/3ICdLe; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="e/3ICdLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781092704;
	bh=S7/vvy/4SDu/u0Hw6EJPP8AspWB98Zz5HHFD3gc8zf0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e/3ICdLeOHIDOEMN/JOXYUR636UKcezjTMeMox4zGOTLMoWHGatQneK5JlZbIrKz6
	 rKaLakHtUlo+L4k6SkrdDanrkIfLObnD5lxGW+pIuMDnltvxJ0iLr70R7jELHBCUx/
	 nBuGSDWOqUuy9K3qLSu4CUQbRsIhU68DkHqyXsIhWAbdMzksJ9p/9Yehylw6MVqyyP
	 ZSmF9FjgTdck7O5r+OfEOZRTeJN45cVDkE1ZIr4kamRAi0t+4GKZ0U8/HCoY/yqhvn
	 wk49iYyAy0oRnWGDLIhoG2us8/I2FWoIL7HIVD8xmdJR9ayDla83lkoCwl/azCP5SN
	 Gf7AJnKBL1N5w==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3E58160A14;
	Wed, 10 Jun 2026 19:58:24 +0800 (AWST)
Message-ID: <8a059e3a4a3338bc03829071a720012bd426bf6d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/3] arm: dts: nuvoton: npcm7xx: Drop redundant FIU
 clock-names
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, 	openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 avifishman70@gmail.com, tali.perry1@gmail.com, 	venture@google.com,
 yuenn@google.com, benjaminfair@google.com
Date: Wed, 10 Jun 2026 21:28:23 +0930
In-Reply-To: <CAP6Zq1gBcSEQznnQ+awrqacBXjTOWELQsMLDXL1yw8_daCzMOQ@mail.gmail.com>
References: <20260609163919.3321228-1-tmaimon77@gmail.com>
	 <20260609163919.3321228-3-tmaimon77@gmail.com>
	 <ff53862950a6075c43bb8f1e47c14389d6fc7575.camel@codeconstruct.com.au>
	 <CAP6Zq1gBcSEQznnQ+awrqacBXjTOWELQsMLDXL1yw8_daCzMOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-10 at 14:56 +0300, Tomer Maimon wrote:
> On Wed, 10 Jun 2026 at 13:49, Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > On Tue, 2026-06-09 at 19:39 +0300, Tomer Maimon wrote:
> > > The NPCM7xx FIU controller driver gets its single clock with
> > > devm_clk_get_enabled(dev, NULL) and does not perform a named
> > > clock lookup. Drop the redundant clock-names properties from the
> > > FIU controller nodes so the DTS describes only the resources the
> > > driver actually uses.
> >=20
> > The devicetree is a description of the hardware in the form documented
> > by the bindings. Generally it's not right to discuss Linux drivers
> > here: they're only relevant in the context of Linux, but the devicetree
> > binding governs devicetrees over multiple projects.
> >=20
> > From a quick look it seems that these names are not described in the
> > corresponding binding, therefore no drivers should be using them and as
> > such they can (and should) be dropped. A driver would only be worth
> > mentioning if it did use the undocumented names (as that would be a
> > complication).
> >=20
> > Can you please rework the description?
> do you mean change the description as follows
> "
> The NPCM7xx FIU controller nodes reference a single clock,
> but the FIU binding does not describe their clock-names properties.
> Drop the undocumented names so the DTS matches the binding.
> "

That sounds reasonable to me.

Thanks,

Andrew
