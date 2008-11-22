From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 05/14] mfd: PCAP2 driver
Date: Sat, 22 Nov 2008 11:19:27 -0800
Message-ID: <200811221119.27981.david-b@pacbell.net>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	<200811212125.49068.david-b@pacbell.net>
	<1227373948.19591.66.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1227373948.19591.66.camel@brutus>
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
> Above comments are integrated on the attached patch. =


Not exactly:

> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -153,6 +153,13 @@ config MFD_WM8350_I2C
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0I2C as the control interface. =A0Additional o=
ptions must be
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0selected to enable support for the functional=
ity of the chip.
> =A0
> +config EZX_PCAP
> +=A0=A0=A0=A0=A0=A0=A0bool "PCAP Support"
> +=A0=A0=A0=A0=A0=A0=A0depends on PXA_EZX

It only builds on one platform.  Now, that may make sense if it's
an ASIC currently used only on that platform; it's a "hardware"
dependency.  But it's not a necessary "software" dependency, no
code here seems to rely on PXA hardware, or EZX hardware.

One of the goals of getting drivers into mainline is to get rid
of needless dependencies ... and thereby open the code up to
many more developers.  Some may do nothing more than cleanup;
others will be doing API overhauls, which can be a PITA if you
place needless build dependencies on your code.

Strike that dependency, and depend instead on SPI_MASTER since
that's the only dependency truly required by the build system.

Or tell me I'm wrong, and there's really a reason this code must
not even *build* on x86 systems.


> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0This enables the PCAP ASIC present on EZX Phone=
s. This is
> +=A0=A0=A0=A0=A0=A0=A0 =A0needed for MMC, TouchScreen, Sound, USB, etc..
> +
> =A0endmenu
> =A0



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
