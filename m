From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Use separate TX and RX bounce buffers
Date: Mon, 13 Oct 2014 20:05:35 -0700
Message-ID: <543C92FF.80201@broadcom.com>
References: <rjui@broadcom.com> <1412878765-29088-1-git-send-email-rjui@broadcom.com> <20141013110726.GT27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	JD Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	"Geert Uytterhoeven" <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141013110726.GT27755-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/13/2014 4:07 AM, Mark Brown wrote:
> On Thu, Oct 09, 2014 at 11:19:25AM -0700, Ray Jui wrote:
>> By using separate TX and RX bounce buffers, we avoid potential cache
>> flush and invalidation sequence issue that may be encountered when a
>> single bounce buffer is shared between TX and RX
>
> Applied, thanks.
>
Thanks, Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
