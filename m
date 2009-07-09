From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 29/44] includecheck fix: drivers/spi, amba-pl022.c
Date: Thu, 9 Jul 2009 23:17:41 +0200
Message-ID: <63386a3d0907091417u2014ad2ax645015e4cbbaa50c@mail.gmail.com>
References: <1247063308.4382.12.camel@ht.satnam>
	 <1247067147.4382.80.camel@ht.satnam>
	 <63386a3d0907081028s4a36fccen9cea9a316e2ef4c6@mail.gmail.com>
	 <1247074967.4382.115.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756609AbZGIVRx@vger.kernel.org>
In-Reply-To: <1247074967.4382.115.camel@ht.satnam>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

2009/7/8 Jaswinder Singh Rajput <jaswinder@kernel.org>:
> On Wed, 2009-07-08 at 19:28 +0200, Linus Walleij wrote:
>> 2009/7/8 Jaswinder Singh Rajput <jaswinder@kernel.org>:
>>
>> > fix the following 'make includecheck' warnings:
>> >
>> > =A0drivers/spi/amba-pl022.c: linux/delay.h is included more than o=
nce.
>> > =A0drivers/spi/amba-pl022.c: linux/errno.h is included more than o=
nce.
>>
>> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>>
>> David are you merging this?
>
> This is a big patchset, So better me or Sam will send this to Linus
> after collecting some more ACKs.

Not me I hope (damned I knew this would happen sooner or later).
return -ELINWAL

Having this name is very convenient, people review my drivers like
crazy.

Linus Walleij
