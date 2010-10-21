From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: fixed some core weirdness
Date: Fri, 22 Oct 2010 01:11:03 +0200
Message-ID: <AANLkTikG3nfD6_60v8CX963FuW=QOMtFC4U3Nh_KTxag@mail.gmail.com>
References: <1287688004-27410-1-git-send-email-linus.walleij@stericsson.com>
	<1287700080.2038.121.camel@helium>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287700080.2038.121.camel@helium>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/10/22 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>:

>> and then two hardcoded
>> strings passed in as parameters.
>
> Which reduced the text space used by the driver, by sharing parts
> of the message that were not variable. =A0I realize that some folk really
> don't care how much memory gets wasted by constant strings,
> but wasting image space still seems like a foolish policy to me.

Aha so that's what it's for, that was really a too ingeniously
clever way to save space for me.

Is this a very well-known and widespread idiom?

As for saving space, taste obviously differs, but I do care.
I got a patch for introducing discardable probe() functions in
struct amba_device nixed because of lack of interest, would you
back me up on that if I respin it?

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
