From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2 02/10] mtd: spi-nor: add a new field for spi_nor{}
Date: Mon, 28 Apr 2014 22:23:26 +0200
Message-ID: <201404282223.26174.marex@denx.de>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com> <1398657227-20721-3-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398657227-20721-3-git-send-email-b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday, April 28, 2014 at 05:53:39 AM, Huang Shijie wrote:
> We need the SPI NOR child node to store some specific features, such as the
> dummy cycles for the DDR Quad read.
> 
> But now, we only have the @dev field in the spi_nor{}. The @dev may points
> to a spi_device{} for m25p80, while it may points to a platform_deivice{}
> for the SPI NOR controller, such as fsl_quadspi.c.
> 
> It is not convenient for us to get come information from the SPI NOR flash.
> 
> This patch adds a new field @np to spi_nor{}, it points to the child node
> for the SPI NOR flash.
> 
> Signed-off-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Just handle the case where dev->of_node == NULL instead ?

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
