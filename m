Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6C3BED5F;
	Wed, 29 Jul 2026 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356506; cv=none; b=OWjo5cHt1yAtTJ2D0+qFa1FmULXUOcO1ska7BzuP/ZMhjz1/jWz5ALNs7Eij8jGOcK1IOF+UTOjNqvpGbFAZJHdY/Qc0eOn+P5TkLO3KfwyTeWfrIjyIAUjqjBxgDt9A1a4NmrgNJ0Ho1OSh8fT7eUvlZECa2+RCUsgMqXjdqGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356506; c=relaxed/simple;
	bh=pWw5MZ3mz/ExIvdx2+faIknvT7bORyWSmsoCUpAyPGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATHlmI/lwzduiCEeXMrBWYiWRRlM8Cj9nZD0P6qI36Pt2p+qlhZD/Ff3LfCVPwnEwu8V81kvhuxstKeNtwRWwd/CEXtcW3mo8rGizx8FAio9IIieXmL4+AZ3aexYskmSruzfA8BYKjWIakFkksJev/cq8s485OK9it49ZpL2IwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F61F000E9;
	Wed, 29 Jul 2026 20:21:43 +0000 (UTC)
Date: Wed, 29 Jul 2026 21:21:41 +0100
From: Mark Brown <broonie@debian.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <c05bb236-5aa2-4050-a030-8caed6d47a40@sirena.org.uk>
References: <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
 <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
 <CAAT15mNppZ6nPQ9a8Hp54XK4BXndfv+G24n4VeQ1X8GOk6fSyQ@mail.gmail.com>
 <CAAT15mMc73=cnqx7jvPXWjVUuzr-E54qh5+BR3d_G6m3NoXrng@mail.gmail.com>
 <al_ZlTkEUHj-X1YS@ashevche-desk.local>
 <CAAT15mMaZWdkp9YRKvRDRw-WCA-4nWGGo8gge=D7oBKUr1yysw@mail.gmail.com>
 <amYya_hiHM6lrxTX@wunner.de>
 <ampdJY4LcP6Qc1de@wunner.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QO978rW/zVaXg64Z"
Content-Disposition: inline
In-Reply-To: <ampdJY4LcP6Qc1de@wunner.de>
X-Cookie: Captain's Log, star date 21:34.5...


--QO978rW/zVaXg64Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2026 at 10:05:57PM +0200, Lukas Wunner wrote:
> On Sun, Jul 26, 2026 at 06:14:35PM +0200, Lukas Wunner wrote:

> > I'm not sure why Apple chose to keep the DMA controller in reset,
> > but have you explored enabling it on boot?

> Thinking about this some more and after taking a look at
> drivers/input/keyboards/applespi.c, I realize messages exchanged via SPI
> are always 256 bytes in size.  That's not a whole lot, and of course
> messages are only exchanged when a key is pressed or the trackpad is
> used.  So perhaps Apple determined that sending this in PIO mode is
> ultimately more efficient than keeping a DMA engine powered on all the
> time.  The CPU load saved through offloading the SPI transfer is offset
> by having to program the DMA engine for each transfer.

> So perhaps usage of PIO mode was indeed an intentional choice by Apple
> and need not be second-guessed.  I'm not sure.

DMA can also add extra latency with interrupt handling, it's possible
someone decided to trade some CPU time for minimal latency (though you
could probably arrange for shorter messages...).

--QO978rW/zVaXg64Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpqYNQACgkQJNaLcl1U
h9BqEQf/Y/vxR7/K+t1UI7aKLyxQEME3eMNStgxoERmSOrRiqcMIW+tIyiXeEl1r
doZ6PIi8JZV+kKlLU/ulZukqSgrVb1cV9WsaOVqVrYyOf7x0Urglr0y9ToJEofHS
DjZrrM7/iARNi1UjdVTIQKLvjOpmJ7yIHBxKmHjiSRH0QzGt72rC9AHBmzJO4SCI
FwzNo9NEsycT2C7CjEk8Vv7q2PNww3xUdP3s0qR40huULnKJdBRaIUiJjCLvb2J3
FPQVQJ+2A3JpelotEiNiXhanyCOngwCI7vkJ7F0UlZmFkLPK/8Tw+oOHaU9hyjAa
4PDpZ/4YiXdLrt97HT4vKhHVn8ajzw==
=UPNZ
-----END PGP SIGNATURE-----

--QO978rW/zVaXg64Z--
