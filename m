From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/3] [SPI] Sync spidev.{h,
	c} with spi.h
Date: Thu, 26 Jul 2007 20:02:02 -0700
Message-ID: <200707262002.02677.david-b@pacbell.net>
References: <20070726134754.GA3539@localhost.localdomain>
	<20070726135041.GA5550@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070726135041.GA5550-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

On Thursday 26 July 2007, Anton Vorontsov wrote:
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -56,8 +56,8 @@ static unsigned long	minors[N_SPI_MINORS / BITS_PER_LONG];
>  
>  
>  /* Bit masks for spi_device.mode management */
> -#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL)
> -
> +#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | \
> +					 SPI_LSB_FIRST | SPI_3WIRE)

Hmm, I seem to recall explicitly leaving out CS_HIGH on the grounds
that getting it wrong could corrupt the whole bus; Not Good (tm).
And the same argument can apply to 3WIRE mode ...

On the other hand, that's not necessarily a good reason, since there
are other ways to trash hardware too.

Comments anyone?

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
