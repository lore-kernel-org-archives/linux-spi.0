From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Wed, 15 Nov 2017 08:02:01 -0800
Message-ID: <2771c4a8-ed85-86c1-a08c-5b62d177b107@caviumnetworks.com>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
        Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/13/2017 01:17 PM, Tim Harvey wrote:
> Mark/Jan,
> 
> I have been unsuccessful getting a MCP251x SPI based CAN controller
> working on a CN80xx using Linux mainline.
> 
> When a register is read from the mcp251x driver the
> octeon_spi_do_transfer() gets a spi_message with a single spi_xfer of
> len=3, a tx_buf, and an rx_buf which I believe is supposed to shift
> out 3 bytes out MOSI and shift in 3 bytes from MISO where the last
> byte shifted in would be the response.
> 
> The cavium CN80xx MPI_TX register has fields for 'Number of bytes to
> transmit' (TXNUM) and 'Total number of bytes to shift (transmit and
> receive)' (TOTNUM) and these are both getting set to 3 by
> octeon_spi_do_transfer() but I find that this causes unexpected data
> in the shifted in response unless I make TOTNUM = TXNUM + 1.
> 
> I should also note that Cavium has a software suite called the 'BDK'
> which provides a CLI to SPI transfers which allows you to set the
> TXNUM and TOTNUM fields uniquely and if I send a 2-byte command
> (TXNUM=2) to read a register (READ command followed by the register)
> and a 1 byte read (thus TOTNUM=3) then I get the response from the
> mcp251x I expect.
> 

By looking at the driver, and from my recollection, I think that 
SPI_3WIRE may never have been tested, so there could be bugs in this mode.

The driver as is works with various SPI eeprom devices, so any proposed 
changes would need to be validated against things that currently work.

It could be that you need the CN80xx Hardware Reference Manual, board 
schematics and a logic analyzer to be able to figure out what is happening.

David.



> Is there something I'm misunderstanding about the Linux SPI API and
> perhaps is there a bug in the cavium SPI controller driver or do I
> perhaps have it configured wrong with respect to CPHA and/or CPOL?
> 
> Thanks,
> 
> Tim
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
