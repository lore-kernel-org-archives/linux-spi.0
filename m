From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: Re: RFC: FT232H based FPGA configuration adapter drivers
Date: Fri, 8 Dec 2017 14:57:17 +0100
Message-ID: <20171208145717.67b23e48@crub>
References: <20171207153150.6f33f2e7@crub>
        <CAMuHMdUAXv_s8Lw1qwORew8RydKRKhFq7tMccU7jCa63_Otp0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-fpga-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUAXv_s8Lw1qwORew8RydKRKhFq7tMccU7jCa63_Otp0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On Fri, 8 Dec 2017 10:27:46 +0100
Geert Uytterhoeven geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org wrote:

[...]
>A quick Google shows the FT232H chip in MPSSE mode can also support i2c.
>I guess your design can be extended for that, too, using another VID/PID
>pair?

Yes, this should be doable.

Thanks,

Anatolij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
