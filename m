From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] spi: Add support for non-blocking synchronous transfers
Date: Sun, 1 Mar 2009 01:49:19 -0800
Message-ID: <200903010149.19845.david-b@pacbell.net>
References: <20090228081036.31964.80618.stgit@fedora.yogi> <200902281519.55341.david-b@pacbell.net> <20090301051103.GA3103@fedora.yogi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Andy Green <andy@openmoko.com>
To: Balaji Rao <balajirrao@openmoko.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757160AbZCAJtf@vger.kernel.org>
In-Reply-To: <20090301051103.GA3103@fedora.yogi>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Saturday 28 February 2009, Balaji Rao wrote:
> > That leaves un-answered the question of what to do when
> > the SPI bus is busy performing some other transfer. =A0I
> > looked at your [2/2] patch, and saw it ignoring that very
> > basic issue ... this new call will just poke at the bus,
> > trashing any transfer that was ongoing.
>=20
> We use s3c24xx_gpio as the master, which is a very simple gpio based
> bitbang.=20
>=20
> Yes, it is with this intention, interrupts are disabled around the
> actual bitbang code, so that it completes without being interrupted.
> Doesn't this guarantee atomicity ?

Atomicity isn't the issue so much as the fact that if the
bus is in the middle of some transfer to one device,
your patch lets another device trash that transmission.

I don't know how many more times I can say that your
patches introduce DATA CORRUPTION to the system, but
it's surely not many more times.
