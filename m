From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 10:23:33 -0800
Message-ID: <CAJ+vNU0rsabjK80zmq_QBhPQqru2A06n8+zgEPvWfHdyb-kbMQ@mail.gmail.com>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <2771c4a8-ed85-86c1-a08c-5b62d177b107@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
        Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2771c4a8-ed85-86c1-a08c-5b62d177b107-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 15, 2017 at 8:02 AM, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org> wrote:
> On 11/13/2017 01:17 PM, Tim Harvey wrote:
>>
>> Mark/Jan,
>>
>> I have been unsuccessful getting a MCP251x SPI based CAN controller
>> working on a CN80xx using Linux mainline.
>>
>> When a register is read from the mcp251x driver the
>> octeon_spi_do_transfer() gets a spi_message with a single spi_xfer of
>> len=3, a tx_buf, and an rx_buf which I believe is supposed to shift
>> out 3 bytes out MOSI and shift in 3 bytes from MISO where the last
>> byte shifted in would be the response.
>>
>> The cavium CN80xx MPI_TX register has fields for 'Number of bytes to
>> transmit' (TXNUM) and 'Total number of bytes to shift (transmit and
>> receive)' (TOTNUM) and these are both getting set to 3 by
>> octeon_spi_do_transfer() but I find that this causes unexpected data
>> in the shifted in response unless I make TOTNUM = TXNUM + 1.
>>
>> I should also note that Cavium has a software suite called the 'BDK'
>> which provides a CLI to SPI transfers which allows you to set the
>> TXNUM and TOTNUM fields uniquely and if I send a 2-byte command
>> (TXNUM=2) to read a register (READ command followed by the register)
>> and a 1 byte read (thus TOTNUM=3) then I get the response from the
>> mcp251x I expect.
>>
>
> By looking at the driver, and from my recollection, I think that SPI_3WIRE
> may never have been tested, so there could be bugs in this mode.
>
> The driver as is works with various SPI eeprom devices, so any proposed
> changes would need to be validated against things that currently work.
>
> It could be that you need the CN80xx Hardware Reference Manual, board
> schematics and a logic analyzer to be able to figure out what is happening.
>

David,

I have all three here and can debug. This isn't hooked up as SPI_3WIRE
(wireor) - its got full a 4 wire connection.

So thanks to the discussion here I now understand we are doing a
3-byte full-duplex transfer (the third dummy byte threw me off) and
that is what the spi-cavium.c driver is setting up.

So the transfer from the cavium side looks like this and TXNUM=3
TOTNUM=3 makes sense to me for a 3-byte full duplex transfer (shift a
total of 3 bytes).

// configure spi: 10MHz (clockdiv=0x11; cshi=0 wireor=0 cslate=0)
mpi_cfg => 0x112001
// send three bytes (0x03 = READ, 0x0f = CANSTAT, 0x00 = dummy byte)
mpi_dat0 => 0x03
mpi_dat1 => 0x0f
mpi_dat2 => 0x00
// do the transfer (CS1, leavecs=0  Deassert SPI_CSn_L after the
transaction is done, TXNUM=3 TOTNUM=3)
mpi_tx => 0x100303
// read response
mpi_dat0 <= 0xff
mpi_dat1 <= 0xff
mpi_dat2 <= 0x00
^^^^ I expect mpi_dat2 to be 0x80

Looking at the scope of CLK and MSIO I do see 3-bytes of CLK cycles
and the 0x80 on the wire and I'm wondering now if the cavium isn't
latching the 1st bit because of clock polarity (MPI_CFG[CSHI]) or
phase (MPI_CFG[CSLATE]).

Regardless of scope shots though, what is strange to me is that if I
increase TOTNUM to 4 (write 3 bytes, read 1 bytes, shift a total of 4
bytes) I get:
// configure spi: 10MHz (clockdiv=0x11; cshi=0 wireor=0 cslate=0)
mpi_cfg => 0x112001
// send three bytes (0x03 = READ, 0x0f = CANSTAT, 0x00 = dummy byte)
mpi_dat0 => 0x03
mpi_dat1 => 0x0f
mpi_dat2 => 0x00
// do the transfer (CS1, leavecs=0  Deassert SPI_CSn_L after the
transaction is done, TXNUM=3 TOTNUM=4)
mpi_tx => 0x100304
// read response
mpi_dat0 <= 0xff
mpi_dat1 <= 0xff
mpi_dat2 <= 0x80
^^^^^ 0x80 'is' the response I expect

Regards,

Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
