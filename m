Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30827435A86;
	Wed, 22 Jul 2026 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714335; cv=none; b=fBHaQSUYc40gg2AiyNXycFRvQeFZ5mQv5oYzBkWyHOKn+JSs+3s7Mx+qPuuSLCFSviRfB/uyLVuij94JARNcxjwekqco+M3ADJ1yVBdw4WlCIGjsgI9ztqUHHA1CDqG+bmSzqGrR74Q/IaI+yt2L9y8TbyOIF4qFrauARQ2mYA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714335; c=relaxed/simple;
	bh=TP/4b0yJawWJ5p7MA1V5kZxyMVnJ4WZ6QWnSlyr8BCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJXIVYhWiTs7CMyP3EgeemqAhIscqChCRJQsUnHv70JqzjMVkQLlg9U0q8wMz6lGRVxAkpaJ4+OyEvenjeW3K20nRpL/JPdvlWp0k56rNA22XZVx5teyDsyb0DmwG2WhRGjm9m5i7F1XZaeZHUqJNK1JwfYxv9tS/oG3ibuTSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 0AFC210611;
	Wed, 22 Jul 2026 11:58:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E9FB062749F4; Wed, 22 Jul 2026 11:58:43 +0200 (CEST)
Date: Wed, 22 Jul 2026 11:58:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Mark Brown <broonie@debian.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <amCUU5WNbcgn3UR-@wunner.de>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
 <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
 <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
 <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>

On Wed, Jul 22, 2026 at 12:09:44AM +0800, Shih-Yuan Lee (FourDollars) wrote:
> This confirms the root cause is not a software IRQ routing issue but
> rather that the DMA controller's interrupt line is physically
> non-functional on this motherboard.

Like Andy says, the DMA controller is internal to the SkyLake-Y-ULX
with SunrisePoint-PCH (Intel 100 Series Chipset), it's not something
that needs to be connected on the mainboard.

I've just looked through the Specification Update for Intel 100 Series
Chipset and it doesn't list DMA-related errata.  Hm...

Lukas
