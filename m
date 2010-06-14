From: Brian Niebuhr <BNiebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Subject: RE: [PATCH 3/3] davinci: spi: modify platform data for updated
	SPIdriver
Date: Mon, 14 Jun 2010 14:13:31 -0500
Message-ID: <BA34378D1528D04CB3C865B8BAB2472B024CC9@transmx01.transcrypt.local>
References: <1275923348-8533-1-git-send-email-bniebuhr@efjohnson.com>	<1275923348-8533-2-git-send-email-bniebuhr@efjohnson.com>	<1275923348-8533-3-git-send-email-bniebuhr@efjohnson.com><1275923348-8533-4-git-send-email-bniebuhr@efjohnson.com>
	<004701cb087a$6cb51470$461f3d50$@raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>,
        <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > diff --git a/arch/arm/mach-davinci/dm365.c 
> b/arch/arm/mach-davinci/dm365.c
> > index a146849..0bd9f93 100644
> > --- a/arch/arm/mach-davinci/dm365.c
> > +++ b/arch/arm/mach-davinci/dm365.c
> > @@ -625,12 +625,6 @@ static u64 dm365_spi0_dma_mask = 
> DMA_BIT_MASK(32);
> >  static struct davinci_spi_platform_data dm365_spi0_pdata = {
> >  	.version 	= SPI_VERSION_1,
> >  	.num_chipselect = 2,
> > -	.clk_internal	= 1,
> > -	.cs_hold	= 1,
> > -	.intr_level	= 0,
> > -	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> 
> polling mode */
> > -	.c2tdelay	= 0,
> > -	.t2cdelay	= 0,
> >  };
> >  
> >  static struct resource dm365_spi0_resources[] = {
> 
> This patch does not contain modifications to resource 
> structure to 'or' the
> IORESOURCE_DMA_RX_CHAN, IORESOURCE_DMA_TX_CHAN and 
> IORESOURCE_DMA_EVENT_Q
> flags with IORESOURCE_DMA. I don't think without this 
> modification driver
> will work.

You are right - my mistake.  I will include that in the next version.  I
assume you added these flags when you were testing?
