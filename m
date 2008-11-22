From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 05/14] mfd: PCAP2 driver
Date: Sat, 22 Nov 2008 15:58:03 -0800
Message-ID: <200811221558.03915.david-b@pacbell.net>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	<200811221119.27981.david-b@pacbell.net>
	<20081122233356.GC24437@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Stefan Schmidt <stefan-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081122233356.GC24437-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
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

On Saturday 22 November 2008, Stefan Schmidt wrote:
> > > +config EZX_PCAP
> > > +=A0=A0=A0=A0=A0=A0=A0bool "PCAP Support"
> > > +=A0=A0=A0=A0=A0=A0=A0depends on PXA_EZX
> > =

> > It only builds on one platform. =A0Now, that may make sense if it's
> > an ASIC currently used only on that platform; it's a "hardware"
> > dependency. =A0But it's not a necessary "software" dependency, no
> > code here seems to rely on PXA hardware, or EZX hardware.
> =

> It is software and we are on the way fixing it.

Good.  I've only seen patch #5 of this series, so I couldn't
tell what else was up.


> > One of the goals of getting drivers into mainline is to get rid
> > of needless dependencies ... and thereby open the code up to
> > many more developers. =A0Some may do nothing more than cleanup;
> > others will be doing API overhauls, which can be a PITA if you
> > place needless build dependencies on your code.
> =

> Understand. We have been a bit lazy here, sorry. That is mostly based on =
the
> fact that we have never seen any other linux devices having this chip. On=
ly some
> low power feature phones with the P2K OS from Motorola. Anyway, we work o=
n it to
> get it more generic now.

Looks to me like you're almost all the way there already!  :)

Much like we're doing with the twl4030 family chips ... they're
used on a lot of OMAP3 (and some OMAP2430) boards, and some
build dependencies evolved over the past year or so while
the driver support was maturing out of mainline.  Patches to
remove them are ready now, and should be "cooked" enough to
make the 2.6.29 merge window.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
