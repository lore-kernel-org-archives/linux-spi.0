From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Date: Sat, 2 Feb 2019 14:30:54 +0100
Message-ID: <20190202143054.4db7c465@bbrezillon>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-14-tudor.ambarus@microchip.com>
        <20190202082910.0e60a757@bbrezillon>
        <57d4d4b2-e765-1255-0b89-a4fd61f6c1e0@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57d4d4b2-e765-1255-0b89-a4fd61f6c1e0@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2 Feb 2019 08:58:25 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >> @@ -117,6 +120,7 @@
> >>  #define QSPI_IFR_CRM                    BIT(14)
> >>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
> >>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> >> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)  
> > 
> > Maybe add a comment saying it's only available on SAM9X60 or prefix it
> > with SAM9X60.  
> 
> I'll add a comment. The macro name is more generic how it is now and can be used
> by future versions of the IP. Hypothetically speaking, if we rename it to
> QSPI_IFR_SAM9x60_TFSFR_READ and other sam9x will come out, then I'll have to
> rename this macro again, to make it more generic.	

Okay.


> >> +static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
> >> +			      const struct spi_mem_op *op,
> >> +			      struct atmel_qspi_cfg *cfg)
> >> +{
> >> +	void __iomem *base = aq->regs;
> >> +	int ret;
> >> +
> >> +	/* Set the QSPI controller in Serial Memory Mode */
> >> +	if (aq->smm != QSPI_MR_SMM) {
> >> +		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);  
> > 
> > 					    aq->reqs +
> > 
> > and you can get rid of base.  
> 
> I will wait your reasons on this, see 3/13

ad->regs is only dereferenced once in this function, so there's even
less reasons to add a local var. 
