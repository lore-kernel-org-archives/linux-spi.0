From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 5/6] mtd: spi-nor: Use the spi_mem_xx() API
Date: Mon, 12 Feb 2018 13:32:41 +0100
Message-ID: <20180212133241.4008202d@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-6-boris.brezillon@bootlin.com>
        <933bd372-8b75-183f-0b03-563cabbbcc68@ti.com>
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
In-Reply-To: <933bd372-8b75-183f-0b03-563cabbbcc68-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 12 Feb 2018 17:14:21 +0530
Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:

> On Tuesday 06 February 2018 04:51 AM, Boris Brezillon wrote:
> > From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > 
> > The spi_mem_xxx() API has been introduced to replace the
> > spi_flash_read() one. Make use of it so we can get rid of
> > spi_flash_read().
> > 
> > Note that using spi_mem_xx() also simplifies the code because this API
> > takes care of using the regular spi_sync() interface when the optimized  
> > ->mem_ops interface is not implemented by the controller.  
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---  
> [...]
> >  /*
> > @@ -138,92 +121,42 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
> >  			   u_char *buf)
> >  {
> >  	struct m25p *flash = nor->priv;
> > -	struct spi_device *spi = flash->spi;
> > -	unsigned int inst_nbits, addr_nbits, data_nbits, data_idx;
> > -	struct spi_transfer t[3];
> > -	struct spi_message m;
> > -	unsigned int dummy = nor->read_dummy;
> > -	ssize_t ret;
> > -	int cmd_sz;
> > +	u8 addrs[4];
> > +	struct spi_mem_op op =
> > +			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
> > +				   SPI_MEM_OP_ADDRS(nor->addr_width, addrs, 1),
> > +				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
> > +				   SPI_MEM_OP_DATA_OUT(len, buf, 1));  
> 
> 					^^^^ SPI_MEM_OP_DATA_IN

Nice catch! I'll fix that in v2.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
