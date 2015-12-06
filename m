From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Add loopback mode support
Date: Sun, 6 Dec 2015 19:06:33 +0100
Message-ID: <56647929.4060202@gmail.com>
References: <1449192204-24877-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AejRorUv6TKH90t-VpsSGd6NiH9cCTJC5-QuMpiGPOPw@mail.gmail.com>
 <20151206112407.GK5727@sirena.org.uk>
 <CAOMZO5BrOgOvupBXRcK=iLYmbViKMjQE6xYi6HwU71Twjt2O0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5BrOgOvupBXRcK=iLYmbViKMjQE6xYi6HwU71Twjt2O0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 2015-12-06 15:51, Fabio Estevam wrote:
> On Sun, Dec 6, 2015 at 9:24 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Sat, Dec 05, 2015 at 03:32:31PM -0200, Fabio Estevam wrote:
>>
>>> The SPI_LOOP should not be added to all spi versions, only for the
>>> mx51/mx53/mx6q type.
>>
>>> Just realized that Anton sent the loopback support as part of his
>>> series, so please discard this one.
>>
>> I'd already applied this before you sent your mail, sorry.
>
> No problekm, Mark. I think Anton can move the SPI_LOOP flag from the
> probe function to only mx51/mx53/mx6 config and all will be fine.
>
> Thanks
>

There is a small problem with this change. Loopback mode not enabled for 
first transaction in the system. This is happen because TEST reg written 
before controller taken out from the reset by writing to CTRL reg. The 
simple fix will be to move TEST reg read/write after write to CTRL reg.

Regards, Anton
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
