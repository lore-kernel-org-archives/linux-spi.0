From: "Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: Support of Micron SPI flash (size > 16MB)
Date: Fri, 16 May 2014 08:15:59 +0000
Message-ID: <86bc6bed6ec74c8c8fc3d0e929baee48@BY2PR03MB508.namprd03.prod.outlook.com>
References: <92977332ffca4669b5c1987b42b0d0c5@BY2PR03MB508.namprd03.prod.outlook.com>
 <20140509104404.GK12304@sirena.org.uk>
 <20140516061856.GD2413@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org"
	<vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140516061856.GD2413@norris-Latitude-E6410>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Friday, May 16, 2014 2:19 PM
> To: Mark Brown
> Cc: Hu Mingkai-B21284; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org; linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: Support of Micron SPI flash (size > 16MB)
> 
> On Fri, May 09, 2014 at 11:44:04AM +0100, Mark Brown wrote:
> > On Fri, May 09, 2014 at 10:25:04AM +0000, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org
> wrote:
> > > 2.       What are the changes needed for SPI controller to support 4
> byte addressing?
> >
> > If the SPI controller is a genuine SPI controller and not something
> > specially optimised for flash it shouldn't need any changes, it
> > doesn't know anything about the data it's sending.
> 
> Right. A true SPI controller doesn't need to know anything about
> addressing modes.
> 
> > The SPI flash code might
> > need updating though, I don't know about that.
> 
> The SPI flash code in MTD (m25p80.c, some of which is moving to
> drivers/mtd/spi-nor/ in -next) already supports 4-byte addressing for
> most flash. Check for flash support there.
> 
> You might also look at my comments in this commit, regarding the
> different types of "4-byte addressing":
> 
> commit 87c9511fba2bd069a35e1312587a29e112fc0cd6
> Author: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date:   Thu Apr 11 01:34:57 2013 -0700
> 
>     mtd: m25p80: utilize dedicated 4-byte addressing commands
> 
> But again, most of this should just work(TM) for true SPI controllers.
> 

Thanks for your info, Brian. We are using N25Q512A Micron SPI flash. Micron implemented
two commands to enter and exit 4 bytes address mode.

Another question is for erase and program command. From the datasheet, not only the WTITE
ENABLE command need to be issued before the command can be executed, but also a special
READ FLAG STATUS RESISTER command need to be issued after the erase/program command which
is not implemented in the upstream code. We implement the READ flag operation and erase
can work, but write still fail.

I saw somebody has added the Micron larger SPI flash (>16Mb) support, so I'd like to know
if they run into such issue.

Thanks,
Mingkai
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
