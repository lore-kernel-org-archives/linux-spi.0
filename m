From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Date: Thu, 31 Jan 2019 14:12:35 +0100
Message-ID: <20190131141235.418e8e9c@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-10-tudor.ambarus@microchip.com>
        <20190131125504.3eff449d@bbrezillon>
        <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 31 Jan 2019 12:40:04 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 01/31/2019 01:55 PM, Boris Brezillon wrote:
> > On Wed, 30 Jan 2019 15:08:47 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> +
> >> +static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
> >> +				      const struct spi_mem_op *op,
> >> +				      struct atmel_qspi_cfg *cfg)
> >> +{
> >> +	int ret = atmel_qspi_set_mode(cfg, op);
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
> >> +
> >> +	if (!op->addr.nbytes) {
> >> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
> >> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> >> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
> >> +		else
> >> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> >> +	} else {
> >> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;  
> > 
> > Why do you use a MEM transfer here? What's the difference with a
> > regular transfer?  
> 
> QSPI_IFR_TFRTYP_TRSFR_MEM must be set when one wants to read/write in the serial
> memory, and particularly a memory data.
> 
> QSPI_IFR_TFRTYP_TRSFR_REG must be set when one wants to read or write to serial
> memory, but not a memory data.
> Read examples: JEDEC_ID or QSPI_SR
> Write examples: writing the configuration or the QSPI_SR.
> 
> Does this answers your question?

Not really :-). From the SPI bus perspective, there's no difference
between a read/write from/to actual memory blocks or a read/write
reg/param-page, so there must be something different on the controller
side. I think regular transfers should work for anything, which is why
I initially suggested to use that in the ->exec_op() implementation.
If memory accesses are optimized somehow and do not work for all
accesses, then we should keep them for the dirmap implementation.

After reading the sama5d2 datasheet, I have the feeling that the only
difference is the fact that the address is directly extracted from the
AHB window offset when using mem accesses (instead of being taken from
the IAR register), plus the possibility to enable the data
scrambler/randomize.
