From: "Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: Support of Micron SPI flash (size > 16MB)
Date: Fri, 16 May 2014 07:50:46 +0000
Message-ID: <73b4daa9267a4493b2f0bf85fa71ea3d@BY2PR03MB508.namprd03.prod.outlook.com>
References: <92977332ffca4669b5c1987b42b0d0c5@BY2PR03MB508.namprd03.prod.outlook.com>
 <20140509104404.GK12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org"
	<vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140509104404.GK12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Friday, May 09, 2014 6:44 PM
> To: Hu Mingkai-B21284
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org
> Subject: Re: Support of Micron SPI flash (size > 16MB)
> 
> On Fri, May 09, 2014 at 10:25:04AM +0000, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> 
> > 2.       What are the changes needed for SPI controller to support 4
> byte addressing?
> 
> If the SPI controller is a genuine SPI controller and not something
> specially optimised for flash it shouldn't need any changes, it doesn't
> know anything about the data it's sending.  The SPI flash code might need
> updating though, I don't know about that.

Thanks for your info.
Mingkai
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
