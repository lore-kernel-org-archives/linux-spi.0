From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for
 Designware SPI driver
Date: Mon, 15 Feb 2016 18:09:21 +0000
Message-ID: <20160215180921.2692941e@lxorguk.ukuu.org.uk>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
	<20160205110900.GA12311@sirena.org.uk>
	<56C18C07.2030209@huawei.com>
	<20160215174540.GS18988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, qiujiang <qiujiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	charles.chenxin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160215174540.GS18988-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 15 Feb 2016 17:45:40 +0000
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Mon, Feb 15, 2016 at 04:27:51PM +0800, Hanjun Guo wrote:
> > On 2016/2/5 19:09, Mark Brown wrote:  
> 
> > > Intel are heavy users of this driver on their systems which also use
> > > ACPI.  Have you discussed this binding with them?  I've copied Andy and
> > > Jarkko who've worked on the driver recently.  
> 
> > There is no ACPI code in this driver yet, seems "PRP0001" is used to reuse
> > this driver directly.  
> 
> No, on Intel systems the devices appear on the PCI bus.

They may be ACPI or PCI enumerated - depends upon the system and
firmware. See drivers/acpi/acpi_lpss.c


Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
