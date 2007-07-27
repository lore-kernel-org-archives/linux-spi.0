From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
Date: Thu, 26 Jul 2007 20:07:07 -0700
Message-ID: <200707262007.07537.david-b@pacbell.net>
References: <20070726134754.GA3539@localhost.localdomain>
	<20070726135051.GB5550@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070726135051.GB5550-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
> Loopback mode is supported by various controllers, this mode
> is useful for testing, especially in conjunction with spidev
> driver.

ISTR that Stephen Street provided a loopback mode for debug
in his pxa2xx_spi code.  And I know you're fight that this
mode shows up in a lot of hardware.

Comments, anyone?  This seems like a fair way to expose this
mechanism.  And I tend to agree that it'd mostly be useful in
conjunction with "spidev".

Anton -- assuming this goes in, it'd be nice if you could
contribute a simple test program using this, which we could
keep in Documentation/spi somewhere.  (Maybe with other testing
notes, if anyone comes up with such.)

- Dave


>	...
>
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -77,6 +77,7 @@ struct spi_device {
>  #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
>  #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
>  #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
> +#define	SPI_LOOP	0x20			/* loopback mode */
>  	u8			bits_per_word;
>  	int			irq;
>  	void			*controller_state;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
