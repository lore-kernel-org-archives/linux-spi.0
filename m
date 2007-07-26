From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 1/4] MMC headers learn
	about SPI
Date: Thu, 26 Jul 2007 18:31:50 +0200
Message-ID: <20070726183150.024930aa@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200707141506.00262.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707141506.00262.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Sat, 14 Jul 2007 15:05:59 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> @@ -115,14 +116,16 @@ struct mmc_host {
>  	wait_queue_head_t	wq;
>  	unsigned int		claimed:1;	/* host exclusively claimed */
>  
> -	struct delayed_work	detect;
> +	unsigned int		use_spi_crc:1;
> +
>  #ifdef CONFIG_MMC_DEBUG
>  	unsigned int		removed:1;	/* host is being removed */
>  #endif
> +	unsigned int		bus_dead:1;	/* bus has been released */
> +	struct delayed_work	detect;
>  
>  	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
>  	unsigned int		bus_refs;	/* reference counter */
> -	unsigned int		bus_dead:1;	/* bus has been released */
>  
>  	unsigned long		private[0] ____cacheline_aligned;
>  };

Some needless shuffling of existing members here.

> @@ -47,6 +52,20 @@ struct mmc_command {
>  #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
>  
>  /*
> + * These are the SPI response types for MMC and SD cards (not SDIO).
> + * Commands return R1, with maybe more info.  Zero is an error type;
> + * callers must always provide the appropriate MMC_RSP_SPI_Rx flags.
> + */
> +#define MMC_RSP_SPI_R1	(MMC_RSP_SPI_S1)
> +#define MMC_RSP_SPI_R1B	(MMC_RSP_SPI_S1|MMC_RSP_BUSY)

I think it's probably safe to keep the two response types separate, even though it is very unlikely that we'll have a command that only uses busy signalling in one of the modes.

Other than that, it looks fine.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
