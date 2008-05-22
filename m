From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.26-rc3] spi: remove some spidev
	oops-on-rmmod paths
Date: Wed, 21 May 2008 20:53:27 -0700
Message-ID: <20080521205327.5aa27048.akpm@linux-foundation.org>
References: <200805211829.07189.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200805211829.07189.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 21 May 2008 18:29:07 -0700 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> Somehow the spidev code forgot to include a critical mechanism:
> when the underlying device is removed (e.g. spi_master rmmod),
> open file descriptors must be prevented from issuing new I/O
> requests to that device.  On penalty of the oopsing reported
> by Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org> ...
> 
> This is a partial fix, adding handshaking between the lower
> level (SPI messaging) and the file operations using the spi_dev.
> There's still a refcounting issue to be addressed (separately)
> with respect to the spidev_data itself.
> 

For 2.6.26, I assume?

> +static inline int
> +spidev_sync_write(struct spidev_data *spidev, size_t len)
> +static inline int
> +spidev_sync_read(struct spidev_data *spidev, size_t len)

These strictly should return a ssize_t.

The inlining is wrong+pointless, but I appear to be losing that struggle.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
