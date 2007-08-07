From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 0/4] MMC-over-SPI
Date: Mon, 6 Aug 2007 20:21:00 -0700
Message-ID: <200708062021.01241.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<20070723142923.GA28979@localhost.localdomain>
	<200707231033.31717.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707231033.31717.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Monday 23 July 2007, David Brownell wrote:
> > > If that hardware were doing the right thing, then it would work
> > > reliably! =A0Since it's not reliable, it's doing something wrong.
> > > You seem to think it's not a hardware issue; that may be true.
> > > =

> > > Recall that the first dozen or so commands worked just fine. =A0The
> > > issue was that some byte that should have been all-ones or 0xfe
> > > reported instead an 0xf8. =A0That's not the kind of error that can
> > > be explained by clock skew; it covers at least two bits.
> > =

> > Yup, I've either noticed that 0xf8 and 0xfe differs by only two
> > bits (and by three if comparing to 0xff). But I can't really
> > explain it yet.

Just for the record -- on my test rig, SPI mode 3 stopped working
entirely ... I'd get one-bit errors, so that CMD0 status would be
"0x03" instead of "0x01" (indicating CRC error plus still-resetting).
Switching to SPI mode 0 made it all work again; masking out the 0x02
bit made everything time out.  So I'm thinking that *was* somehow a
shift of one bit.

I think this was caused by removing wires for one SPI device from
that breadboard ... but it's hard to say for sure.  For a while it
seemed like MMC cards worked OK but not SD cards!  I'm working on a
more permanent rig.  But I think when I send the next revision to
Pierre, it'll be using SPI_MODE_0.  :)

I thought you might be amused, given the strange behavior you saw!

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
