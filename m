From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: fix m25p80 when the cs_change
	hint is honored
Date: Tue, 19 May 2009 21:34:14 -0700
Message-ID: <200905192134.14316.david-b@pacbell.net>
References: <1242731340-12160-1-git-send-email-baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1242731340-12160-1-git-send-email-baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
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

On Tuesday 19 May 2009, Baruch Siach wrote:
> The m25p80 driver uses spi_write_then_read() and spi_write() (among others)
> for interaction with the SPI controller. The only way to signal the end of SPI
> transaction to the m25p80 chip according to its datasheet, is to deactivate
> the chip select.  Currently, an SPI master driver that honors the cs_change
> hint may not deactivate the chip select after the transaction when cs_change
> == 0, leading to data corruption.

NAK.  You mis-read the spec.  What controller driver were you using?
That seems to be the source of the bug you're observing.  It's not
terminating a spi_message correctly.

Normal behavior of a spi_message is to keep the chipselect active
during the entire message, then deactivate it after the last transfer.
Setting the cs_change flag *changes* that behavior ... allowing either
(a) brief mid-message deselection, usually to make a message hold a
composite transaction, or else (b) hinting that immediate deselection
isn't neccessary, as a possible performance tweak for some drivers.

Note that while (a) is mandatory -- drivers that can't do it must
reject the messages using it -- (b) is optional.  When the next
message goes to a different device, obviously the chip selection
lines will need to change.

See below for more details:


> Other SPI devices may also be affected by 
> this behaviour.
> 
> Fix this issue, and while at it, also make spi_read() do the same for
> consistency.
> 
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> ---
>  drivers/spi/spi.c       |    1 +
>  include/linux/spi/spi.h |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eba98c..fdcb2e5 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -690,6 +690,7 @@ int spi_write_then_read(struct spi_device *spi,
>  	memcpy(local_buf, txbuf, n_tx);
>  	x[0].tx_buf = local_buf;
>  	x[1].rx_buf = local_buf + n_tx;
> +	x[1].cs_change = 1;

One does *NOT* want to keep the chip selected after the read.


>  
>  	/* do the i/o */
>  	status = spi_sync(spi, &message);
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a0faa18..f709712 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -609,6 +609,7 @@ spi_write(struct spi_device *spi, const u8 *buf, size_t len)
>  	struct spi_transfer	t = {
>  			.tx_buf		= buf,
>  			.len		= len,
> +			.cs_change	= 1,

... or after the write ...

>  		};
>  	struct spi_message	m;
>  
> @@ -633,6 +634,7 @@ spi_read(struct spi_device *spi, u8 *buf, size_t len)
>  	struct spi_transfer	t = {
>  			.rx_buf		= buf,
>  			.len		= len,
> +			.cs_change	= 1,

... or after this read.

Those are all *completely normal* transactions.

- Dave


>  		};
>  	struct spi_message	m;
>  
> -- 
> 1.6.2.4
> 
> 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
