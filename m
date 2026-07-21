Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC763C10B8;
	Tue, 21 Jul 2026 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624457; cv=none; b=CVhfvmSEZCMzgMnm4eiqJ0sHqCkk1s1ijAAb/OlvkGDmhrsQS3XlxzNT1oevJxAFCEJzywXUtx96wP8oUBi8iQ2gSkLRPWyepPNmBRieWsQNuAg0JDkb/ND3HYTHYxeYOnMb7fyQEAGP7US7wf2LVj6FOG6eEFCP6snlnELjqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624457; c=relaxed/simple;
	bh=zOgpbQHJvuRKjEBBtYUjlYYRpgzBMHaLB2qHRMCIE98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYG/CNrdD4uGMQr/sL2v1pu5ykXJwJ8Z86lcEI5+L9n5O0wcXZVm1VNVIDtYzS1xT/OT6SbARQE7Yqs62wm7q4KRvh8gLPHi22efgFrfMpqPaw6YsW0lh9MiQL/kuiumgeCJc8+X+47Mwz5GKzr4koTNJWnDVCNtvbeO7KvkVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 2836B2402;
	Tue, 21 Jul 2026 11:00:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 12215614B893; Tue, 21 Jul 2026 11:00:46 +0200 (CEST)
Date: Tue, 21 Jul 2026 11:00:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shih-Yuan Lee <fourdollars@debian.org>
Cc: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <al81PmK1UMr2g8p-@wunner.de>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720162117.32304-6-fourdollars@debian.org>

On Tue, Jul 21, 2026 at 12:21:14AM +0800, Shih-Yuan Lee wrote:
> On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
> 00:15.4 suffers from hardware DMA handshake failures and interrupt
> routing bugs, causing keyboard/touchpad transactions to fail when
> DMA is enabled.
[...]
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331

In the bugzilla comments, Leif Liddy writes:

   "I needed to modify drivers/dma/dw/pci.c to assign the DMA controller
    irq value to 21 (which is what is listed in the ACPI table) for it
    to work. The DMA controller was being assigned an irq value of 20
    for some reason."

It would seem better to fix up the incorrect interrupt number in a quirk,
rather than disabling DMA wholesale.

Thanks,

Lukas
