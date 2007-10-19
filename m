From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC,
	PATCH] SPI: fix return value for spi_read and spi_write
Date: Fri, 19 Oct 2007 10:16:19 -0700
Message-ID: <20071019171619.ADB4C23BF09@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200710181840.38821.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, marc.pignat-7TsPiqsLilE@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200710181840.38821.marc.pignat-7TsPiqsLilE@public.gmane.org>
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

> From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
> Date: Thu, 18 Oct 2007 18:40:38 +0200
>
> spi_read and spi_write functions don't report late errors, for
> instance fifo underrun.
>
> Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
>
> ---

Seems right to me.  This aspect of the spi_sync() calling
convention can be annoying and error-prone.  I've sometimes
thought about changing that instead of auditing all callers.

Are there any comments from others on this list?  Which
approach would be preferred:  fixing callers (this is at
least a partial fix for that) or updating spi_sync() so
that callers don't need to check m->status?

- Dave


> --- include/linux/spi/spi.h.orig	2007-10-18 18:24:15.000000000 +0200
> +++ include/linux/spi/spi.h	2007-10-18 18:38:10.000000000 +0200
> @@ -593,6 +593,7 @@ extern int spi_sync(struct spi_device *s
>  static inline int
>  spi_write(struct spi_device *spi, const u8 *buf, size_t len)
>  {
> +	int status;
>  	struct spi_transfer	t = {
>  			.tx_buf		= buf,
>  			.len		= len,
> @@ -601,7 +602,10 @@ spi_write(struct spi_device *spi, const 
>  
>  	spi_message_init(&m);
>  	spi_message_add_tail(&t, &m);
> -	return spi_sync(spi, &m);
> +
> +	status = spi_sync(spi, &m);
> +
> +	return (status) ? status : m.status;
>  }
>  
>  /**
> @@ -617,6 +621,7 @@ spi_write(struct spi_device *spi, const 
>  static inline int
>  spi_read(struct spi_device *spi, u8 *buf, size_t len)
>  {
> +	int status;
>  	struct spi_transfer	t = {
>  			.rx_buf		= buf,
>  			.len		= len,
> @@ -625,7 +630,10 @@ spi_read(struct spi_device *spi, u8 *buf
>  
>  	spi_message_init(&m);
>  	spi_message_add_tail(&t, &m);
> -	return spi_sync(spi, &m);
> +
> +	status = spi_sync(spi, &m);
> +
> +	return (status) ? status : m.status;
>  }
>  
>  /* this copies txbuf and rxbuf data; for small transfers only! */
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
