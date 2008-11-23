From: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
Subject: Re: [patch 05/14] mfd: PCAP2 driver
Date: Sun, 23 Nov 2008 01:33:06 +0100
Message-ID: <20081123003306.GE24437@datenfreihafen.org>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	<200811221119.27981.david-b@pacbell.net>
	<20081122233356.GC24437@datenfreihafen.org>
	<200811221558.03915.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Stefan Schmidt <stefan-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200811221558.03915.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2008-11-22 at 15:58, David Brownell wrote:
> On Saturday 22 November 2008, Stefan Schmidt wrote:
> > > > +config EZX_PCAP
> > > > +=A0=A0=A0=A0=A0=A0=A0bool "PCAP Support"
> > > > +=A0=A0=A0=A0=A0=A0=A0depends on PXA_EZX
> > > =

> > > It only builds on one platform. =A0Now, that may make sense if it's
> > > an ASIC currently used only on that platform; it's a "hardware"
> > > dependency. =A0But it's not a necessary "software" dependency, no
> > > code here seems to rely on PXA hardware, or EZX hardware.
> > =

> > It is software and we are on the way fixing it.
> =

> Good.  I've only seen patch #5 of this series, so I couldn't
> tell what else was up.

Sorry. This set touched a lot of different subsystems. (ARM, spi, rtc, inpu=
t,
mfd, ..) The To: and Cc: list gave me quite some headache. :) Next time I m=
ake
sure that at least LKML is cc'ed on the whle series so people have a lace to
look at it in one thread.

> > Understand. We have been a bit lazy here, sorry. That is mostly based o=
n the
> > fact that we have never seen any other linux devices having this chip. =
Only some
> > low power feature phones with the P2K OS from Motorola. Anyway, we work=
 on it to
> > get it more generic now.
> =

> Looks to me like you're almost all the way there already!  :)

We hope so, yes. :) Once we have the EZX/PXA dep gone you are fine with this
patch? All SPI related stuff is ok from you?

> Much like we're doing with the twl4030 family chips ... they're
> used on a lot of OMAP3 (and some OMAP2430) boards, and some
> build dependencies evolved over the past year or so while
> the driver support was maturing out of mainline.

Yeah, pretty similar. We had to start from 2.4 driver code to get in touch =
with
this chip. Motorola did not offer any docs. Also the usual embedded board
out-of-tree problem. We are doing a lot better now since the last two kerne=
ls
though. Better workflow, tools, faster reaction on review and more energy
towards upstream submissions.

regards
Stefan Schmidt

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
