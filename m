From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: spi-imx: real time operation
Date: Wed, 15 Apr 2015 21:36:52 +0200
Message-ID: <20150415213652.102dfb2f@north>
References: <20150415170936.3e506e6c@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus.Niebel-HVi9AzVXQk5Wk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150415170936.3e506e6c@north>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 15 Apr 2015 17:09:36 +0200, Jakub Kicinski wrote:
> Hi Markus!
> 
> I've seen your patch from July which added rt parameter to spi-imx [1].
> If I understand the code correctly spi-imx is using bitbang, therefore
> it uses old SPI API, therefore the message pump does not apply to it,
> therefore setting master->rt has no effect.
> 
> Is my understanding correct?  If so before I convert spi-imx not to use
> bitbang I would like to ask you if you have not already done it? ;)
> 
> Without SPI threads running with RT prio I can't even reliably use an
> sc16is7xx UART at 115200...
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg348713.html

Ugh.. I missed 2025172e3280 ("spi/bitbang: Use core message pump"),
working with old kernels bit my in the rear end.

Sorry for the noise.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
