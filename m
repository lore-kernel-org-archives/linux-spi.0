From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi.h: add missing kernel-doc for
	struct spi_master
Date: Fri, 3 Jul 2009 14:20:43 -0700
Message-ID: <200907031420.43519.david-b@pacbell.net>
References: <20090703131108.4046ab24.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090703131108.4046ab24.randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
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

On Friday 03 July 2009, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> Add missing kernel-doc notation in spi.h for struct spi_master:
> 
> Warning(include/linux/spi/spi.h:289): No description found for parameter 'mode_bits'
> Warning(include/linux/spi/spi.h:289): No description found for parameter 'flags'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


> ---
>  include/linux/spi/spi.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-2.6.31-rc1-git10.orig/include/linux/spi/spi.h
> +++ linux-2.6.31-rc1-git10/include/linux/spi/spi.h
> @@ -207,6 +207,8 @@ static inline void spi_unregister_driver
>   *	each slave has a chipselect signal, but it's common that not
>   *	every chipselect is connected to a slave.
>   * @dma_alignment: SPI controller constraint on DMA buffers alignment.
> + * @mode_bits: flags understood by this controller driver
> + * @flags: other constraints relevant to this driver
>   * @setup: updates the device mode and clocking records used by a
>   *	device's SPI controller; protocol code may call this.  This
>   *	must fail if an unrecognized or unsupported mode is requested.
> 
> 
> 
> 
> ---
> ~Randy
> LPC 2009, Sept. 23-25, Portland, Oregon
> http://linuxplumbersconf.org/2009/
> 
> 



------------------------------------------------------------------------------
