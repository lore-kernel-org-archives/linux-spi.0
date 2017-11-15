From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 15:18:59 -0800
Message-ID: <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ@mail.gmail.com>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <2771c4a8-ed85-86c1-a08c-5b62d177b107@caviumnetworks.com> <CAJ+vNU0rsabjK80zmq_QBhPQqru2A06n8+zgEPvWfHdyb-kbMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
        Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJ+vNU0rsabjK80zmq_QBhPQqru2A06n8+zgEPvWfHdyb-kbMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 15, 2017 at 10:23 AM, Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org> wrote:
> On Wed, Nov 15, 2017 at 8:02 AM, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org> wrote:
>> On 11/13/2017 01:17 PM, Tim Harvey wrote:
>>>
>>> Mark/Jan,
>>>
>>> I have been unsuccessful getting a MCP251x SPI based CAN controller
>>> working on a CN80xx using Linux mainline.
>>>
>>> When a register is read from the mcp251x driver the
>>> octeon_spi_do_transfer() gets a spi_message with a single spi_xfer of
>>> len=3, a tx_buf, and an rx_buf which I believe is supposed to shift
>>> out 3 bytes out MOSI and shift in 3 bytes from MISO where the last
>>> byte shifted in would be the response.
>>>
>>> The cavium CN80xx MPI_TX register has fields for 'Number of bytes to
>>> transmit' (TXNUM) and 'Total number of bytes to shift (transmit and
>>> receive)' (TOTNUM) and these are both getting set to 3 by
>>> octeon_spi_do_transfer() but I find that this causes unexpected data
>>> in the shifted in response unless I make TOTNUM = TXNUM + 1.
>>>
>>> I should also note that Cavium has a software suite called the 'BDK'
>>> which provides a CLI to SPI transfers which allows you to set the
>>> TXNUM and TOTNUM fields uniquely and if I send a 2-byte command
>>> (TXNUM=2) to read a register (READ command followed by the register)
>>> and a 1 byte read (thus TOTNUM=3) then I get the response from the
>>> mcp251x I expect.
>>>
>>
>> By looking at the driver, and from my recollection, I think that SPI_3WIRE
>> may never have been tested, so there could be bugs in this mode.
>>
>> The driver as is works with various SPI eeprom devices, so any proposed
>> changes would need to be validated against things that currently work.
>>
>> It could be that you need the CN80xx Hardware Reference Manual, board
>> schematics and a logic analyzer to be able to figure out what is happening.
>>
>
> David,
>
> I have all three here and can debug. This isn't hooked up as SPI_3WIRE
> (wireor) - its got full a 4 wire connection.
>
> So thanks to the discussion here I now understand we are doing a
> 3-byte full-duplex transfer (the third dummy byte threw me off) and
> that is what the spi-cavium.c driver is setting up.
>
> So the transfer from the cavium side looks like this and TXNUM=3
> TOTNUM=3 makes sense to me for a 3-byte full duplex transfer (shift a
> total of 3 bytes).
>
> // configure spi: 10MHz (clockdiv=0x11; cshi=0 wireor=0 cslate=0)
> mpi_cfg => 0x112001
> // send three bytes (0x03 = READ, 0x0f = CANSTAT, 0x00 = dummy byte)
> mpi_dat0 => 0x03
> mpi_dat1 => 0x0f
> mpi_dat2 => 0x00
> // do the transfer (CS1, leavecs=0  Deassert SPI_CSn_L after the
> transaction is done, TXNUM=3 TOTNUM=3)
> mpi_tx => 0x100303
> // read response
> mpi_dat0 <= 0xff
> mpi_dat1 <= 0xff
> mpi_dat2 <= 0x00
> ^^^^ I expect mpi_dat2 to be 0x80
>
> Looking at the scope of CLK and MSIO I do see 3-bytes of CLK cycles
> and the 0x80 on the wire and I'm wondering now if the cavium isn't
> latching the 1st bit because of clock polarity (MPI_CFG[CSHI]) or
> phase (MPI_CFG[CSLATE]).
>
> Regardless of scope shots though, what is strange to me is that if I
> increase TOTNUM to 4 (write 3 bytes, read 1 bytes, shift a total of 4
> bytes) I get:
> // configure spi: 10MHz (clockdiv=0x11; cshi=0 wireor=0 cslate=0)
> mpi_cfg => 0x112001
> // send three bytes (0x03 = READ, 0x0f = CANSTAT, 0x00 = dummy byte)
> mpi_dat0 => 0x03
> mpi_dat1 => 0x0f
> mpi_dat2 => 0x00
> // do the transfer (CS1, leavecs=0  Deassert SPI_CSn_L after the
> transaction is done, TXNUM=3 TOTNUM=4)
> mpi_tx => 0x100304
> // read response
> mpi_dat0 <= 0xff
> mpi_dat1 <= 0xff
> mpi_dat2 <= 0x80
> ^^^^^ 0x80 'is' the response I expect
>

David / Jan,

For reference, the HM describes TXNUM/TOTNUM as:
 TXNUM - Number of bytes to transmit
 TOTNUM - Total number of bytes to shift (transmit and receive)

Here are some experiments that show somewhat inconsistent results:
- full duplex 3byte tx / 3byte rx to MCP251x
mpi_dat0 => 0x03 // READ
mpi_dat1 => 0x0e // CANSTAT
mip_dat2 => 0xa5 // dummy (but making it 0xa5 instead of 0x00 to prove a point)
mpi_tx => 0x100303 // TXNUM=3 TOTNUM=3; we see 24 clock cycles
// wait for completion
mpi_dat0 <= 0xff
mpi_dat1 <= 0xff
mpi_dat2 <=0xa5 // this the dummy byte we sent out MOSI not what came
in on MISO which the scope shows as 0x80

if I set TXNUM=3 TOTNUM=4:
mpi_dat0 => 0x03 // READ
mpi_dat1 => 0x0e // CANSTAT
mip_dat2 => 0xa5 // dummy
mpi_tx => 0x100304 // TXNUM=3 TOTNUM=4; we see 32 clock cycles
// wait for completion
mpi_dat0 <= 0xff
mpi_dat1 <= 0xff
mpi_dat2 <= 0x80 // response for CANSTAT reg 0x0e
mpi_dat3 <= 0x87 // response for CANCTRL reg 0x0f (because we shifted
32 clock cycles)

if I set TXNUM=2 TOTNUM=3:
mpi_dat0 => 0x03 // READ
mpi_dat1 => 0x0e // CANSTAT
mpi_tx => 0x100203 // TXNUM=2 TOTNUM=3; we see 24 clock cycles
// wait for completion
mpi_dat0 <= 0xff
mpi_dat1 <= 0xff
mpi_dat2 <= 0x80 // response for CANSTAT reg 0x0e

if I set TXNUM=1 TOTNUM=1 to send a RESET command:
mpi_dat0 => 0xc0 // RESET
mpi_tx => 0x100101 // TXNUM=1 TOTNUM=1; we see 8 clock cycles
// wait for completion
mpi_dat0 <= 0xc0

In all cases above what is seen on MISO in relation to CLK matches the
expectations of the mcp251x but the CN80xx MPI_DAT registers don't
return what I see on MISO. Am I missing a consistent pattern of
MPI_DAT vs TXNUM/TOTNUM here that would allow us to work-around this?
Is this a CN80xx chip errata? There is no known errata for the CN80XX
MPI engine.

I could re-write the mcp251x driver to not use full-duplex but I'm
assuming most SPI drivers use full-duplex transactions.

Regards,

Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
