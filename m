From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] spi: ti-qspi: Implement the spi_mem interface
Date: Mon, 12 Feb 2018 13:31:58 +0100
Message-ID: <20180212133158.3032442f@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-5-boris.brezillon@bootlin.com>
        <6a9eaaaf-20a6-b332-03d0-9d16e24d0b3d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6a9eaaaf-20a6-b332-03d0-9d16e24d0b3d-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 12 Feb 2018 17:13:55 +0530
Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:

> On Tuesday 06 February 2018 04:51 AM, Boris Brezillon wrote:
> > From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > 
> > The spi_mem interface is meant to replace the spi_flash_read() one.
> > Implement the ->exec_op() method so that we can smoothly get rid of the
> > old interface.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  drivers/spi/spi-ti-qspi.c | 85 +++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 72 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> > index c24d9b45a27c..40cac3ef6cc9 100644
> > --- a/drivers/spi/spi-ti-qspi.c
> > +++ b/drivers/spi/spi-ti-qspi.c  
> 
> [...]
> 
> > +static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
> > +	.exec_op = ti_qspi_exec_mem_op,  
> 
>        .supports_op = ti_qspi_supports_mem_op,
> 
> Its required as per spi_controller_check_ops() in Patch 1/6

->supports_op() is optional, and if it's missing, the core will do the
regular QuadSPI/DualSPI/SingleSPI check (see spi_mem_supports_op()
implementation). This being said, if you think a custom ->supports_op()
implementation is needed for this controller I can add one.

> 
> > +};
> > +
> >  static int ti_qspi_start_transfer_one(struct spi_master *master,
> >  		struct spi_message *m)
> >  {
> > @@ -673,6 +730,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
> >  	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
> >  				     SPI_BPW_MASK(8);
> >  	master->spi_flash_read = ti_qspi_spi_flash_read;
> > +	master->mem_ops = &ti_qspi_mem_ops;
> >  
> >  	if (!of_property_read_u32(np, "num-cs", &num_cs))
> >  		master->num_chipselect = num_cs;
> > @@ -785,6 +843,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
> >  				 PTR_ERR(qspi->mmap_base));
> >  			qspi->mmap_base = NULL;
> >  			master->spi_flash_read = NULL;
> > +			master->mem_ops = NULL;
> >  		}
> >  	}
> >  	qspi->mmap_enabled = false;
> >   
> 



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
