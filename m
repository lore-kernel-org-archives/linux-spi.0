From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Date: Mon, 4 Feb 2019 15:37:13 +0100
Message-ID: <20190204153713.2fd02769@bbrezillon>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
        <20190204100910.26701-14-tudor.ambarus@microchip.com>
        <20190204151643.0354180d@bbrezillon>
        <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25f6ee72-e6e1-7014-6e4b-abe0a1a0eebc@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 4 Feb 2019 14:28:27 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >   
> >> +	writel_relaxed(cfg->ifr, aq->regs + QSPI_IFR);
> >> +}  
> > 
> > Hm, so the only difference we have is the RICR vs ICR reg and the
> > APBTFRTYP_READ vs SAMA5D2_WRITE_TRSFR bit. Not sure it deserves
> > creating 2 hooks for that. Can we have something like ->has_ricr in
> > the caps and then have an if/else block directly in
> > atmel_qspi_set_cfg()?
> >   
> 
> Correct. It is a cost of an extra if, I tried to avoid it. I like it better with
> these two hooks, but if you have a strong opinion I'll do it, just confirm it again.

The cost of an indirect call is actually higher than an extra if/else
block. I'm not against paying this extra cost when implementations are
completely different, but that does not seem to be the case here.
Moreover, if you get rid of these hooks, you can also get rid of the
cfg struct.
