From: Yibin Gong <yibin.gong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH V1] spi: imx: add dma support for ecspi
Date: Thu, 13 Feb 2014 04:28:46 +0000
Message-ID: <68125bae8279423c9caf1a8ddc29ea97@BLUPR03MB036.namprd03.prod.outlook.com>
References: <1392199379-6742-1-git-send-email-b38343@freescale.com>
 <20140213015617.GA950@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"shijie.huang-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <shijie.huang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140213015617.GA950-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Sorry, I miss the message .Thanks Shawn's reminding and thanks Sascha's comments and I will talk with Frank.

-----Original Message-----
From: Shawn Guo [mailto:shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org] 
Sent: Thursday, February 13, 2014 9:56 AM
To: Gong Yibin-B38343
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Huang Shijie-B32955
Subject: Re: [PATCH V1] spi: imx: add dma support for ecspi

On Wed, Feb 12, 2014 at 06:02:59PM +0800, Robin Gong wrote:
> Add basical dma support for ecspi. Validate on i.MX6qsabresd board.
> 
> Signed-off-by: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Robin,

Are you aware of the submission [1] from Frank Li?  You may want to coordinate the effort with him.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/291722

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
