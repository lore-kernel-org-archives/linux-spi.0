From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] spi: Add support for the OpenCores SPI controller.
Date: Mon, 30 Mar 2009 10:44:54 +0200
Message-ID: <200903301044.54626.florian@openwrt.org>
References: <1238054874-28215-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756675AbZC3IpX@vger.kernel.org>
In-Reply-To: <1238054874-28215-1-git-send-email-thierry.reding@avionic-design.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Thierry,

Le Thursday 26 March 2009 09:07:53 Thierry Reding, vous avez =C3=A9crit=
=C2=A0:
> This patch adds a platform device driver that supports the OpenCores =
SPI
> controller.
>
> The driver expects two resources: an IORESOURCE_MEM resource defining=
 the
> core's memory-mapped registers and an IORESOURCE_IRQ for the associat=
ed
> interrupt. It also requires a clock, "spi-master-clk", used to comput=
e the
> clock divider.

Thanks again for submitting this ;)

>
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Florian Fainelli <florian@openwrt.org>

--=20
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
