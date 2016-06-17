From: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: add spi_sync_single_transfer wrapper for single
 spi_transfer
Date: Fri, 17 Jun 2016 09:43:11 +0900
Message-ID: <20160617004311.GA911@samsunx.samsung>
References: <1466034046-718-1-git-send-email-andi.shyti@samsung.com>
 <CGME20160616161054epcas1p26a6616bcb99a3375eee6c11c76117d76@epcas1p2.samsung.com>
 <5762CF88.4060800@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-disposition: inline
In-reply-to: <5762CF88.4060800-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Lars,

> > The spi_sync_single_transfer function calls spi_sync_transfer
> > with a single spi_transfer element, instead of an array.
> 
> So, what's the advantage of using this as opposed to calling
> spi_sync_transfer with a 1 for the number of transfers?

Not much, but it keeps the code a bit nicer to read for those
using spi_sync_transfer with only one spi_transfer. Besides it's
also more understandable what the function itself does and there
would not be any need to jump into the spi_sync_transfer to check
what the number '1' is needed for (for example it's not a boolean 
'true' value).

I checked and there are quite many uses of spi_sync_transfer with
only 1 transfer.

Thanks,
Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
