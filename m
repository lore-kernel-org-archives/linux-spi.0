From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: make the moved loopback
	test work
Date: Mon, 19 Jul 2010 18:03:25 +0200
Message-ID: <AANLkTimfLOSQWDhUkha_1i39E_gKHdto09ZrrGfqNiGC@mail.gmail.com>
References: <AANLkTikfwTxZ4iMaveddXLd1Z2phF0hVi_yG7A2wUNCo@mail.gmail.com>
	<377310.49674.qm@web180311.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Yeah I see, I never quite understood how SPI_LOOP
was intended really.

>From there to writing a *generic* loopback test is a bit
of road to cover though, let's see if I can figure it out.

The way I read the code I still have to provide some
kind of dummychip on the bus in order to perform a
loopback test on a bus with no devices connected,
am I right?

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
