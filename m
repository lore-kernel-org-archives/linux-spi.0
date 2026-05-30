Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48C39B960;
	Sat, 30 May 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780145718; cv=none; b=XBFdPqyuNIl5YPgem0l0kBCwM4CLxFn4LfnrcfYdbSdLvzsq0tan/PX54Bp0suxpeYq57toVAfor2BtgP0E+y5zU0LbIK5ZoyKRLjYC98+C1iOT4eKHaAf4uhFY54WJ7m4sT+18BfD0Wuvz3aDlNwvZJDOWw97Nq3qW0+jyWn9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780145718; c=relaxed/simple;
	bh=A0bOMn9XB26TRha8UtUaEiGCVtsTRl1l1r7jw3ysqhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqiIRuKCL5tva6/YvTQ+WSG5ls+CTkRib0YgL52p5mOk7EwhjrzMY58VzAhMlZKkRUbaWyV0R0DqZn3e1orUpdhWJIA5vIPZhUSu7xpA1pHJ+zo9I+a/kJZKsdV5IKIgV4D9zHUxCLnedi7/145TCylAYXZPN2Lob2SY/IdkJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdQ/0S4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdQ/0S4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25C11F00893;
	Sat, 30 May 2026 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780145717;
	bh=h0HrL+x9wbOX7ew2UHxPYItHL8ESuqXXvHECcppFC1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YdQ/0S4bN6X76XVQKdyOOvx56+rEcuRBhTmGrl1+iJlfFsfTvBxv41dwVEbHojGpD
	 FKgf0+4Jp27+iEHbHadlvhX9fzLS71GHSU3lLuKD9TekHFt1uZQ0fGcrmCcSsH60DX
	 6KdS7eyuDziBWrxtM3CNLNTz25c0zGJqmpDBSNNTSekRCO6xxoI9ROUMThVwR1FZWz
	 Tsk8OHye6K+Q7zIkJibwv3f3y6njiY40loLSfoq54lUvIdVxMt4vfh5eqn3A78sO2L
	 Bg26NM18fTmXhKgrqgzQGYl0gqAJJvrmaGp1texT6/teNIeR73QqvoDkqKruA4izh0
	 00xC9zcAreJCA==
Date: Sat, 30 May 2026 20:36:07 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: cdns,xspi: add sdma-io-width
Message-ID: <ahrZt5BI46oFXCBO@xhacker>
References: <20260511031732.3199-2-jszhang@kernel.org>
 <20260515-expert-devious-cricket-faff56@quoll>
 <agz0kDsQBaeQPPQ4@xhacker>
 <21d30826-bfe6-44cd-8c89-c1986f539e48@kernel.org>
 <ag2fjCX0DuSVxubv@xhacker>
 <14719378-7bf5-4688-81e9-bccedf618d18@kernel.org>
 <de325dba-0b82-4808-910b-68f0f6426c5f@sirena.org.uk>
 <37a3e9dd-88c2-4d8d-8ae4-6037a1eeedcc@kernel.org>
 <ag20q5CuB2XsqKS_@xhacker>
 <3eaa70e0-4284-4c35-a5d5-42afa3087eea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3eaa70e0-4284-4c35-a5d5-42afa3087eea@kernel.org>

On Wed, May 20, 2026 at 04:21:05PM +0200, Krzysztof Kozlowski wrote:
> On 20/05/2026 15:18, Jisheng Zhang wrote:
> > On Wed, May 20, 2026 at 03:22:07PM +0200, Krzysztof Kozlowski wrote:
> >> On 20/05/2026 14:30, Mark Brown wrote:
> >>> On Wed, May 20, 2026 at 02:16:21PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 20/05/2026 13:48, Jisheng Zhang wrote:
> >>>
> >>>>> If you mean "Why this cannot be deduced from the compatible?", I think
> >>>>> the slave dma port is part of the cdns xspi, so its io width belongs
> >>>>> to xSPI device property.
> >>>>> From another side, we have seen such property in other drivers such as
> >>>>> the reg-io-width for the dw spi DW_SPI_DR port io width.
> >>>
> >>>> So you mean it depends on SPI device? Then why spi-peripheral-props is
> >>>> not applicable here?
> >>>
> >>> That will be controller side, not device side.
> >>>
> >>>> If this is not bus width, but DMA-something, is not really then SPI
> >>>> device dependent, but rather DMA controller limitation, so either
> >>>> deducible from compatible or something else is missing here.
> >>>
> >>> My understanding is that this is a connection between the SPI and DMA
> >>> controllers so it's not as obvious as it could be which side of that
> >>> link should have the property, eg:
> >>>
> >>>   https://www.cadence.com/content/dam/cadence-www/global/en_US/documents/tools/silicon-solutions/design-ip/controller-ip-qspi.pdf
> >>>
> >>> shows a separate direct connection between the DMA controller and the
> >>> xSPI controller, the DMA controller isn't interacting with registers on
> >>> the CPU visible buses.  The width is probably a design time configurable
> >>> option on both sides of the link.
> >>
> >> Yes and that sounds a lot specific to particular controller, thus should
> >> be implied by / deducible from the compatible.
> > 
> > This is IP feature, so if we couple the IP's feature with platform
> > compatible, I would see some unnecessary LoCs. For example,
> > Let's assume the IP has 10 users, they all support 4 bytes io width,
> > other features are the same. 
> > 
> > If implied by the compatible string, we need to add 10 compatible
> > string support both in code and dt-bindings.
> 
> You always need 10 compatible strings in bindings.
> 
> But driver would need only one, since devices are compatible as you
> described.

Hi all,

Update: after carefully reading the registers' document, I found the
slave dma data width can be known by checking CTRL_FEATURES_REG's
DMA_DATA_WIDTH bit, we can don't need the DT property any more. I'm
cooking v2.

Thanks for all the review comments

> 
> > 
> > vs
> > 
> > If supported by "sdma-io-width", nothing is needed after this patch
> > 
> > IMHO, the 2nd sounds better, what do you think?
> 
> We answered this in writing bindings. Properties are not replacement for
> specific compatible. I don't know how to write that sentence in bindings
> clearer - it's exactly this case.
> 
> Best regards,
> Krzysztof
