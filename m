From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Date: Fri, 1 Feb 2019 16:45:08 +0100
Message-ID: <20190201164508.4d1b214d@bbrezillon>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
        <20190131161515.21605-11-tudor.ambarus@microchip.com>
        <20190131173207.56481a42@bbrezillon>
        <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
        <20190201085739.775add3f@bbrezillon>
        <8b935a95-0aaa-3430-e2c2-f5793fd9cf11@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8b935a95-0aaa-3430-e2c2-f5793fd9cf11@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 1 Feb 2019 14:49:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> 
> >>>> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)  
> > 
> > And this one would be
> > 
> > define QSPI_IFR_SAM9X60_READ_TRSFR		BIT(24)  
> 
> I prefer letting this bit named as in the datasheet, QSPI_IFR_APBTFRTYP_READ,
> and change it if future versions of the IP will modify its sense. It is a READ
> transfer done on APB, it is more generic this way. If you have a strong opinion
> on this, please let me know.

As you wish.
