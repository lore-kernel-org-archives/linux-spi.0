From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Driver for GPIO controlled SPI multiplexer
Date: Mon, 04 Mar 2013 10:38:35 +0800
Message-ID: <20130304023835.5F0BC3E14C0@localhost>
References: <1361973519-30633-1-git-send-email-peter.korsgaard@barco.com>
	<20130302173244.41A2B3E1089@localhost>
	<20130303074209.GA19020@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>,
	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130303074209.GA19020-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, 3 Mar 2013 15:42:39 +0800, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Sat, Mar 02, 2013 at 05:32:44PM +0000, Grant Likely wrote:
> 
> > Mark commented on this too, but I disagree with him on one point; it
> > will actually be simpler if you finish up the transfer in the callback,
> > and that it really should be implemented that way from day one.
> 
> > xfer_complete and xfer_complete_wq can be dropped, and
> > child_mesg_complete, child_mesg_context and child_mesg_dev will move
> > into struct spi_mux_gpio.
> 
> I agree with this, I was just thinking that the waitqueue looked like a
> first stage in allowing multiple in flight transfers on the parent.
> Unless I'm missing something, I didn't think too deeply about
> implementing that, it's just that it's going to be needed at some point
> as it's so important for performance.

Alright, I'll bite. How? What's the scenario where the driver will need
to manage the wait queue directly? The point of the transfer_one_message
interface was pull queue management into the core and allow the driver
to get the next message just when it needs it.

g.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
