From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Tue, 09 Oct 2018 13:20:56 +0200
Message-ID: <87tvlv2wo7.fsf@gmail.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20181009120522.6b2bd15a@bbrezillon>
        <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM6PR04MB43575B32D7C8FBFC3FD7B45A97E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        (Chuanhua Han's message of "Tue, 9 Oct 2018 10:24:49 +0000")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

>> -----Original Message-----
>> From: Boris Brezillon <boris.brezillon@bootlin.com>
>> Sent: 2018=E5=B9=B410=E6=9C=889=E6=97=A5 18:05
>> To: Chuanhua Han <chuanhua.han@nxp.com>
>> Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
>> linux-kernel@vger.kernel.org; eha@deif.com
>> Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
>>=20
>> On Tue, 9 Oct 2018 09:52:23 +0000
>> Chuanhua Han <chuanhua.han@nxp.com> wrote:
>>=20
>> > 1. In the dspi driver (spi controller), bits_per_word
>> > (dspi->bits_per_word =3D transfer->bits_per_word) passed from the upper
>> > layer (spi-mem.c) is used. In this way, I can only assign the
>> > appropriate value of transfer->bits_per_word before passing to the
>> > controller, that is, the controller driver does not know the value of
>> > bits_per_word, and it will use this value when the upper level sets
>> > what value is passed.
>>=20
>> I think you're missing my point: ->bits_per_word is not what you're look=
ing
>> for
>> if what you're trying to do is use 32-bits accesses when things are prop=
erly
>> aligned.
>>=20
> In the dspi driver (spi controller driver), it is based on whether
> ->bits_per_word is
> larger than 16 to decide whether to use the XSPI mode (32bit) to transfer=
 data.

Not completely true.  XSPI mode is enabled, also for words smaller than
or equal to 16 bits.  But TX FIFO and CMD FIFO is written together, just
as for non-XSPI mode.

> If ->bits_per_word is not set and the default bits_per_word =3D8 is passe=
d to the=20
> dspi driver, the XSPI mode (32bit) is not used for data transfer in the d=
spi
> driver

Not true.  XSPI mode is unconditionally enabled in dspi_init().  But
XSPI mode does not overrule the value of transfer->bits_per_word.
The meaning of XSPI mode is the following:

1. Frame (word) size is max 32 bits (with normal SPI mode, max is 16
bits).
2. For frames (words) with more than 16 bits per frame (word), each
frame transfer results in 2 TX FIFO pop operations.
3. Command cycling is possible, enabled when SPI_CTARE[DTCP] > 1.

Command cycling is currently not implemented.  If implemented, it would
be possible to send multiple frames (words) by writing one time to CMD
FIFO and multiple times to TX FIFO.  This could possibly improve performance

Another possibility would be to use EOQ mode, if supported by the DSPI
controller in the CPU.  It allows for filling TX FIFO, and getting IRQ
only after last TX FIFO entry is sent.  This is also a likely
performance improvement.

>> > 2. As I understand, bits_per_word does not exist for non-byte
>> > alignment, but for the need to reserve non-byte transmission mode that
>> > meets the controller.
>>=20
>> Exactly. It's an optimization you have to take care of inside your
>> driver. The core
>> cannot help you with that.
>>=20
> The core layer is the upper layer. If you don't set ->bits_per_word,
> bits_per_word will use the default value of 8, so that the
> controller's specific mode for transferring data cannot be used (eg:
> XSPI mode).

XSPI mode is independent of bits_per_word.  In XSPI mode, you can send
frames as small as 4 bits, and up to 32 bits.  In normal SPI mode, you
can send frames from 4 to 16 bits.

>> > 3. In addition, now the
>> > XSPI of dspi cannot transfer data normally, so this problem needs to
>> > be solved.
>>=20
>> I still don't understand what the problem is.
>>=20
> The problem is that I tested the XSPI mode and could not work, that
> is, the data could not be transmitted normally.

What does "could not be transmitted normally" mean?

I am using XSPI mode on LS1021A, talking to a lot of different SPI
devices.  And they all work, and I believe everything is quite "normal".

/Esben
