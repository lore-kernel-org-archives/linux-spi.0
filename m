From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] FSL eSPI driver: fix byte-vs-character and receive
	buffer problems
Date: Tue, 19 Jul 2011 13:23:00 -0600
Message-ID: <20110719192300.GF6848@ponder.secretlab.ca>
References: <60740d4b3d09a322a975.1311078082@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: derek.kwindt-cfy2TCaE7SFv+uJa97DSA9BPR1lH4CV8@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	ronny.meeus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Thomas De Schampheleire <patrickdepinguin+spidevel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <60740d4b3d09a322a975.1311078082-bi+AKbBUZKagILUCTcTcHdKyNwTtLsGr@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 19, 2011 at 02:21:22PM +0200, Thomas De Schampheleire wrote:
> The Freescale eSPI driver has several problems related to transaction
> counting and receive buffer offset.
> - The len field in struct spi_transfer is counted in bytes, while the TRANLEN
>   field in the eSPI controller is counted in characters. The relation between
>   both is given by the bits_per_word variable. The original driver always
>   used t->len for TRANLEN, which is not correct when bits_per_word is larger
>   than 8.
> - The interrupt handler allowed the remaining bytes (mspi->len) to become
>   negative, due to an unconditional -4 even when the number of bytes received
>   was less. Additionally, the interrupt handler incorrectly assumed that with
>   each interrupt only one character was transmitted. This was not the case
>   since fsl_espi_cpu_bufs() always transmits in blocks of 32 bit, which is
>   always more than one character (the exact number depending on
>   bits_per_word).
> - In fsl_espi_do_one_msg(), the driver sets the length of the transfer being
>   prepared as (n_tx + n_rx), which is incorrect since these are full-duplex
>   transactions. Moreover, the bytes received from the controller where written
>   at the wrong offset in the driver's receive buffer. Specifically, they were
>   written n_tx too far.
> 
> Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
> 
> Note that this patch is against an earlier version of the eSPI driver than the
> one which is currently in the Linux tree. The aspects of the driver that I changed
> are still relevant for the new version though.
> I would like to get some feedback from the original author (Mingkai Hu) or
> others, to verify my changes in other conditions. I have tested 8 and 16 bit
> transfers on a temperature sensor and an EEPROM device, but do not have
> devices accepting other bits_per_word values.

Okay, I'll ignore this patch then until you get some feedback and
rebase it to the current state of the driver.

g.

> 
> 
>  spi_fsl_espi.c |   37 +++++++++++++++++++++++++------------
>  spi_fsl_lib.h  |    1 +
>  2 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/spi/spi_fsl_espi.c b/drivers/spi/spi_fsl_espi.c
> --- a/drivers/spi/spi_fsl_espi.c
> +++ b/drivers/spi/spi_fsl_espi.c
> @@ -212,7 +212,7 @@
>  			    bool is_dma_mapped)
>  {
>  	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
> -	unsigned int len = t->len;
> +	unsigned int count;
>  	u8 bits_per_word;
>  	int ret;
>  
> @@ -221,23 +221,31 @@
>  		bits_per_word = t->bits_per_word;
>  
>  	mpc8xxx_spi->len = t->len;
> -	len = roundup(len, 4) / 4;
> -
>  	mpc8xxx_spi->tx = t->tx_buf;
>  	mpc8xxx_spi->rx = t->rx_buf;
> +	mpc8xxx_spi->bits_per_word = bits_per_word;
>  
>  	INIT_COMPLETION(mpc8xxx_spi->done);
>  
> +	/* Convert between t->len (in bytes) and count (in characters) */
> +	if (bits_per_word <= 8) {
> +		count = t->len;
> +	} else if (bits_per_word <= 16) {
> +		count = t->len >> 1;
> +	} else {
> +		return -EINVAL;
> +	}
> +
>  	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
> -	if ((t->len - 1) > SPCOM_TRANLEN_MAX) {
> +	if ((count - 1) > SPCOM_TRANLEN_MAX) {
>  		dev_err(mpc8xxx_spi->dev, "Transaction length (%d)"
> -				" beyond the SPCOM[TRANLEN] field\n", t->len);
> +				" beyond the SPCOM[TRANLEN] field\n", count);
>  		return -EINVAL;
>  	}
>  	mpc8xxx_spi_write_reg(&mpc8xxx_spi->espi_base->command,
> -		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
> +		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(count - 1)));
>  
> -	ret = fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
> +	ret = fsl_espi_cpu_bufs(mpc8xxx_spi, t, count);
>  	if (ret)
>  		return ret;
>  
> @@ -301,7 +309,7 @@
>  		}
>  	}
>  
> -	trans.len = n_tx + n_rx;
> +	trans.len = n_tx;
>  	trans.tx_buf = local_buf;
>  	trans.rx_buf = local_buf + n_tx;
>  	spi_message_add_tail(&trans, &message);
> @@ -324,7 +332,7 @@
>  		m->actual_length += t->len;
>  
>  		if (rx_buf)
> -			memcpy(rx_buf, t->rx_buf + n_tx, n_rx);
> +			memcpy(rx_buf, t->rx_buf, n_rx);
>  
>  		if (t->delay_usecs)
>  			udelay(t->delay_usecs);
> @@ -402,6 +410,7 @@
>  		if (mspi->len >= 4) {
>  			rx_data = mpc8xxx_spi_read_reg(
>  					&mspi->espi_base->receive);
> +			mspi->len -= 4;
>  		} else {
>  			tmp = mspi->len;
>  			rx_data = 0;
> @@ -412,10 +421,9 @@
>  			}
>  
>  			rx_data <<= (4 - mspi->len) * 8;
> +			mspi->len = 0;
>  		}
>  
> -		mspi->len -= 4;
> -
>  		if (mspi->rx)
>  			mspi->get_rx(rx_data, mspi);
>  	}
> @@ -430,7 +438,12 @@
>  	/* Clear the events */
>  	mpc8xxx_spi_write_reg(&mspi->espi_base->event, events);
>  
> -	mspi->count -= 1;
> +	if (mspi->bits_per_word <= 8) {
> +		mspi->count = mspi->len;
> +	} else if (mspi->bits_per_word <= 16) {
> +		mspi->count = mspi->len >> 1;
> +	}
> +
>  	if (mspi->count) {
>  		u32 word = mspi->get_tx(mspi);
>  
> diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> --- a/drivers/spi/spi_fsl_lib.h
> +++ b/drivers/spi/spi_fsl_lib.h
> @@ -56,6 +56,7 @@
>  	void (*spi_remove) (struct mpc8xxx_spi *mspi);
>  
>  	unsigned int count;
> +	u8 bits_per_word;
>  	unsigned int irq;
>  
>  	unsigned nsecs;		/* (clock cycle time)/2 */
> 
> ------------------------------------------------------------------------------
> Magic Quadrant for Content-Aware Data Loss Prevention
> Research study explores the data loss prevention market. Includes in-depth
> analysis on the changes within the DLP market, and the criteria used to
> evaluate the strengths and weaknesses of these DLP solutions.
> http://www.accelacomm.com/jaw/sfnl/114/51385063/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------------------------------------------------------------------------------
Magic Quadrant for Content-Aware Data Loss Prevention
Research study explores the data loss prevention market. Includes in-depth
analysis on the changes within the DLP market, and the criteria used to
evaluate the strengths and weaknesses of these DLP solutions.
http://www.accelacomm.com/jaw/sfnl/114/51385063/
