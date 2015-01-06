From: yoshihiro shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] spi: sh-msiof: fix MDR1_FLD_MASK value
Date: Tue, 6 Jan 2015 11:15:49 +0000
Message-ID: <HKNPR06MB322CD2512711FAE69EBC5F3D8590@HKNPR06MB322.apcprd06.prod.outlook.com>
References: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdUjor__TCQwDcHAR9-vH54=qB-_E5AM2a4hp2B+wE9c4Q@mail.gmail.com>
 <HKNPR06MB322387C2B14F90694CA90A8D8590@HKNPR06MB322.apcprd06.prod.outlook.com>
 <20150106110831.GV2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150106110831.GV2634-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: ja-JP
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

> 
> On Tue, Jan 06, 2015 at 10:57:32AM +0000, yoshihiro shimoda wrote:
> 
> > > This patch doesn't apply, since Mark has applied your other patch
> > > "spi: sh-msiof: Configure MSIOF sync signal timing in device tree".
> > >
> > > Please rebase on top of spi/for-next (or renesas-drivers-2015-01-06-v3.19-rc3).
> 
> > Oops. Thank you for the point.
> > I used spi/for-linux branch. So, I will rebase on top of spi/for-next.
> 
> Actually since it's a fix I applied it on a fix branch anyway and
> merged.

Thank you!
I already submitted v2 patch, but please ignore it.

Best regards,
Yoshihiro Shimoda

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
