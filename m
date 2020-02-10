From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] spi: add Renesas RPC-IF driver
Date: Mon, 10 Feb 2020 21:43:48 +0300
Message-ID: <30c1fc59-cae6-8993-bbb1-13a5385123ee@cogentembedded.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
 <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
 <TY1PR01MB1562509AEBD0B4460D3FEC798A1C0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mason Yang <masonccyang-I/i+R0kf0WFNUHwG+Fw1Kw@public.gmane.org>
To: Chris Brandt <Chris.Brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <TY1PR01MB1562509AEBD0B4460D3FEC798A1C0-5SGCI54O2uKy/kJTUOSl63colHNk5qUtvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-MW
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello!

On 02/08/2020 01:36 AM, Chris Brandt wrote:

>> Add the SPI driver for the Renesas RPC-IF.  It's the "front end" driver
>> using the "back end" APIs in the main driver to talk to the real hardware.
>> We only implement the 'spi-mem' interface -- there's no need to implemebt
>> the usual SPI driver methods...
> 
> I tried these patches on an RZ/A1H RSK board.
> 
> At first, things were looking good. It would probe the SPI flash correctly
> and I could read out data.
> 
> But, when I went to try and do an erase, it all went bad.
> Looking at the actual SPI lines, the commands coming out don't look like what
> I would expect from an MTD device.
> 
> For example, I do a 
>   $ flash_eraseall /dev/mtd3
> and all that comes out are Read Status commands (0x05).
> All the write enables and erase commands are missing.

   Well, I have warned that writes don't work.

> So, it looks like any command that is a write-only never actually sends
> anything.
> 
> I did try and do a page program command:
>   $ echo hello >  /dev/mtd3
> It sent the page program command (0x12), but in this case, it still didn't work
> because a write enable command was not sent first.
> I assume the MTD layer is requesting the correct sequence of commands, but
> Somehow this new driver is dropping of them.

   Would explain what I saw (writes not surviving a JFFS2 remount)...

> Chris

MBR, Sergei
