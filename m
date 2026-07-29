Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E973859C2;
	Wed, 29 Jul 2026 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355561; cv=none; b=EWeaSi+nEGs76iVTDSUsGupaYGS1TMwlQSC7o6yAxFhg9PyR2Mq8Puf+Kmul4QRBA+WpjzP9Sz+HvPkg+Odr0PcUKUQdOlLEShrzEQ+F5UXex6xULwrwP9Umj9nSeV9CmXcEAFPKgZieRNXUcqCQ6bSJHwAXZiCoonHX79/tkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355561; c=relaxed/simple;
	bh=TcE9/j4e/o06F9MFE9Iz3yL9CdpP5wplsS2nYuocKPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZKNkyvc9yhjQ33ghDy7nxjKZAd9ZtgfzA4f1fW812BXMMIyp+mkDC+y7/wFFK3O82lUHistqVoS/79DThSUF53iICnOdLu7ZZit3mTAIHQPx+YQKiiFFwyzG0s7VqANGj7hDyw4rbVVm+YQeqecdKlXKDMSC4XXnsGZQvwZN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 46310C1A;
	Wed, 29 Jul 2026 22:05:57 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 12B556031592; Wed, 29 Jul 2026 22:05:57 +0200 (CEST)
Date: Wed, 29 Jul 2026 22:05:57 +0200
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
Message-ID: <ampdJY4LcP6Qc1de@wunner.de>
References: <20260720162117.32304-6-fourdollars@debian.org>
 <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
 <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
 <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
 <al_ZlTkEUHj-X1YS@ashevche-desk.local>
 <CAAT15mMaZWdkp9YRKvRDRw-WCA-4nWGGo8gge=D7oBKUr1yysw@mail.gmail.com>
 <amYya_hiHM6lrxTX@wunner.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amYya_hiHM6lrxTX@wunner.de>

On Sun, Jul 26, 2026 at 06:14:35PM +0200, Lukas Wunner wrote:
> I'm not sure why Apple chose to keep the DMA controller in reset,
> but have you explored enabling it on boot?

Thinking about this some more and after taking a look at
drivers/input/keyboards/applespi.c, I realize messages exchanged via SPI
are always 256 bytes in size.  That's not a whole lot, and of course
messages are only exchanged when a key is pressed or the trackpad is
used.  So perhaps Apple determined that sending this in PIO mode is
ultimately more efficient than keeping a DMA engine powered on all the
time.  The CPU load saved through offloading the SPI transfer is offset
by having to program the DMA engine for each transfer.

So perhaps usage of PIO mode was indeed an intentional choice by Apple
and need not be second-guessed.  I'm not sure.

Thanks,

Lukas
