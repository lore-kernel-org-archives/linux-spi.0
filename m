From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: Re: [PATCH 29/44] includecheck fix: drivers/spi, amba-pl022.c
Date: Wed, 08 Jul 2009 23:12:47 +0530
Message-ID: <1247074967.4382.115.camel@ht.satnam>
References: <1247063308.4382.12.camel@ht.satnam>
	 <1247067147.4382.80.camel@ht.satnam>
	 <63386a3d0907081028s4a36fccen9cea9a316e2ef4c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756332AbZGHRoh@vger.kernel.org>
In-Reply-To: <63386a3d0907081028s4a36fccen9cea9a316e2ef4c6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2009-07-08 at 19:28 +0200, Linus Walleij wrote:
> 2009/7/8 Jaswinder Singh Rajput <jaswinder@kernel.org>:
> 
> > fix the following 'make includecheck' warnings:
> >
> >  drivers/spi/amba-pl022.c: linux/delay.h is included more than once.
> >  drivers/spi/amba-pl022.c: linux/errno.h is included more than once.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> 
> David are you merging this?
> 

This is a big patchset, So better me or Sam will send this to Linus
after collecting some more ACKs.

Thanks,
--
JSR
