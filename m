From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer structure.
Date: Thu, 31 Mar 2016 10:28:09 +0200
Message-ID: <CAMuHMdV0B8Qka57nMv009aLdQ-fdBpAYr3wONQ7xaMfKXrORvQ@mail.gmail.com>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
	<20160321130734.GS2566@sirena.org.uk>
	<4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
	<20160322100615.GA2566@sirena.org.uk>
	<4FF8F58FAA9D5D4193D4E554E4352C5902C6DB59@XAP-PVEXMBX02.xlnx.xilinx.com>
	<20160325150109.GF2566@sirena.org.uk>
	<4FF8F58FAA9D5D4193D4E554E4352C5902C6E92A@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Aniru
To: Lakshmi Sai Krishna Potthuri
	<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C5902C6E92A-4lKfpRxZ5ekkx2a1wsGfbYg+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Mar 31, 2016 at 8:14 AM, Lakshmi Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
>>> >This is really not what I'd expect to happen, I'd expect that these dummy
>>> >cycles would be in addition to the actual data (see my request for better
>>> >documentation...).  If they overlap with the data then what is the point in
>>> >specifying this?  It's more work for the host, what benefit do we get from
>>> >doing it over just handing it like a normal byte?
>>
>>> len field in the transfer structure contains dummy bytes along with actual
>>data
>>> bytes, controllers which requires dummy bytes use len field and simply
>>Ignore
>>> the dummy field (contains only no of cycles)added in this patch. Controllers
>>> (like ZynqMP GQSPI) expects dummy in cycles won't work directly by using
>>> len field because host driver doesn't know that len field of a particular
>>transfer
>>> includes dummy bytes or not (and also number of dummy bytes included in
>>len
>>> field). In such cases driver use this dummy field to identify the number of
>>dummy
>>> cycles and based on that it will send the required number of dummy cycles
>>(which
>>> i did in the second patch).
>>
>>This doesn't make any sense at all to me.  Why does the controller care
>>what the bytes being sent to and from the device mean?
>
> From the flash point of view, it expects the controller to send the dummy
> on 1/2/4 lines based on the command. For Quad commands, flash expects
> 4 lines to be active during dummy phase. Similarly, 2 lines for dual
> Commands and 1 line for normal/fast commands.
> Since len field contains total number of cmd+addr+dummy bytes,
> host driver should take care of sending these bytes on their respective
> bus widths. Knowing when the dummy is being sent also helps in
> the correct switching of IO pads (since the data lines are bidirectional)
> ZynqMP GQSPI is a generic controller, majorly interfaced to flash devices.
> It seems reasonable for it to know the above information from
> the flash layer. Adding "dummy" cycles entry should be useful to any
> controller that cares about it without affecting other spi/qspi controllers.

The m25p80 driver already uses dummy cycles, using real spi_transfer
structs, which have tx_nbits/rx_nbits fields to indicate how many data lines
to use.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
