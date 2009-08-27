From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question: Can transfer speed change mid
	message
Date: Thu, 27 Aug 2009 08:35:30 +0200
Message-ID: <63386a3d0908262335i22fbb42v810a96e1031a0e4e@mail.gmail.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901BEA097@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901BEA097-KURmP/Qoe8Pmp66j18f85VaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2009/8/17 H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>:

> My question is, if a message is composed of multiple transfers, is it pos=
sible
> for the speed to change mid message? =A0If it is, does this need to be ha=
ndled?

Typically your SPI HW is clocked by some on-chip clock line, and then
the SPI speed is derived from this clock line by a simple counter/divider
register that you set up.

So if that clock line coming in from the outside can change frequency in
the middle of the message this can of course happen.
The divided speed will change proportionally at that point..

So if you want full control you also need to hook into the clk framework
if you have SW control over your platforms clocks, then add some
prechange and postchange notifiers for clock speed change and make
sure you don't exit the prechange in the middle of a message and not
process a new one until after the postchange has completed.

There is nothing like that in the generic clk framework right now to
help you unfortunately, I've been thinking a bit about it.

Linus Walleij

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
