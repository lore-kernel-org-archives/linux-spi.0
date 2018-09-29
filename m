From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport
 mode
Date: Sat, 29 Sep 2018 17:43:40 +0200
Message-ID: <20180929174340.53290075@bbrezillon>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180921070628.35153-2-chuanhua.han@nxp.com>
        <87y3bkcpym.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Chuanhua Han <chuanhua.han@nxp.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bkcpym.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Esben,

On Sat, 29 Sep 2018 16:56:17 +0200
Esben Haabendal <esben.haabendal@gmail.com> wrote:

> Chuanhua Han <chuanhua.han@nxp.com> writes:
> 
> > This patch fixes the problem that the XSPI mode of the dspi controller
> > cannot transfer data properly.
> > In XSPI mode, cmd_fifo is written before tx_fifo, which transforms the
> > byte order of sending and receiving data.  
> 
> Did you find documentation on proper ordering of writes to related
> TX FIFO and CMD FIFO entries?
> 
> I have failed to find such information, and thus opted for what I
> believed would be the safe approach, writing to TX FIFO first, so that
> when CMD FIFO is written, it will already have data in place.  And it
> seems to work.
> 
> But, I now see that SPIx_SR[TFIWF] hints that it should be done the
> other way around.
> 
>     Tranmit FIFO Invalid Write Flag - Indicates Data Write on TX FIFO
>     while CMD FIFO is empty. Without a Command, the Data entries present
>     in TXFIFO are invalid.
> 
> But I fail to see how that should be related to byte ordering.
> 
> So I believe this patch is doing two things.
> 
> 1. Changing write ordering of TX FIFO and CMD FIFO.
> 2. Handling byte ordering based on SPIx_CTARn[LSBFE] flag.
> 
> It would be nice if we could get clarification from NXP on
> what is the right way to do the TX FIFO and CMD FIFO write ordering.
> 
> But as for the byte ordering changes, I don't think it looks write.  The
> meaning of SPIx_CTARn[LSBFE] is according to the documentaiton the bit
> ordering on the wire, and should not be related to register byte
> ordering.
> 
> You should probably split this patch in two, so they can be reviewed and
> merged independently.

Yes, I forgot to mention that, but this patch should definitely be
split in at least 2 patches.

Regards,

Boris 
