From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCHv7 1/2] drivers: spi: Add qspi flash controller
Date: Wed, 31 Jul 2013 11:39:29 -0700
Message-ID: <CA+7tXijn2V7LMCKuOKxcda6r6a=JFBeSFNqGqNtYZuTF=irF1g@mail.gmail.com>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com>
	<1375249673-2585-2-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: broonie@kernel.org, spi-devel-general@lists.sourceforge.net,
	grant.likely@linaro.org, linux-omap@vger.kernel.org, balbi@ti.com,
	rnayak@ti.com
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1375249673-2585-2-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 30, 2013 at 10:47 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:
> Test details:
> -------------
> Tested this on dra7 board.
> Test1: Ran mtd_stesstest for 40000 iterations.
>    - All iterations went through without failure.
> Test2: Use mtd utilities:
>   - flash_erase to erase the flash device
>   - nanddump to read data back.
>   - nandwrite to write to the data flash.
>  diff between the write and read data shows zero.

You've obviously never tested word lengths other than 8, because...

> +static inline void ti_qspi_read_data(struct ti_qspi *qspi,
> +               unsigned long reg, int wlen, u8 **rxbuf)
> +{
> +       switch (wlen) {
> +       case 8:
> +               **rxbuf = readb(qspi->base + reg);
> +               dev_vdbg(qspi->dev, "rx done, read %02x\n", *(*rxbuf));
> +               *rxbuf += 1;
> +               break;
> +       case 16:
> +               **rxbuf = readw(qspi->base + reg);

*rxbuf is a u8*.  This means when you assign to **rxbuf the type of
the lvalue is u8.  8 bits.  It does not matter what type the rvalue
is, u8, u16, or u32, the result will always be truncated to 8 bits.

IMHO, I toss the design of ti_qspi_read/write_data().  They look like
a function to read a generic register, yet it only makes sense with
QSPI_SPI_DATA_REG.  Passing the pointer by address so it can be
incremented is ugly.  And doesn't work at all, since the type of the
pointer isn't going to be the same for different word lengths.  The
case statement inside the inner loop is inefficient.  Each case is
largely duplicated code.
