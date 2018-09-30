From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of
 undefined bitmask for rxdata
Date: Sun, 30 Sep 2018 12:41:51 +0200
Message-ID: <20180930124151.7ffed180@bbrezillon>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-2-chuanhua.han@nxp.com>
        <20180930120659.71b0e1e5@bbrezillon>
        <AM0PR04MB4353B48117292E511AC1E09F97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
        <20180930121707.4724edd6@bbrezillon>
        <877ej36zkd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Chuanhua Han <chuanhua.han@nxp.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Esben Haabendal <esben.haabendal@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877ej36zkd.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, 30 Sep 2018 12:37:38 +0200
Esben Haabendal <esben.haabendal@gmail.com> wrote:

> Boris Brezillon <boris.brezillon@bootlin.com> writes:
> 
> > On Sun, 30 Sep 2018 10:10:14 +0000
> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
> >  
> >> > -----Original Message-----
> >> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> >> > Sent: 2018年9月30日 18:07
> >> > To: Chuanhua Han <chuanhua.han@nxp.com>
> >> > Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
> >> > linux-kernel@vger.kernel.org; eha@deif.com
> >> > Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of
> >> > undefined bitmask for rxdata
> >> > 
> >> > On Sun, 30 Sep 2018 17:25:33 +0800
> >> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
> >> >     
> >> > > This patch fixes the problem of rxdata being equal to 0 during the
> >> > > XSPI mode transfer of the dspi controller.
> >> > > In XSPI mode, If it is not deleted, the value of rxdata will be equal
> >> > > to 0, and the data received will not be received correctly, causing
> >> > > the receiving transfer of the spi to fail.
> >> > >
> >> > > Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> >> > > ---
> >> > > Changes in v2:
> >> > >  -The original patch is divided into multiple patches(the original
> >> > > patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> >> > > mode"),one of which is segmented.
> >> > >
> >> > >  drivers/spi/spi-fsl-dspi.c | 3 ---
> >> > >  1 file changed, 3 deletions(-)
> >> > >
> >> > > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> >> > > index 3082e72e4f6c..4dc1064bf408 100644
> >> > > --- a/drivers/spi/spi-fsl-dspi.c
> >> > > +++ b/drivers/spi/spi-fsl-dspi.c
> >> > > @@ -243,9 +243,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32    
> >> > rxdata)    
> >> > >  	if (!dspi->rx)
> >> > >  		return;
> >> > >
> >> > > -	/* Mask of undefined bits */
> >> > > -	rxdata &= (1 << dspi->bits_per_word) - 1;
> >> > > -    
> >> > 
> >> > Why not    
> >> In xspi mode, the value of rxdata after the statement is processed is equal
> >> to 0 no matter what data is received.  
> >
> > Only if dspi->bits_per_word is 0.
> >
> > Actually, I just had a look, and xfer->bits_per_word should never be 0
> > because spi_validate() makes sure it's initialized [1]. Don't know
> > where dpsi->bits_per_word comes from, but maybe you have a problem
> > there (dpsi->bits_per_word and xfer->bits_per_word not in sync).
> >
> > [1]https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi.c#L2869  
> 
> dspi->bits_per_word = xfer->bits_per_word
> 
> https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi-fsl-dspi.c#L697
> 
> So it should never be out of sync, and it should never be 0.
> 
> As I mentioned in another mail, I suspect what Han is observing is
> caused by byte ordering, so that the mask masks the wrong data.
> Maybe related to the byte-ordering fix patch.

Okay. Wait and see then.
