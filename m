From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: spi-pic32: Add PIC32 SPI master driver
Date: Sat, 5 Mar 2016 20:45:22 +0530
Message-ID: <56DAF80A.2060805@microchip.com>
References: <1457099082-12587-1-git-send-email-purna.mandal@microchip.com>
 <1457099082-12587-2-git-send-email-purna.mandal@microchip.com>
 <20160305034011.GV18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Joshua Henderson <digitalpeer-icZdIMMiY0PM6KjX8ROVJw@public.gmane.org>,
	Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160305034011.GV18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/05/2016 09:10 AM, Mark Brown wrote:

> On Fri, Mar 04, 2016 at 07:14:42PM +0530, Purna Chandra Mandal wrote:
>> The PIC32 SPI driver is capable of performing SPI transfers
>> using PIO or external DMA engine. GPIO controlled /CS support
> I don't seem to have patch 1 in this series.

Sorry Mark.
I have missed adding you in CC. Please find it from:

https://lkml.org/lkml/2016/3/4/401

--Purna

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
