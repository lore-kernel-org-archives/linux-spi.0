From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Why does MOSI appear to be sending data on a read?
Date: Wed, 11 Jan 2012 11:39:08 -0700
Message-ID: <20120111183908.GA1700@ponder.secretlab.ca>
References: <CAN=k24mOrOe939_iWS2cO-1nTH0jGy5DjWDd0tdRwGJqvGg2TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN=k24mOrOe939_iWS2cO-1nTH0jGy5DjWDd0tdRwGJqvGg2TQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 11, 2012 at 05:21:24PM +0000, Wayne Tams wrote:
> Hi,
> 
> Just wondering if this is normal behaviour. When I do a SPI read to my
> slave device I get the data I want all seems fine.
> 
> When I look at the SPI bus on a logic analyser, after I write to MOSI
> to tell the device I am going to read I can see that my MOSI line has
> the same number bytes as those being read on MISO only that they are
> all NULL.

All SPI transfers are bidirectional.  For every bit clocked out you will get a bit clocked in.

g.

> 
> Thanks
> 
> Wayne
> 
> ------------------------------------------------------------------------------
> Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
> infrastructure or vast IT resources to deliver seamless, secure access to
> virtual desktops. With this all-in-one solution, easily deploy virtual 
> desktops for less than the cost of PCs and save 60% on VDI infrastructure 
> costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
