From: Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] spi: ti-qspi: Implement the spi_mem interface
Date: Mon, 12 Feb 2018 08:54:42 +0100
Message-ID: <20180212085442.42109296@xps13>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-5-boris.brezillon@bootlin.com>
        <20180211161706.31d0bdc8@xps13>
        <20180211181819.31513336@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180211181819.31513336@bbrezillon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Boris,


> > > @@ -566,6 +567,62 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,
> > >  	return ret;
> > >  }
> > >  
> > > +static int ti_qspi_exec_mem_op(struct spi_mem *mem,
> > > +			       const struct spi_mem_op *op)
> > > +{
> > > +	struct ti_qspi *qspi = spi_master_get_devdata(mem->spi->master);
> > > +	int i, ret = 0;
> > > +	u32 from = 0;
> > > +
> > > +	/* Only optimize read path. */
> > > +	if (!op->data.nbytes || op->data.dir != SPI_MEM_DATA_IN ||
> > > +	    !op->addr.nbytes || op->addr.nbytes > 4)
> > > +		return -ENOTSUPP;
> > > +
> > > +	for (i = 0; i < op->addr.nbytes; i++) {
> > > +		from <<= 8;
> > > +		from |= op->addr.buf[i];
> > > +	}
> > > +
> > > +	/* Address exceeds MMIO window size, fall back to regular mode. */    
> > 
> > I don't understand how do you fall back to regular mode?  
> 
> If you look at spi_mem_exec_op() you'll see that if the controller
> ->exec_op() returns -ENOTSUPP, the function will try to execute the  
> operation using the regular spi_sync() API. I'll try to make it clearer
> in my next iteration.

Ok, I mixed the functions in my head and this answers the below
question as well.

> 
> > Moreover if the
> > purpose of adding this function is to remove spi_flash_read().  
> 
> Sorry, I don't get that one. Yes, the spi_mem_ops interface is here to
> replace the ->spi_flash_xx() one, and that's exactly what I'm doing
> here: porting the existing implementation to the new interface, keeping
> the exact same limitations (only read path is optimized, and the request
> has to fall in the iomem range mapped by the driver).
> 

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
