From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 05/14] mfd: PCAP2 driver
Date: Sat, 22 Nov 2008 20:59:59 -0800
Message-ID: <200811222059.59806.david-b@pacbell.net>
References: <20081121160403.073751031@dodger.lab.datenfreihafen.org>
	<200811221819.53186.david-b@pacbell.net>
	<1227411537.3148.22.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Stefan Schmidt <stefan-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-RWuK6r/cQWRpLGFMi4vTTA@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
To: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1227411537.3148.22.camel@brutus>
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
> > =A0- You should make ezx_pcap_write() and ezx_pcap_read() switch
> > =A0 =A0over to spi_write_then_read(), to ensure it's never doing
> > =A0 =A0DMA to/from the stack. =A0I see a byte-order dependency too...
> =

> I tried spi_write_then_read before, but it didn't work. I supposed it
> was because it was doing 2 transfers as the second transfer rx_buf
> always came zeroed.

You may have been using it wrong.  Also, verify against
current kernels ... there have been bugfixes to pxa2xx_spi.


> I see that commit =

> f9b90e39cbc5c4d6ef60022fd1f25d541df0aad1 changed it to do a single
> transfer, so i will try it again.

Unless it needs the full duplex capability of SPI, then
you should be able to make write_then_read work ... on
the other hand, if you do need full duplex, then you
should address the DMA.  (And byteswapping, either way.)


> > =A0- If you're going to mark the probe() as __devinit, then mark
> > =A0 =A0the remove() as __devexit and use __devexit_p() in the driver
> > =A0 =A0struct.
> =

> Ok. Shouldn't i use __init instead?

I wouldn't.  There are ways that the probe() could be called
more than once -- e.g. after rebinding either of the relevant
SPI drivers through sysfs, or after rmmod/modprobe of the SPI
master controller driver -- and using an __init annotation
would make that point to memory that's unlikely to still hold
that code.

- Dave

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
