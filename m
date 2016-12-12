From: "Giuseppe Lippolis" <giu.lippolis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spidev instantiated from DT
Date: Mon, 12 Dec 2016 20:45:05 +0100
Message-ID: <006d01d254b0$3d010520$b7030f60$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: de
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Thanks for your clarification.

So the rationale is to keep fixed the HW description (that make sense).
If a "generic" driver is required, the specific device compatible statement
shall be added in spidev like:
	{ .compatible = "lineartechnology,ltc2488" },

And if later a more specific driver will be available, the previous line
shall be removed. 

Can you please confirm my understanding?

Bye.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
