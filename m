From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
Subject: imx spi performance
Date: Wed, 9 Mar 2016 09:26:31 +0100
Message-ID: <56DFDE37.9060606@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <kibo-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

We are getting a very low throughput with the imx6q and the spi 
interface :-(
I have tried both with gpio CS and HW CS.

With gpio CS:
I have a imx6q hooked up to 4x spi uarts(sc16is750) running 4MHz,
using 2 spi channels and 4 chipselects.
With HW flowcontrol @ 115200 8n1, and full duplex on all 4 uarts,
we are getting a maximum throughput of 69841 bits/sec.
That to me seems very slow.

With HW CS:
It does not seem to work as CS is shifted for every
BITS_PER_WORD and that is not compliant with most spi devices.

Does someone have any ideas we can try to boost the performance.

/Sean

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
