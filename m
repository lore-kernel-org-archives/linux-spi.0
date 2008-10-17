From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add Dallas DS1390 RTC chip
Date: Fri, 17 Oct 2008 08:29:06 -0700
Message-ID: <200810170829.06699.david-b@pacbell.net>
References: <48F452BE.2030901@mimc.co.uk>
	<20081014101703.1ded0259@i1501.lan.towertech.it>
	<48F8467C.5010902@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Mark Jackson <mpfj-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48F8467C.5010902-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 17 October 2008, Mark Jackson wrote:
> >> +=A0=A0=A0=A0/* Can tx_buf and rx_buf be equal? The doc in spi.h is no=
t sure... */
> >> +=A0=A0=A0=A0xfer.tx_buf =3D chip->tx_buf;
> >> +=A0=A0=A0=A0xfer.rx_buf =3D chip->rx_buf;
> > =

> > =A0you use the same buffer a few functions below. either
> > =A0one way or the other. please investigate with the spi subsystem main=
tainer.
> =

> David,
> =

> Just to double check (as per Alessandro's suggestion), is this okay use o=
f the =

> spi buffers ?

Yes.  That comment deserves to be updated.

SPI does bi-directional I/O, and the underlying controller
should be able to just replace the contents of a buffer
with a spi_transfer that uses the same rx and tx buffers.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
