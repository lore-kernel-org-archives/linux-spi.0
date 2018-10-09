From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Tue, 09 Oct 2018 12:53:42 +0200
Message-ID: <87y3b72xxl.fsf@gmail.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        (Chuanhua Han's message of "Tue, 9 Oct 2018 09:52:23 +0000")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> 1. In the dspi driver (spi controller), bits_per_word (dspi->bits_per_word =
> transfer->bits_per_word) passed from the upper layer (spi-mem.c) is used.
> In this way, I can only assign the appropriate value of
> transfer->bits_per_word before passing to the controller, that is, the
> controller driver does not
> know the value of bits_per_word, and it will use this value when the upper
> level sets what value is passed.

Yes, the upper layer (spi-mem.c) should set ->bits_per_word according to
how the SPI data is to be transfered on the wire.  In this case (I
haven't looked at spi-mem.c myself), it sounds like the desired value is
8.  So it is set to 8, and that should definitely not be changed by dspi
driver.

> 2. As I understand, bits_per_word does not exist for non-byte alignment, but
> for the need to reserve non-byte transmission mode that meets the
> controller.

Where did you get that understanding from?  The bits_per_word value
defines the word size in bits for all transfers.

> 3. In addition, now the XSPI of dspi cannot transfer data normally, so this
> problem needs to be solved. As for the DMA transfer mode, some colleagues will
> study it.

What do you mean that "XSPI of dspi cannot tranffer data normally"?
What specific problems do you see (with unpatched mainline kernel)?

/Esben
