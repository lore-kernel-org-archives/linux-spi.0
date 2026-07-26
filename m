Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221F3CAA59;
	Sun, 26 Jul 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082508; cv=none; b=iKepPXprtV+BHUEkhGABNRmNU1bRy8LV2cC14PYNSUqpwxSkfqfdukAl6sh5qO//c0PHJXEeTkJ+0o0uza/MMFYtPziGRRg/Fn9yPELIsSS4CjqtntlXiDwDe9uV07yjXf5b+ZyCl0H/fR4H/J+pK4kbne6d95LUjHb5J0n6Utg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082508; c=relaxed/simple;
	bh=0FmqO68oIUQQEPjHg8UnkgDCeEClaUQRemyTenVmnZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbrejlnqXgIc+KGQbUcvx0KJT0Q5LhTGqd1UZYTr1Q/GOx7FxiOcZiviyGZ4H4JKBpH9ExbRNlA/kvjumDyRzOKmFfJ+s4huvm3gg13kdAq81bQYxm7eTuy7Wb3zYmSVLf9mIuMGhPI6wY27jGJPgvjwAXCSe9qP7H0jfa+1RTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id EF8A51062B;
	Sun, 26 Jul 2026 18:14:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DC283614B38E; Sun, 26 Jul 2026 18:14:35 +0200 (CEST)
Date: Sun, 26 Jul 2026 18:14:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mark Brown <broonie@debian.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <amYya_hiHM6lrxTX@wunner.de>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
 <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
 <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
 <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
 <al_ZlTkEUHj-X1YS@ashevche-desk.local>
 <CAAT15mMaZWdkp9YRKvRDRw-WCA-4nWGGo8gge=D7oBKUr1yysw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAT15mMaZWdkp9YRKvRDRw-WCA-4nWGGo8gge=D7oBKUr1yysw@mail.gmail.com>

On Sun, Jul 26, 2026 at 11:41:39PM +0800, Shih-Yuan Lee (FourDollars) wrote:
> Direct MMIO inspection of the LPSS DMA controller (PCI device 00:15.0)
> on physical MacBook8,1 hardware reveals that Apple's EFI firmware
> leaves the functional reset register (LPSS_PRIV_RESETS at BAR0 +
> 0x204) permanently set to 0x00000000 (held in reset).
> 
> Since the LPSS DMA controller is held in reset (0x0) by EFI firmware
> and the SPI peripheral relies on the dedicated OOB GpioInt() line for
> PIO transfers, forcing PIO mode via the DMI quirk in spi-pxa2xx-pci.c
> accurately reflects how EFI configures the hardware, allowing the
> driver to operate reliably out-of-the-box without system hangs.

The OOB GpioInt() and the DMA controller are two different things:
The former allows the peripheral to signal that a key has been pressed etc,
whereas the latter allows feeding the FIFOs of the SPI host controller
without CPU involvement (or with *less* CPU involvement, the CPU is still
needed to configure the DMA engine for a transfer).

I'm not sure why Apple chose to keep the DMA controller in reset,
but have you explored enabling it on boot?  If this can only be performed
before EFI hands over control to the OS, then it could be done in the
EFI stub, see setup_quirks() in drivers/firmware/efi/libstub/x86-stub.c.
Or maybe it can be done at runtime after the kernel has assumed control,
I'm not sure.

Thanks,

Lukas
