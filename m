Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5D2D6E72;
	Wed, 20 May 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284263; cv=none; b=m0hUnZFnekd0mp9uVvKWdrvco6/R4m5OCFu9INvhp4SYgfCKi9GOI8fMofAQkZ7XnGkNsMwDF1AIHXEYkF9dtIwV0Mxoic32542O3UnGO3l4+AfzTtiIWDRxY6KWVZJZMyK9XmcWmrGyPL+sG2LohHVyopwCC/k06x/tKtvKVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284263; c=relaxed/simple;
	bh=PeR8Il5PxKRvIYuRfOdbGF1+vCEu4kSYkw0AEI25qWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjTRC+zVIgM16azYltvgKJH7pQ8Mwy3mpqx+2dO1KOxwppE7Q2Tj6AZRGUBvq+h22HekBGWpELsU9b4tAU9Oaa/tuwxm50Zv3dn0zJ9qJ1oIQzInBBa8mr7PkAh8LTygRT6OEnSdSjaO7mWlkxFzFa5y1K6TFrBklWm1gHJaaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogq7rU78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogq7rU78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45751F000E9;
	Wed, 20 May 2026 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284262;
	bh=SzfdZlB8TxUrqiukwfq5Djv/xODrOaSicE7WBGa2brA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ogq7rU7851egImmViI9erNCqTDDaR7u3kE2urX7lYUWUSqOgZ9N8utC+LIrNzz9ef
	 ipPoEeDEKfMRqlQpFAOK2/A9aqmPp5m00lk5sopI3hP5WqXw/XU0crcxbHaLSKBkIG
	 9pCJ20Eyk00k0tB9hCIvcxLtV1PLnrqFbe4bcNESWzmAeaZ5UYHpV/YlruIv5hCZFn
	 NnTHI1dzWs988NmCCPW0v/FPTGgeYyTVGO5+bQh3z0gGctl6CVUYKPAFyQxeRwU50q
	 wX7D5OtfkVeukQq0kDK2kcFOQirl+jwPQrqzqqDtChuEJG07NXufftuTLbVxy6Ho4l
	 6agHNaewlDnSw==
Date: Wed, 20 May 2026 21:18:35 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: cdns,xspi: add sdma-io-width
Message-ID: <ag20q5CuB2XsqKS_@xhacker>
References: <20260511031732.3199-1-jszhang@kernel.org>
 <20260511031732.3199-2-jszhang@kernel.org>
 <20260515-expert-devious-cricket-faff56@quoll>
 <agz0kDsQBaeQPPQ4@xhacker>
 <21d30826-bfe6-44cd-8c89-c1986f539e48@kernel.org>
 <ag2fjCX0DuSVxubv@xhacker>
 <14719378-7bf5-4688-81e9-bccedf618d18@kernel.org>
 <de325dba-0b82-4808-910b-68f0f6426c5f@sirena.org.uk>
 <37a3e9dd-88c2-4d8d-8ae4-6037a1eeedcc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37a3e9dd-88c2-4d8d-8ae4-6037a1eeedcc@kernel.org>

On Wed, May 20, 2026 at 03:22:07PM +0200, Krzysztof Kozlowski wrote:
> On 20/05/2026 14:30, Mark Brown wrote:
> > On Wed, May 20, 2026 at 02:16:21PM +0200, Krzysztof Kozlowski wrote:
> >> On 20/05/2026 13:48, Jisheng Zhang wrote:
> > 
> >>> If you mean "Why this cannot be deduced from the compatible?", I think
> >>> the slave dma port is part of the cdns xspi, so its io width belongs
> >>> to xSPI device property.
> >>> From another side, we have seen such property in other drivers such as
> >>> the reg-io-width for the dw spi DW_SPI_DR port io width.
> > 
> >> So you mean it depends on SPI device? Then why spi-peripheral-props is
> >> not applicable here?
> > 
> > That will be controller side, not device side.
> > 
> >> If this is not bus width, but DMA-something, is not really then SPI
> >> device dependent, but rather DMA controller limitation, so either
> >> deducible from compatible or something else is missing here.
> > 
> > My understanding is that this is a connection between the SPI and DMA
> > controllers so it's not as obvious as it could be which side of that
> > link should have the property, eg:
> > 
> >   https://www.cadence.com/content/dam/cadence-www/global/en_US/documents/tools/silicon-solutions/design-ip/controller-ip-qspi.pdf
> > 
> > shows a separate direct connection between the DMA controller and the
> > xSPI controller, the DMA controller isn't interacting with registers on
> > the CPU visible buses.  The width is probably a design time configurable
> > option on both sides of the link.
> 
> Yes and that sounds a lot specific to particular controller, thus should
> be implied by / deducible from the compatible.

This is IP feature, so if we couple the IP's feature with platform
compatible, I would see some unnecessary LoCs. For example,
Let's assume the IP has 10 users, they all support 4 bytes io width,
other features are the same. 

If implied by the compatible string, we need to add 10 compatible
string support both in code and dt-bindings.

vs

If supported by "sdma-io-width", nothing is needed after this patch

IMHO, the 2nd sounds better, what do you think?

Thanks
