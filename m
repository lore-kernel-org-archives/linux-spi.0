From: "Joakim Tjernlund" <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi_mpc83xx.c,
	support QE enabled 83xx CPU's like	mpc832x
Date: Sat, 30 Jun 2007 17:17:11 +0200
Message-ID: <004f01c7bb29$bbb7b2e0$0e67a8c0@Jocke>
References: <200706300811.56870.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706300811.56870.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

 

> -----Original Message-----
> From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org] 
> Sent: den 30 juni 2007 17:12
> To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
> joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
> Subject: Re: [spi-devel-general] [PATCH] spi_mpc83xx.c, 
> support QE enabled 83xx CPU's like mpc832x
> 
> On Saturday 30 June 2007, Joakim Tjernlund wrote:
> 
> > @@ -197,12 +203,22 @@ int mpc83xx_spi_setup_transfer(struct 
> spi_device *spi, struct spi_transfer *t)
> >  	    || ((bits_per_word > 16) && (bits_per_word != 32)))
> >  		return -EINVAL;
> >  
> > +	mpc83xx_spi->rx_shift = 0;
> > +	mpc83xx_spi->tx_shift = 0;
> >  	if (bits_per_word <= 8) {
> >  		mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
> >  		mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
> > +		if (mpc83xx_spi->qe_mode) {
> > +			mpc83xx_spi->rx_shift = 16;
> 
> This shouldn't be "8" or "24"?

No :)
This SPI HW looks more and more like a design mistake. :(

> 
> > +			mpc83xx_spi->tx_shift = 24;
> > +		}
> 
> ... I got the update with the missing header file.

Good

 Jocke


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
