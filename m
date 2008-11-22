From: Stefan Schmidt <stefan-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 05/14] mfd: PCAP2 driver
Date: Sun, 23 Nov 2008 00:33:56 +0100
Message-ID: <20081122233356.GC24437@datenfreihafen.org>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	<200811212125.49068.david-b@pacbell.net>
	<1227373948.19591.66.camel@brutus>
	<200811221119.27981.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200811221119.27981.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello.

On Sat, 2008-11-22 at 11:19, David Brownell wrote:
> On Saturday 22 November 2008, Daniel Ribeiro wrote:
> > =A0
> > +config EZX_PCAP
> > +=A0=A0=A0=A0=A0=A0=A0bool "PCAP Support"
> > +=A0=A0=A0=A0=A0=A0=A0depends on PXA_EZX
> =

> It only builds on one platform.  Now, that may make sense if it's
> an ASIC currently used only on that platform; it's a "hardware"
> dependency.  But it's not a necessary "software" dependency, no
> code here seems to rely on PXA hardware, or EZX hardware.

It is software and we are on the way fixing it.

> One of the goals of getting drivers into mainline is to get rid
> of needless dependencies ... and thereby open the code up to
> many more developers.  Some may do nothing more than cleanup;
> others will be doing API overhauls, which can be a PITA if you
> place needless build dependencies on your code.

Understand. We have been a bit lazy here, sorry. That is mostly based on the
fact that we have never seen any other linux devices having this chip. Only=
 some
low power feature phones with the P2K OS from Motorola. Anyway, we work on =
it to
get it more generic now.

> Strike that dependency, and depend instead on SPI_MASTER since
> that's the only dependency truly required by the build system.

Will do.

regards
Stefan Schmidt

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
