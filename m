From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Building SPI subsystem core as module
Date: Wed, 10 Sep 2014 17:32:24 -0700
Message-ID: <FD9BA9A3-AD76-4F43-9C13-BEAA45D6F8C9@holtmann.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: warthog9-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

is there any specific reason why we can not build the SPI subsystem core as module. It needs a bit of Kconfig love, but I do not see an obvious reason this should be build into the kernel.

I am asking because building it as module would be useful for general purpose distributions. One example coming to mind is running Fedora on a Minnowboard Max.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
