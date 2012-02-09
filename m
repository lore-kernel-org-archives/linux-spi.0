From: Barry Song <Barry.Song@csr.com>
Subject: RE: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
Date: Thu, 9 Feb 2012 03:38:15 +0000
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E99CB90C53@SHAASIEXM01.ASIA.ROOT.PRI>
References: <1328717446-4526-1-git-send-email-21cnbao@gmail.com>
 <20120208162639.GJ15647@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 DL-SHA-WorkGroupLinux <Workgroup.Linux@csr.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Zhiwu Song <Zhiwu.Song@csr.com>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Barry Song
 <21cnbao@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120208162639.GJ15647@game.jcrosoft.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj@jcrosoft.com]
> Sent: Thursday, February 09, 2012 12:27 AM
> To: Barry Song
> Cc: grant.likely@secretlab.ca; spi-devel-general@lists.sourceforge.net; Barry
> Song; linux-arm-kernel@lists.infradead.org; DL-SHA-WorkGroupLinux; Zhiwu
> Song
> Subject: Re: [PATCH v3] SPI: add CSR SiRFprimaII SPI controller driver
> 
>  +
> > +static int spi_sirfsoc_setup(struct spi_device *spi)
> > +{
> > +	struct spi_bitbang *bitbang;
> > +	struct sirfsoc_spi *sspi;
> > +
> > +	if (!spi->max_speed_hz)
> > +		return -EINVAL;
> > +
> > +	sspi = spi_master_get_devdata(spi->master);
> > +	bitbang = &sspi->bitbang;
> why do you need this?

Jean, thanks! it is redundant code which misses cleanup. I'd like to wait whether Grant has more feedback and fix those together with this one.

> > +
> > +	if (!spi->bits_per_word)
> > +		spi->bits_per_word = 8;
> > +
> > +	return spi_sirfsoc_setup_transfer(spi, NULL);
> > +}
> 
> Best Regards,
> J.

-barry



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
