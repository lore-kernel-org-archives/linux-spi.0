From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.26-rc3] spi: remove some spidev
	oops-on-rmmod paths
Date: Wed, 21 May 2008 21:36:14 -0700
Message-ID: <200805212136.14517.david-b@pacbell.net>
References: <200805211829.07189.david-b@pacbell.net>
	<20080521205327.5aa27048.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080521205327.5aa27048.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

On Wednesday 21 May 2008, Andrew Morton wrote:
> On Wed, 21 May 2008 18:29:07 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > Somehow the spidev code forgot to include a critical mechanism:
> > when the underlying device is removed (e.g. spi_master rmmod),
> > open file descriptors must be prevented from issuing new I/O
> > requests to that device.  On penalty of the oopsing reported
> > by Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org> ...
> > 
> > This is a partial fix, adding handshaking between the lower
> > level (SPI messaging) and the file operations using the spi_dev.
> > There's still a refcounting issue to be addressed (separately)
> > with respect to the spidev_data itself.
> > 
> 
> For 2.6.26, I assume?

Yes please.


> > +static inline int
> > +spidev_sync_write(struct spidev_data *spidev, size_t len)
> > +static inline int
> > +spidev_sync_read(struct spidev_data *spidev, size_t len)
> 
> These strictly should return a ssize_t.

True, but this was cut/paste from spi_write()/spi_read() which
have that same issue.  Should you feel compelled to fix that,
go ahead ... else I (or someone) will get to it "someday".


> The inlining is wrong+pointless, but I appear to be losing that struggle.

I wish it actually *were* pointless, but the last several times
I've had occasion to look at what current GCCs do I've observed
that it's doing the Stupid Thing.

The short version of the story is that GCC inlining heuristics
are still goofed.  I've seen a few cases where GCC 4.3 does it
better, some where it has significant regressions ... it depends
partly on what processor you're using.  It's vaguely possible it's
OK for x86, but it's clearly more miss than hit on several other
processors.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
