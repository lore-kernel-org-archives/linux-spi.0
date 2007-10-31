From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 09/14] Blackfin SPI driver: Fix SPI
	driver to work with SPI flash ST25P16 on bf548
Date: Wed, 31 Oct 2007 13:14:00 -0700
Message-ID: <200710311314.00465.david-b@pacbell.net>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
	<200710311201.29643.david-b@pacbell.net>
	<8bd0f97a0710311216l25f89b37v356fd44d7c1999da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mike Frysinger" <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a0710311216l25f89b37v356fd44d7c1999da-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
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

> > > pretty much all SPI flashes have two read commands ("slow" and "fast"
> > > as they're typically called).
> >
> > Not DataFlash.
> 
> doesnt it ?  AT45DB642D says 0x0B is fast (up to 66mhz) while 0x03 (up to 33mhz)

And ...041B, ...081B, ...161B, ...321, ...321C, and others don't.
(From a quick scan of datasheets I have locally...)

Those 0x0B and 0x03 commands are "new", and have never been
used by the Linux DataFlash drivers.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
