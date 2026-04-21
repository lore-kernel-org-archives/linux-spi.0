Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460702BD59C;
	Tue, 21 Apr 2026 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766572; cv=none; b=iioMsDvlb4IqwPRV32Xwql7OvYwqb/+Yrnuf2/SXWzQyG/Z8ITm+6GOeSMFvYl375paNYzYKg5WmDm5KR30kZ5gUmrWMyLvlF5PTCpHMBsG6K/faLyJKc8jhD4sLCFJb35uJ6F8jDu+G/soKwfYxUFaD0uZYnONMHaEXYNwxon4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766572; c=relaxed/simple;
	bh=bxxTuMlQOcQt9+SutU5wYexe4SpnFx38EDAqmrj2KxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ5/lXDGyKJOACnW528BF9JIg1mwX6U1+FXLM1jfGlJrTWhCHAHHvMAXDE6uCFvlaXPwxgmtRyCmT93z0mCjvBk9dECKaLQhJPEKQI14x7XcW4p4AINpcQQlpua6jO/vrhU5kGEtEaQ9oe/ZolX/nuE3ek9bzENRlfMEux/pxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=P9J8Ecxn; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="P9J8Ecxn"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id B5DD01F95F;
	Tue, 21 Apr 2026 12:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1776766568;
	bh=ui7NLbdFMSE3lMZwZtDMX7zed4AiVYTm9v+0mYYPfQU=; h=From:To:Subject;
	b=P9J8Ecxn7r34vw3O/E5WLMFUxAdCUuO7e7dYl6fG+/kh0y1CPTiPUhKr3c3Kw5JFh
	 hj4fSbE1SU4lVPjnDiA9E6fYCws79JGv5SWLbtlG3cSWpY6ClYI+NVlORE/fhSH/Ph
	 nlpccaYRhnZwUETDOHydRoTpGEHHPUztO7mCQoc1WLCpNzfEJcaMxI3X4yGVvSF6Zj
	 A2oZONfi78MRLiVvSrbfKo9AbUYcs1OU0NHJmHkSbFqs+4VNOFWT8h1M3C3LV5jM6x
	 CHuZNr1yHeqc//eKkM5lRbEGPw15RRozq7cCEiJFwn/6HrX0z2C7+Va/aBvYYjpHL5
	 7/9Cq4/O4ccNg==
Date: Tue, 21 Apr 2026 12:16:06 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: trivial-devices: add
 toradex,lava-hat-spi
Message-ID: <20260421101606.GC23508@francesco-nb>
References: <20260420114537.78160-1-francesco@dolcini.it>
 <20260420114537.78160-2-francesco@dolcini.it>
 <20260420-task-navy-370ea247fe1d@spud>
 <005d96ea-b250-4af8-9c5b-d145bae892e5@kernel.org>
 <20260421083843.GA23508@francesco-nb>
 <eb1ae818-eb9c-4225-9969-ebbb05304697@kernel.org>
 <20260421095928.GB23508@francesco-nb>
 <9c9795b0-a8ba-453d-9a92-f07b3ca59070@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9795b0-a8ba-453d-9a92-f07b3ca59070@kernel.org>

On Tue, Apr 21, 2026 at 12:05:45PM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2026 11:59, Francesco Dolcini wrote:
> > 
> >> Toradex LAVA hat is way too generic. No, single compatible string is not
> >> sufficient, please read writing bindings.
> >>
> >> Please define exact model and variants.
> >>
> >>>
> >>> The need is to be able to test SPI with a mainline Linux kernel, so I am
> >>> looking for a solution that works in mainline Linux.
> >>
> >> incomplete devices do not stop you from that.
> > 
> > Do this sentence means that I can send a DT file for inclusion in the
> > Linux kernel using a compatible documented in incomplete-devices?
> 
> No. You will be testing a mainline DTS + load non-mainline overlay. So
> your requirements of "mainline Linux" are fully solved. Overlay is
> loaded by bootloader for example and thus your kernel is fully mainline.

Ok, I was not clear enough, I am looking to have a solution that is 100% in
mainline.

> >> But you don't get exceptions because you want to mainline your DTS. Your
> >> need detailed hardware description and precise compatible per each exact
> >> hat ("exists in multiple variants").
> > 
> > Let me get into more details here, before sending a new patch version.
> > 
> > We have various LAVA HAT devices, the difference is that they provide
> > different features and a different layout, based on the actual carrier
> > board they are mated with.
> > 
> > We have an "Aquila LAVA HAT", that can be mated with the "Aquila
> > Development Board", and a "Verdin LAVA HAT", that can be mated with a
> > "Verdin Dahlia Board".
> 
> Of course, because each device is specific so even the hat must be
> specific, unless you have a standard connector like Arduino or RPi.
> 
> > 
> > As an example, you can find the Verdin Dahlia DTS here,
> > ti/k3-am625-verdin-wifi-dahlia.dts, that can be mated with the "Verdin
> > LAVA HAT".
> > 
> > The SPI device on both "Aquila LAVA HAT" and "Verdin LAVA HAT", is the
> > same, no differences. On the Aquila variant we
> > have two instances of it, while on the Verdin we have only one instance
> > of it.
> > 
> > So, would we need a compatible like this? 
> > 
> > compatible = "toradex,aquila-lava-hat-spi", "toradex,lava-hat-spi";
> > 
> > or
> > 
> > compatible = "toradex,verdin-lava-hat-spi", "toradex,lava-hat-spi";
> 
> Yes, assuming that verdin/aquila hat works for EVERY verdin/aquila
> board, regardless what SoM or SoC you have there.

This is correct, it's exactly like that.

> Verdin is a SoM family according to:
> https://www.toradex.com/computer-on-modules/verdin-arm-family
> 
> and I doubt you can attach hat to a SoM. There is no connector on SoM
> for the hat... so probably you have a board, like Dahlia.

Correct, the HAT is for the carrier, and the carrier is for the family.

With that clarified I plan to send a v2, with something like
"toradex,verdin-dahlia-lava-hat-spi", "toradex,lava-hat-spi" (for each
carrier board we have) and DTS files where this is used, and properly
documenting the compatibility between the various HW devices.

Thanks,
Francesco

