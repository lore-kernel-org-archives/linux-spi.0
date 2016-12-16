From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 1/3] spi: armada-3700: Signedness bug in probe
Date: Fri, 16 Dec 2016 13:34:44 +0300
Message-ID: <20161216103444.GC8244@mwanda>
References: <20161216082443.GA7031@elgon.mountain>
 <e1c6a534-6b6c-a83f-390f-b65654ff2bcf@free-electrons.com>
 <20161216095655.GB8244@mwanda>
 <9e5f6a38-6177-4026-7930-150c6b281a99@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9e5f6a38-6177-4026-7930-150c6b281a99-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We really should make it int consistently through out.  But it doesn't
matter because request_irq() rarely fails and static checkers are good
at catching the bugs...

regards,
dan carpenter

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
