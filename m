From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 05/14] mfd: PCAP2 driver
Date: Sat, 22 Nov 2008 11:08:53 -0800
Message-ID: <200811221108.54331.david-b@pacbell.net>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	<f17812d70811220601p1d7af668mf3265224179753ab@mail.gmail.com>
	<1227369262.19591.41.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1227369262.19591.41.camel@brutus>
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

On Saturday 22 November 2008, Daniel Ribeiro wrote:
> Em S=E1b, 2008-11-22 =E0s 22:01 +0800, Eric Miao escreveu:
> > On Sat, Nov 22, 2008 at 1:25 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> w=
rote:
> > > On Friday 21 November 2008, stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org wrote:
> > >> Since the last submission we are also using the spi subsystem and
> > >> pxa2xx-spi instead of ssp.c directly as before.
> > >
> > > I took a quick glance at this and it seemed like it should be
> > > able to build without depending on PXA ... should certainly
> > > not include <mach/ssp.h> or <mach/regs-ssp.h>, and it doesn't
> > > look like it needs PXA-specific stuff like <mach/mfp-pxa27x.h>
> > > either.
> > >
> > > It's also worth removing the reverse dependencies ("select X")
> > > from Kconfig; they don't work very well for the things which
> > > those dependencies rely on.
> > >
> > I'm wondering if it call fall into the regulator framework, along with
> > a hwmon driver with its attributes being exported by sysfs.

Make it work like other MFD drivers, with child devices
to encapsulate such functionality ... and drivers specific
to those functionalities.

Such as a regulator framework driver, an RTC, and so on.


> The ADC is also used by the touchscreen driver, and later will be used
> for accessory detection (usb otg, charger, EMU (audio and uart on usb
> port)).

ADC integration may be an interesting little puzzle.

 =

> Currently the only user for the voltage regulators is the MMC, i plan to
> use the regulator subsystem when more users arise.
> =




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
