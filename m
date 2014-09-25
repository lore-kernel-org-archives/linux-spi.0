From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Fix probe info message
Date: Thu, 25 Sep 2014 12:30:58 +0200
Message-ID: <74325058.MxaXLQJlSp@ws-stein>
References: <1411635212-20908-1-git-send-email-alexander.stein@systec-electronic.com> <20140925101430.GM16977@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140925101430.GM16977-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 25 September 2014 11:14:30, Mark Brown wrote:
> On Thu, Sep 25, 2014 at 10:53:32AM +0200, Alexander Stein wrote:
> 
> > -	pr_info(KERN_INFO "Freescale DSPI master initialized\n");
> > +	dev_info(&pdev->dev, "master initialized\n");
> 
> This message has no content, it should just be removed entirely.

Well, you know that the device has been probed successfully, which IMO is a message the user should be able to see in dmesg.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
