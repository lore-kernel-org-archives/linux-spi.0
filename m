From: Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi: davinci: Initialize dspi->done before any possible use of it
Date: Tue, 12 Dec 2017 11:10:47 +0100
Message-ID: <20171212101048.28278-1-michele.dionisio@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On SOC with multiple cpu (like omal l138) it is possible that spi periferic is already initialized when this module is loaded and it is possible to recieve interrupt when the modules is not sully initialized.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
