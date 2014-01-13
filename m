From: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] spi: fsl-dspi: Add missing breaks for switch cases
Date: Mon, 13 Jan 2014 02:44:13 +0000
Message-ID: <94aeb0cf1b4a4dfeaa3097ec48e1ce3e@BL2PR03MB163.namprd03.prod.outlook.com>
References: <1389191274.32246.1.camel@phoenix>
 <CAFRkauCMCZr4MGDMt1GJKd8uTKWH5bX_BXB5-Ouy5vFVg6ZY0Q@mail.gmail.com>
 <20140110112420.GD29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Huan Wang <Huan.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140110112420.GD29039-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> > Hi Chao and Alison,
> >
> > I'm wondering if this driver really work without this patch?
> > Any chance to test this patch?
> 
> I applied the patch already - sorry, seems I must've forgotten to mail
> out.


[Chao Fu] Hi Axel , Mark,
Sorry for this careless omission. But no break it is really working in former debugging,
make me can not find this omission. I will take more care of my code, thank you!
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
