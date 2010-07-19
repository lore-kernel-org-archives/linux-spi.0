From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: make the moved loopback
	test work
Date: Tue, 20 Jul 2010 01:53:41 +0200
Message-ID: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
References: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
	<377310.49674.qm@web180311.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <377310.49674.qm-4JhmkcZgSkmORdMXk8NaZPu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/7/19 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>:

> A dedicated loopback test is the wrong model,
> given that SPI_LOOP exists. =A0And is even used
> in the sample userspace code ...

Hm looking over and grepping everywhere about this gives
me no clues as to how an in-kernel SPI loopback test could
use spi->mode |=3D SPI_LOOP. It can be set, and then it expects
the hardware to set the corresponding bit.

No matter how much I look at it, it seems like all use of this
require you to first register *some* device, whether real or
not, then you may play with it from kernelspace or userspace
alike.

So for a generic loopback in-kernel test I would need
something like:

loop over all masters
  for each master
    if it supports SPI_LOOP
      look for devices on master - make sure first device is a
      loopback dummy
      locate loopback dummy
      perform loopback test on the dummy

This means I still would have to register some dummychip
on the devices that should be able to run the test.

Anton, any hints on this, execept that you added it for
spidev?

I'll try to dream some use model up otherwise.

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
