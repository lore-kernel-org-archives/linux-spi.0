From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Sun, 30 Sep 2018 12:40:08 +0200
Message-ID: <20180930124008.365831bf@bbrezillon>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930120425.7715cb29@bbrezillon>
        <AM0PR04MB4353635C85F0D744D090A14C97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB4353635C85F0D744D090A14C97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, 30 Sep 2018 10:18:18 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > Sent: 2018年9月30日 18:04
> > To: Chuanhua Han <chuanhua.han@nxp.com>
> > Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; eha@deif.com
> > Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
> > 
> > Hi Chuanhua,
> > 
> > On Sun, 30 Sep 2018 17:25:32 +0800
> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
> >   
> > > Before we add this spi_transfer to the spi_message chain table, we
> > > need bits_per_word_mask based on spi_control to set the bits_per_word
> > > of this spi_transfer.  
> > 
> > Let's make it clearer: this is wrong. The spi-mem protocol is just using bytes,
> > not custom size words. Fix the fsl-dspi driver if needed, but don't try to adjust
> > xfer->bits_per_word in spi-mem.c, because this is inappropriate.  
> The value of bits_per_word is only known before the spi_message_add_tail function is called,

No, it's not. It's known from the beginning, and spi_setup() defaults
to 8 when spidev->bits_per_word is 0, which is exactly what we
want. Then, when you send a message through, spi_sync(), spi_validate()
makes sure that each transfer in the message has a
xfer->bits_per_word != 0 and when that's not the case, it sets it to
spi->bits_per_word [2].

Really, there's nothing to fix in spi-mem.c, because it's already doing
the right thing (leaving ->bits_per_word to 0 so that it's set to
spi->bits_per_word, which should be 8). Maybe we have a bug somewhere
else though.

[1]https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi.c#L2803
[2]https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi.c#L2869
