From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: xilinx: Remove bitbang and register with spi core
Date: Mon, 13 Jun 2016 17:14:18 +0200
Message-ID: <CAPybu_1bvXtQFeC8pPhZ4R9s8q2DC=06gQN015exi-9jQ9Y13A@mail.gmail.com>
References: <1464601609-5095-1-git-send-email-nagasure@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Naga Sureshkumar Relli <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464601609-5095-1-git-send-email-nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Naga


There is some functionality removed by this patch:

- Auto Detection of fifo size.
- Non irq mode (which is a great improvement on some systems)


Also some comments have been removed for apparently no reason:

> -       u32 cs_inactive;        /* Level of the CS pins when inactive*/
> +       int buffer_size;
> +       u32 cs_inactive;
>

And the rename of some vars increases the patch size:
-       struct xilinx_spi *xspi = spi_master_get_devdata(spi->master);
+       struct xilinx_spi *xqspi = spi_master_get_devdata(qspi->master);

I am not a big fan of code generation via macros:
#define XSPI_FIFO_READ(size, type)
Interpreting kernel oops or greping the code is much more difficult.
Why not using function parameters instead?

Could you add me in cc next time? Although I am not in the credit file
I have authored a good bunch of the file and also we relay on this
driver on our products.



Best regards!
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
