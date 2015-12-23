From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 23 Dec 2015 19:23:38 +0800
Message-ID: <20151223192338.128e95a4@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

Currently the spi-dw tmode is fixed to SPI_TMOD_TR if cs_control is NULL, but we
need to set it as SPI_TMOD_EPROMREAD to read nor flash, my solution is to add and
export one functions to set the tmode, then the nor flash driver call it
before reading and set back to SPI_TMOD_TR after done.

Is there any elegant solution from SPI framework? Any suggestions are appreciated!

Thanks,
Jisheng
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
