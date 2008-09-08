From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Limitations on transfer length [was:
	pxa2xx_spi with SFRM]
Date: Mon, 8 Sep 2008 15:42:34 -0700
Message-ID: <200809081542.34795.david-b@pacbell.net>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<48A4ED85.1030803@gmail.com> <48A5D272.1070804@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A5D272.1070804-/d+BM93fTQY@public.gmane.org>
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

On Friday 15 August 2008, Ned Forrester wrote:
> David,
> =

> Is there supposed to be any practical limit to the length of a transfer?

Physical memory.  :)


> =A0It seems that the /dev/mtdblock_spi driver has requested a transfer in
> excess of 8191 bytes (though I don't know how long a transfer it
> requested).

SPI flash is often used for things like downloading FPGA
configuration bitstreams or first stage bootloaders (after
stage zero, an SOC's boot rom).

To support those use cases, SPI flash basically has no limit
on the number of bytes that can be read at once.  And the
Linux drivers for those SPI flash chips happily leverage
those requests.

Not many other applications wor that way though.

 =

> In this case, I think pxa2xx_spi.c could handle long transfers in PIO
> mode, but not if DMA has been requested. =A0It looks like we may have put
> a bug in pxa2xx_spi by performing the length test even when DMA is not
> requested.
> =

> Is it proper to require that PIO mode be used if long transfers will be
> requested?

It's a fair workaround, but sub-optimal.  Recall that large
transfers are the place you most want to use DMA ... :)


> 5. Require that pxa2xx_spi break long DMA transfers into the required
> number of pieces to be performed in separate DMAs, silently giving back
> the message after it has completed all of it (this requires a lot of
> extra book-keeping in pxa2xx_spi).

If this happens a lot, that's the way to go.  I'd expect the driver
can be simplified to make this hurt less.

- Dave




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
