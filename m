From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 13/14] Blackfin SPI driver: Move
	cs_chg_udelay to	cs_deactive to fix bug when some SPI LCD
	driver needs delay after	cs_deactive
Date: Wed, 31 Oct 2007 14:30:04 +0800
Message-ID: <1193812204.6971.14.camel@roc-laptop>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
	<1193735885-8202-14-git-send-email-bryan.wu@analog.com>
	<200710301319.00071.david-b@pacbell.net>
Reply-To: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	Cameron Barfield <cbarfield-uxMF5PKaPIoXhy9q4Lf3Ug@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200710301319.00071.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Tue, 2007-10-30 at 13:18 -0700, David Brownell wrote:
> On Tuesday 30 October 2007, Bryan Wu wrote:
> > @@ -211,6 +211,10 @@ static void cs_deactive(struct driver_data *drv_data, struct chip_data *chip)
> >         flag |= (chip->flag << 8);
> >  
> >         write_FLAG(drv_data, flag);
> > +
> > +       /* Move delay here for consistency */
> > +       if (chip->cs_chg_udelay)
> > +               udelay(chip->cs_chg_udelay);
> >  }
> >  
> 
> By the way, if this is something needed very often, that mechanism
> should be moved into the SPI framework.  It wouldn't be polite if
> such LCD drivers could only work on Blackfin boards.  :)

I am not sure whether this LCD needs cs_chg_udelay on other boards.
It is found by Cameron Barfield. Maybe it is some timing requirement for
specific hardware.

-Bryan Wu

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
