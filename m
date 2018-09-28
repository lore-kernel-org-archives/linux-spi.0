From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Fri, 28 Sep 2018 09:18:33 +0200
Message-ID: <20180928091833.15e95f7f@bbrezillon>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 28 Sep 2018 06:59:58 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > 
> > It's still unclear why you need to specify a bits_per_word value,
> > but if this is needed, it's probably something you want to add to
> > spi.c, when a message is queued.  
> To specify a specific bits_per_word to be able to use the xspi
> (32bit) mode of the fsl_dspi module to transfer data, you can look at
> my PATCH 2/2. Do not add a value in spis.c that takes into account
> that the value assigned to bits_per_word is decided before the
> transfer. Thanks for your check and reply!

I might be wrong, but that's not my understanding of ->bits_per_word.
To me, it's something that you can use when your *device* (not
controller) expects non-byte aligned words [1]. The spi-mem protocol is
definitely designed to work with 1byte large words, so, as I said, I
suspect you're abusing xfer->bits_per_word to address a controller
driver issue.

[1]https://elixir.bootlin.com/linux/latest/source/include/linux/spi/spi.h#L114
