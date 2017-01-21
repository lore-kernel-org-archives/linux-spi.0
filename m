From: "Giuseppe Lippolis" <giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: AW: RT5350 spi half duplex?
Date: Sat, 21 Jan 2017 08:57:40 +0100
Message-ID: <002f01d273bc$0a6087f0$1f2197d0$@gmail.com>
References: <008601d271ca$ea3e7560$bebb6020$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <008601d271ca$ea3e7560$bebb6020$@gmail.com>
Content-Language: de
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> I'm experimenting the spi interface on a RT5350 target.
> Its spi driver set the interface as half duplex
> 
>         master->flags = SPI_MASTER_HALF_DUPLEX;

How is it possible to get this information (half full duplex) in userspace?

Thanks,
Bye.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
