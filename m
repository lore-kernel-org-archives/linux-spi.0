From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi-imx: Add loopback mode support
Date: Sun, 6 Dec 2015 13:49:56 +0100
Message-ID: <56642EF4.1050804@gmail.com>
References: <1449192204-24877-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AejRorUv6TKH90t-VpsSGd6NiH9cCTJC5-QuMpiGPOPw@mail.gmail.com>
 <20151206112407.GK5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151206112407.GK5727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 2015-12-06 12:24, Mark Brown wrote:
> On Sat, Dec 05, 2015 at 03:32:31PM -0200, Fabio Estevam wrote:
>
>> The SPI_LOOP should not be added to all spi versions, only for the
>> mx51/mx53/mx6q type.
>
>> Just realized that Anton sent the loopback support as part of his
>> series, so please discard this one.
>
> I'd already applied this before you sent your mail, sorry.
>

I'll rebase my changes on top of topic/imx. Is it OK?

Regards, Anton
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
