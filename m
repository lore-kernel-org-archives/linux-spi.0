From: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Mon, 19 Apr 2010 20:16:51 +0100
Message-ID: <y2q56d259a01004191216o48763eafy6401779ddae0f1@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 4/19/10, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>  >> > +       /* read all received data */
>  >> > +       while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
>  >> > +               espi->rx < t->len) {
>  >> > +               ep93xx_do_read(espi, t);
>  >> > +               espi->fifo_level--;
>  >> > +       }
>  >>
>  >> Another busywait loop.  Could end up burning an awful lot of cycles
>  >> here.  A state machine might be more suitable for this driver so that
>  >> processing can be punted to deferred work when the FIFO gets either
>  >> empty or full.
>  >
>  > FIFO size is max 8 frames so there should be 8 iterations when the
>  > FIFO is full. So is it enought to to add check that we only read
>  > max 8 frames from the FIFO?
>
>  If you do it right, FIFO size shouldn't matter.  The driver should
>  easily be able to read however many are available and defer until more
>  is ready.

Sorry, I completely missed the point at the end of the last post.

This is not a busywait loop. It takes bytes out of the RX FIFO until
it is empty, which is all useful work. There is also no way to tell
just from our internal variables how many bytes are in the RX FIFO as
far as I know, so the only way is to check the Receiver-Not-Empty
status bit (which is what this code does).

However, the
>  >> > +               espi->rx < t->len) {
is redundant, since it will always be true when the first condition is
true, though the compiler cannot see optimise it out.

If you're afraid that a caller might pass the driver a receive buffer
shorter than than the transmit buffer, it would be better to check
that once when the transfer is requested, not once per byte received!

The same goes for the other checks for conditions that can only ever
be true or only ever false that I mentioned in my remarks on earlier
patches, and other optimizations. We are at the byte-per-byte level of
a device driver for a slow CPU, where efficiency is at a premium.

     M

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
