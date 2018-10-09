From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Tue, 09 Oct 2018 15:50:45 +0200
Message-ID: <87o9c32pqi.fsf@gmail.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20181009120522.6b2bd15a@bbrezillon>
        <20181009103328.GA20774@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Chuanhua Han <chuanhua.han@nxp.com>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009103328.GA20774@sirena.org.uk> (Mark Brown's message of
        "Tue, 9 Oct 2018 11:33:28 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Tue, Oct 09, 2018 at 12:05:22PM +0200, Boris Brezillon wrote:
>> On Tue, 9 Oct 2018 09:52:23 +0000
>> Chuanhua Han <chuanhua.han@nxp.com> wrote:
>
>> > 1. In the dspi driver (spi controller), bits_per_word
>> > (dspi->bits_per_word = transfer->bits_per_word) passed from the upper
>> > layer (spi-mem.c) is used. In this way, I can only assign the
>> > appropriate value of transfer->bits_per_word before passing to the
>> > controller, that is, the controller driver does not know the value of
>> > bits_per_word, and it will use this value when the upper level sets
>> > what value is passed.
>
>> I think you're missing my point: ->bits_per_word is not what you're
>> looking for if what you're trying to do is use 32-bits accesses when
>> things are properly aligned.
>
> To be clear: bits_per_word affects what goes out on the SPI bus (4 byte
> words swapped to be in MSB first order), it needn't have any effect on
> on what goes on inside the SoC - many controllers fill their FIFO in 32
> bit blocks even when sending 8 bit SPI words.

Exactly.

I believe behind all the confusion here, is the fact that the current
spi-fsl-dspi.c driver does not utilize all the possible features of the
DSPI controller.

1. DMA support requires a nasty workaround before it can be enabled for
   LS1021A.
2. EOQ mode is not enabled (and not tested) for some platforms which
   might actually support it.
3. Cyclic command transfer is not implemented.

So in order to improve performance on LS1021A, I propose to do work on
above issues.  I believe the performance improvement that can be gained
is likely to be biggest for 1 (DMA support), and smallest for 3 (cyclic
command transfer).

I don't have access to any coldfire boards, so I haven't tested EOQ mode
(it is only enabled for coldfire currently), so I cannot really know if
there are some bugs hiding there.

/Esben
