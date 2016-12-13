From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] spi: armada-3700: fix unsigned compare than zero on irq
Date: Tue, 13 Dec 2016 12:02:42 +0100
Message-ID: <571b3162-2a92-ef31-3300-ac931fbcceb5@free-electrons.com>
References: <20161213102812.9029-1-colin.king@canonical.com>
 <c173347e-c93b-2652-0b10-14e85d5f96bd@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c173347e-c93b-2652-0b10-14e85d5f96bd-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

Le 13/12/2016 à 11:55, Romain Perier a écrit :

>>
>
> Why don't you change only the type of "irq" in struct a3700_spi ?
>
> Thanks,
> Romain


In fact, it cannot work with devmem_request_irq/request_irq which 
require an unsigned int as second argument... So it's okay for me.

Acked-by: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
