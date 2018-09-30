From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Sun, 30 Sep 2018 12:17:34 +0200
Message-ID: <87o9cf70ht.fsf@gmail.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930120425.7715cb29@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Chuanhua Han <chuanhua.han@nxp.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930120425.7715cb29@bbrezillon> (Boris Brezillon's message
        of "Sun, 30 Sep 2018 12:04:25 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> Hi Chuanhua,
>
> On Sun, 30 Sep 2018 17:25:32 +0800
> Chuanhua Han <chuanhua.han@nxp.com> wrote:
>
>> Before we add this spi_transfer to the spi_message chain table, we need
>> bits_per_word_mask based on spi_control to set the bits_per_word of
>> this spi_transfer.
>
> Let's make it clearer: this is wrong. The spi-mem protocol is just
> using bytes, not custom size words. Fix the fsl-dspi driver if needed,
> but don't try to adjust xfer->bits_per_word in spi-mem.c, because this
> is inappropriate.

I don't think there is a "fix" needed in fsl-dspi driver for this.

I am not sure, but I think that what Han is trying to achieve here is
better performance.
And wile the XSPI mode does provide better performance for sending one
32 bit word, than normal mode providees for sending 4 x 8 bit words.
But as you say, this is wrong.

To improve performance, the fsl-dspi driver should be fixed to work in
DMA mode.  Implementation of erratum A-011218 is necessary in order to
use DSPI DMA mode on LS1021A.
I was planning to work on that, but haven't had the time for it.
So if you want better performance for spi-mem on LS1021A DSPI, please
work on this.

/Esben
