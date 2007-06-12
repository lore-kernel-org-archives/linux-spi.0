From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 1/4] MMC-over-SPI header updates
Date: Tue, 12 Jun 2007 19:22:41 +0200
Message-ID: <466ED661.1010407@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706101305.53151.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706101305.53151.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> Teach the MMC/SD/SDIO system headers that some hosts use SPI mode
> 
>  - New host capabilities bits
>     * MMC_CAP_SPI, with mmc_host_is_spi() test
>     * MMC_CAP_SPI_CRC, if it's ready to use CRCs
>  
>  - SPI-specific declarations:
>     * Response types, MMC_RSP_SPI_R*
>     * Two SPI-only commands 
>     * Status bits used native to SPI:  R1_SPI_*, R2_SPI_*
> 
>  - Fix a few (unrelated) whitespace bugs in the headers.
> 
> None of these changes affects current code.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> 
> ---
>  include/linux/mmc/core.h |   21 ++++++++++++++++++--
>  include/linux/mmc/host.h |    4 +++
>  include/linux/mmc/mmc.h  |   48 ++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 64 insertions(+), 9 deletions(-)
> 
> --- pxa.orig/include/linux/mmc/host.h	2007-06-06 16:48:44.000000000 -0700
> +++ pxa/include/linux/mmc/host.h	2007-06-10 13:00:23.000000000 -0700
> @@ -90,6 +90,8 @@ struct mmc_host {
>  #define MMC_CAP_BYTEBLOCK	(1 << 2)	/* Can do non-log2 block sizes */
>  #define MMC_CAP_MMC_HIGHSPEED	(1 << 3)	/* Can do MMC high-speed timing */
>  #define MMC_CAP_SD_HIGHSPEED	(1 << 4)	/* Can do SD high-speed timing */
> +#define MMC_CAP_SPI		(1 << 5)	/* Talks only SPI protocols */
> +#define MMC_CAP_SPI_CRC		(1 << 6)	/* Handles CRC option in SPI */
>  
>  	/* host specific block data */
>  	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */

I still don't see the point of the SPI_CRC cap. It's not like we will have
multiple SPI host drivers, so either we support CRC or we don't. No need to have
this dynamic.

>  
> +#define MMC_RSP_SPI_S1	(1 << 7)		/* one status byte */
> +#define MMC_RSP_SPI_S2	(1 << 8)		/* second status byte */
> +#define MMC_RSP_SPI_OCR	(1 << 9)		/* OCR */
> +

You should describe form, not contents. The host driver shouldn't care what's in
the chunks, only how they need to be transferred. So size and things like CRC,
but not their meaning.

>  
> +#define R1_STATE_IDLE		0		/* resetting; maybe opendrain */
> +#define R1_STATE_READY		1		/* opendrain; ident soon */
> +#define R1_STATE_IDENT		2		/* opendrain; setaddr soon */
> +#define R1_STATE_STBY		3		/* addressed, ready to use */
> +#define R1_STATE_TRAN		4
> +#define R1_STATE_DATA		5
> +#define R1_STATE_RCV		6
> +#define R1_STATE_PRG		7
> +#define R1_STATE_DIS		8
> +#define R1_STATE(x)		(((x) & 0xf) << 9)
> +

This seems to be for the mapping voodoo in the spi host. And that is not
something we want, so this is not needed.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
