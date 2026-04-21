Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341B175A6B;
	Tue, 21 Apr 2026 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760730; cv=none; b=l7P9SKxLMscM41iPkH9/BB2BkEYyP9AZICneLh+jcn7vkJXLBktR4SGR5p0QpACP3j56KFN7t6rYvq5neFL1+wngdFFcPUuTFArL1HY2ZBmzLgJdcxp0OWlZcp9YGxt9jy9G0Npb2cI4SCZagjgP6Ap7lQnYn9ph9JJFI8086C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760730; c=relaxed/simple;
	bh=jI+w1zBcEoCC3Gc9XybfVrRe2P3szNtki5Muta6764A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR6z5fLe1sdWdO0RtbGahal/vIz1HbJUiJIkre4xbLxjMELA6xRULTrvjopZ5dnrDQ9+JyS+YSw7vUgkA7GcOYQsMff4SznoVtrH7Su3UJsI7jJtoUk1y1nG/6eG6x++H7G8QHr0sySiwSoQSGoORyYA1Vj/TJtmTs2ihNdqCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wVB3NCGG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wVB3NCGG"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id DF2681FCCC;
	Tue, 21 Apr 2026 10:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1776760727;
	bh=fm/1RzOdzAzq+zYf9dVgGl/EQiJTiHbbxKKZTRaHaas=; h=From:To:Subject;
	b=wVB3NCGGdkDBXDDX0Caowe7B9NmNno6L37Hm0u4ijIg54Rz7yfQ7YNA9x3/yJQxC2
	 g2LmHZ374W3NXKqfCRZschcvbMScQ47of7ea1nq3ttprR9xLtwvXk/F6PY+3hgHhR+
	 pulcJTzCklCgEWc5XStBA075e3h3vYc6U8DQ0gD/PQw7Qjx9aknIFqHn7Tn88HiI9N
	 iRWFIv88HOy8jjH11UdP2VlhEw+ziN0cx/2Xdx3yEnWQ7PUzQNPd7Y+NnWF5evHsnd
	 C/GePhNDs4V7qEj3swuWG+rITOpNFeIobd/UFAJgDscX1oF656e5VLyKqeP1bgz8jl
	 gCapIwrKLGlkw==
Date: Tue, 21 Apr 2026 10:38:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor@kernel.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: trivial-devices: add
 toradex,lava-hat-spi
Message-ID: <20260421083843.GA23508@francesco-nb>
References: <20260420114537.78160-1-francesco@dolcini.it>
 <20260420114537.78160-2-francesco@dolcini.it>
 <20260420-task-navy-370ea247fe1d@spud>
 <005d96ea-b250-4af8-9c5b-d145bae892e5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005d96ea-b250-4af8-9c5b-d145bae892e5@kernel.org>

On Mon, Apr 20, 2026 at 06:10:08PM +0200, Krzysztof Kozlowski wrote:
> On 20/04/2026 18:02, Conor Dooley wrote:
> > On Mon, Apr 20, 2026 at 01:45:35PM +0200, Francesco Dolcini wrote:
> >> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >>
> >> Add a compatible string for the SPI loopback device present on the
> >> Toradex LAVA HAT test fixture.
> >>
> >> The Toradex LAVA HAT is a board used for automated hardware-in-the-loop
> >> (HIL) testing, it provides several test-related functionalities, and
> >> exists in multiple variants depending on the board it is mated with. The
> >> SPI function is implemented with a loopback on the MISO/MOSI signals.
> >>
> >> As the device can be fully described using only "compatible" and "reg",
> >> it is appropriate to list it under trivial-devices.yaml rather than
> >> introducing a dedicated binding.
> >>
> >> The SPI implementation is identical across all Toradex LAVA HAT
> >> variants, so a single compatible string is sufficient.
> >>
> >> Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
> >> Link: https://lore.kernel.org/all/20260316073547.11437-3-francesco@dolcini.it/
> >> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
> 
> 
> Heh, let's wait. That's a test device, so it won't be ever used in any
> final product, right? So not in final DTS?

It will be used in various DT overlay, that I plan to send for
inclusion in mainline Linux kernel once we have a way forward. So yes,
there will be DTB files using it.

The need is to be able to test SPI with a mainline Linux kernel, so I am
looking for a solution that works in mainline Linux.

What is the reason to not wanting to have a DT overlay file for a test
device in the Linux kernel? I assume that I would not be able to have an
overlay included, if it uses a compatible that is defined in
incomplete-devices. This was my understanding from
https://lore.kernel.org/all/a3796f8b-f94c-4d0d-a0b9-b2970e43e28d@kernel.org/

> Then why it's here? I think I directed previously to document it with
> the rest of test devices - in incomplete-devices schema?

Because, that would not allow to add it to any DT file, from my
understanding.

I linked here both the email thread in which we discussed the topic
before, and I understood it was ok to send it, given we have an actual
HW for it and we plan to submit DT to support it in mainline Linux.

I see we are running in circle, apologize for that.
What can I do so that we can move forward?

Francesco

