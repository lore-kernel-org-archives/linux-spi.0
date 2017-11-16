From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Thu, 16 Nov 2017 08:13:54 -0800
Message-ID: <CAJ+vNU2M+c6dWT6bsZGU-CkJ7M+V0vkVxU+4X86UzbSYd3K_dQ@mail.gmail.com>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <2771c4a8-ed85-86c1-a08c-5b62d177b107@caviumnetworks.com> <CAJ+vNU0rsabjK80zmq_QBhPQqru2A06n8+zgEPvWfHdyb-kbMQ@mail.gmail.com>
 <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ@mail.gmail.com> <cf336886-a64f-9ff1-2a44-984ff64f8433@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cf336886-a64f-9ff1-2a44-984ff64f8433-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Nov 16, 2017 at 4:12 AM, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On 11/16/2017 12:18 AM, Tim Harvey wrote:
>> David / Jan,
>>
>> For reference, the HM describes TXNUM/TOTNUM as:
>>  TXNUM - Number of bytes to transmit
>>  TOTNUM - Total number of bytes to shift (transmit and receive)
>>
>> Here are some experiments that show somewhat inconsistent results:
>> - full duplex 3byte tx / 3byte rx to MCP251x
>> mpi_dat0 => 0x03 // READ
>> mpi_dat1 => 0x0e // CANSTAT
>> mip_dat2 => 0xa5 // dummy (but making it 0xa5 instead of 0x00 to prove a point)
>> mpi_tx => 0x100303 // TXNUM=3 TOTNUM=3; we see 24 clock cycles
>> // wait for completion
>> mpi_dat0 <= 0xff
>> mpi_dat1 <= 0xff
>
> Do you see 0xff 0xff on the MISO wire for byte 1 and 2?

Yes

>
>> mpi_dat2 <=0xa5 // this the dummy byte we sent out MOSI not what came
>> in on MISO which the scope shows as 0x80
>
> Oh, the device reads what you have shifed out? This is not good.

Yes... its not good. My first theory was that until TXNUM bytes have
been shifted out it shifts in the data it's sending (there's a mux
that can select from MOSI or MISO) but this doesn't hold true on some
of the other test cases.

if you perform a SPI transaction on a CN80xx that has no SPI slave
device you can see this as well.

>
>> if I set TXNUM=3 TOTNUM=4:
>> mpi_dat0 => 0x03 // READ
>> mpi_dat1 => 0x0e // CANSTAT
>> mip_dat2 => 0xa5 // dummy
>> mpi_tx => 0x100304 // TXNUM=3 TOTNUM=4; we see 32 clock cycles
>
> What's on MOSI for byte 4?

whatever was in the buffer - 0 in my test cases. The TOTNUM=4 causes
4*8 clock cycles. The TXNUM somehow steers the MUX that selects if
MOSI or MISO gets shifted into MPI_DAT for the input side but its not
entirely clear what it's logic is. I don't really understand why you
would ever want to read in MOSI and I don't see a way to control this
mux directly.

>
>> // wait for completion
>> mpi_dat0 <= 0xff
>> mpi_dat1 <= 0xff
>> mpi_dat2 <= 0x80 // response for CANSTAT reg 0x0e
>> mpi_dat3 <= 0x87 // response for CANCTRL reg 0x0f (because we shifted
>> 32 clock cycles)
>
> Looks correct.

Right, the data is correct but in this case I didn't want to clock an
extra byte just to be able to get the response.

>
>> if I set TXNUM=2 TOTNUM=3:
>> mpi_dat0 => 0x03 // READ
>> mpi_dat1 => 0x0e // CANSTAT
>> mpi_tx => 0x100203 // TXNUM=2 TOTNUM=3; we see 24 clock cycles
>
> What's on MOSI for byte 3?

whatever was in the buffer - 0 in my case.

>
>> // wait for completion
>> mpi_dat0 <= 0xff
>> mpi_dat1 <= 0xff
>> mpi_dat2 <= 0x80 // response for CANSTAT reg 0x0e
>>
>> if I set TXNUM=1 TOTNUM=1 to send a RESET command:
>> mpi_dat0 => 0xc0 // RESET
>> mpi_tx => 0x100101 // TXNUM=1 TOTNUM=1; we see 8 clock cycles
>> // wait for completion
>> mpi_dat0 <= 0xc0
>>
>> In all cases above what is seen on MISO in relation to CLK matches the
>> expectations of the mcp251x but the CN80xx MPI_DAT registers don't
>> return what I see on MISO. Am I missing a consistent pattern of
>> MPI_DAT vs TXNUM/TOTNUM here that would allow us to work-around this?
>> Is this a CN80xx chip errata? There is no known errata for the CN80XX
>> MPI engine.
>>
>> I could re-write the mcp251x driver to not use full-duplex but I'm
>> assuming most SPI drivers use full-duplex transactions.
>
> ACK.
>
> You don't want to use the mcp251x chip anyways for CAN, the SPI is quite
> slow and the load of the CPU is relatively high. Don't expect to get
> many messages over CAN and prepare for dropped frames. Better use a
> USB-CAN dongle. Or a proper card with some sort of PCI interface.
>

Understood. I'm not clear what the use case is for CAN on our products
but we have customers ask for it and they haven't specified what sort
of throughput they expect. We liked the MCP251x because it was a small
package and has an integrated transceiver. I'm not aware of any USB
based CAN controller chips with transceiver - all the devices I see in
drivers/net/can/usb seem to be non-on-board products implementing CAN
via on-board ARM CPU's.

I see a driver for SPI based HI311x CAN controller in the kernel as
well which at least doubles the clock of the MCP251x to 20MHz (the
CN80xx/CN81xx SPI clock can go up to 50MHz assuming we can get it to
work).

What are typical datarates you see used for CAN applications?

Tim
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
