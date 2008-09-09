From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
	select gpio to simplify the common cases
Date: Tue, 9 Sep 2008 10:49:49 -0700
Message-ID: <200809091049.49327.david-b@pacbell.net>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<200809081704.43404.david-b@pacbell.net>
	<48C5CFEE.6070601@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48C5CFEE.6070601-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > +=A0=A0=A0=A0=A0/* NOTE: setup() can be called multiple times, possibly=
 with
> > +=A0=A0=A0=A0=A0 * different chip_info, previously requested GPIO shall=
 be
> > +=A0=A0=A0=A0=A0 * released, stumped :(
> > +=A0=A0=A0=A0=A0 */

No; chip_info should be regarded as immutable between the time the
initializing setup() call is invoked and, should it ever happen,
the cleanup() is invoked.  Anyone mucking around with that controller
data deserves the chaos they will have started.


> > +=A0=A0=A0=A0=A0if (gpio_is_valid(chip_info->gpio_cs)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D gpio_request(chip_info-=
>gpio_cs, "SPI_CS");

I'd actually pass dev_name(&spi->dev) not "SPI_CS", since I
happen to like seeing /sys/kernel/debug/gpio be informative.

Seeing half a dozen "SPI_CS" (uppercase, yeech!) labels is
not informative; seeing "spi1.0", "spi1.1", "spi2.5" etc is
more useful ... you can probably cross-check them with the
board schematics to detect errors, instead of just omissions.


> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (err) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err=
(&spi->dev, "failed to request CS GPIO%d\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0chip_info->gpio_cs);
> =

> I do not agree that this is an error, though David may argue that it is.

It's an error all right.  If that signal is in use by some
other driver, this one should never touch it.


> =A0Feel free to reduce this to KERN_INFO and eliminate the following
> return. =A0It is not illegal to omit the chip select on a one-chip bus,
> when the chip does not use CS; there is no need to allocate and waste a
> pin if it is not connected to anything.

But such "not illegal" cases wouldn't hit this "if (err) ... " branch...


> > +=A0=A0=A0=A0=A0if (gpio_is_valid(chip->gpio_cs))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0gpio_free(chip->gpio_cs);
>
> Again, this does not belong in the master driver, IMHO; the resource
> should have been allocated outside the master.

No; drivers do request_resource(), and gpio_request() is the same
kind of thing.  And they need to clean up the resources which they
requested on various paths -- even when those resources are GPIOs.

Of course, if the cs_control() route is used, then pxa2xx_spi isn't
going to be allocating any underlying GPIOs, so it won't have to
free them either.

- Dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
