From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Tue, 9 Oct 2018 12:05:22 +0200
Message-ID: <20181009120522.6b2bd15a@bbrezillon>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 9 Oct 2018 09:52:23 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> 1. In the dspi driver (spi controller), bits_per_word
> (dspi->bits_per_word = transfer->bits_per_word) passed from the upper
> layer (spi-mem.c) is used. In this way, I can only assign the
> appropriate value of transfer->bits_per_word before passing to the
> controller, that is, the controller driver does not know the value of
> bits_per_word, and it will use this value when the upper level sets
> what value is passed.

I think you're missing my point: ->bits_per_word is not what you're
looking for if what you're trying to do is use 32-bits accesses when
things are properly aligned.

> 2. As I understand, bits_per_word does not
> exist for non-byte alignment, but for the need to reserve non-byte
> transmission mode that meets the controller.

Exactly. It's an optimization you have to take care of inside your
driver. The core cannot help you with that.

> 3. In addition, now the
> XSPI of dspi cannot transfer data normally, so this problem needs to
> be solved.

I still don't understand what the problem is.

> As for the DMA transfer mode, some colleagues will study
> it.
