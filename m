From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: spi-sh: add IORESOURCE_MEM_TYPE_MASK decoding for
	access size
Date: Fri, 27 Jan 2012 12:01:11 +0900
Message-ID: <20120127030111.GF26283@linux-sh.org>
References: <4F21124D.6030601@renesas.com>
	<20120126102220.GE26283@linux-sh.org>
	<4F21FA89.4060709@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F21FA89.4060709-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 27, 2012 at 10:14:49AM +0900, Shimoda, Yoshihiro wrote:
> 2012/01/26 19:22, Paul Mundt wrote:
> > On Thu, Jan 26, 2012 at 05:43:57PM +0900, Shimoda, Yoshihiro wrote:
> [ snip ]
> >>  static void spi_sh_set_bit(struct spi_sh_data *ss, unsigned long val,
> >> @@ -464,6 +473,18 @@ static int __devinit spi_sh_probe(struct platform_device *pdev)
> >>  	ss = spi_master_get_devdata(master);
> >>  	dev_set_drvdata(&pdev->dev, ss);
> >>
> >> +	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
> >> +	case IORESOURCE_MEM_8BIT:
> >> +		ss->width = 8;
> >> +		break;
> >> +	case IORESOURCE_MEM_32BIT:
> >> +		ss->width = 32;
> >> +		break;
> >> +	default:
> >> +		dev_err(&pdev->dev, "No support width\n");
> >> +		ret = -ENODEV;
> >> +		goto error1;
> > 
> > If the default up to this point has been 32-bit only then it makes sense
> > for 32 to still remain the default. The 8-bit user is presumably a new
> > one and therefore has no existing platform data configuration to worry
> > about, while this change would require existing users to be updated for
> > the new 32-bit flag to behave the same way they have up until now. 
> 
> Thank you for your comment.
> Unfortunately, the value of IORESOURCE_MEM_8BIT is (0<<3), so existing users
> will not enter to the default.
> 
Ah, ok, I missed that. In that case I suppose your original patch makes
the most sense. We should be able to roll in the platform update patch
early anyways.

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
