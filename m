From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: mxc_spi producing kernel panic during spi_async
Date: Sun, 27 Nov 2011 12:22:27 +0200
Message-ID: <20111127102226.GB5951@tarshish>
References: <CAN=k24=6uvoBTobj3RGZGD8qec_dqtWp47OXGEaUmDPKhdkwPw@mail.gmail.com>
	<20111126170829.GA5951@tarshish>
	<CAN=k24kxSbJh1nQ=V8MZ8PwukhDD2Vs+sqS4r2tysrTxrhEw9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wayne Tams <wayne.tams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN=k24kxSbJh1nQ=V8MZ8PwukhDD2Vs+sqS4r2tysrTxrhEw9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Wayne,

On Sat, Nov 26, 2011 at 09:13:31PM +0000, Wayne Tams wrote:
> On Sat, Nov 26, 2011 at 5:08 PM, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org> wrote:
> > On Fri, Nov 25, 2011 at 04:38:10PM +0000, Wayne Tams wrote:
> >> I am needing some help understanding a kernel panic when I try to load
> >> the at25 eeprom driver, I have traced it to the spi_async function in
> >> drivers/spi/spi.c but I do not know where to go to from here. I have
> >> found some similar issues in forum posts but threads never offer a
> >> solution which has left me scratching my head. Perhaps I am missing
> >> something in my kernel configuration?
> >>
> >> I am using the 2.6.35 kernel and mxc_spi driver for my i.Mx53
> >> platform. The message returned from the kernel is as follows
> >
> > Since the mxc_spi is not in the mainline kernel, people here can't help you
> > much. Try using the mainlined spi_imx driver (renamed to spi-imx since kenrel
> > version 3.1).
> 
> Oh sorry, it didn't click that mxc_spi was not in the mainline. I
> think I need to find out why this driver was favored over the spi-imx
> driver? Hopefully whoever from Freescale that can answer that question
> should hopefully help me get to the root of the problem.

Just don't hold your breath while waiting for a response from Freescale.

Note that a newer version of the Freescale i.MX BSP (based on 2.6.38) has 
abandoned this driver entirely.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
