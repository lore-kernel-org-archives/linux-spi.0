From: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH v3 1/6] regmap: add support for 7_25 format
Date: Fri, 16 Mar 2012 09:51:28 +1100
Message-ID: <201203160951.29058.marc@cpdesign.com.au>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
	<1331757790-10583-2-git-send-email-marc@cpdesign.com.au>
	<20120315104443.GC3138@opensource.wolfsonmicro.com>
Reply-To: marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120315104443.GC3138-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday, March 15, 2012 09:44:44 PM Mark Brown wrote:
> On Thu, Mar 15, 2012 at 07:43:05AM +1100, Marc Reilly wrote:
> > This adds support for devices with 7 address bits and 25 data bits.
> > The initial intended user for this are the mc13xxx mfds in spi mode.
> > (The 25th data bit is actually a dummy bit)
> > 
> > Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> 
> It looks like this should be using the pad_bits parameter, though
> currently we only actually support pad bytes and integer sized register
> values.  Ugh.  We also have some entertainment because this device
> contains a touchscreen so I imagine you want readback but devices using
> odd register sizes don't do readback right now.

Ah, so this way definetly won't work. We definitely need to read the device 
registers.

> 
> What I think we want to do here is use pad_bits then internally to the
> API notice that reg_bits + pad_bits is a byte and therefore set up for 8
> bit registers and set a new value reg_shift in the map which shifts the
> register address left, either teaching the register format functions
> about it or just making a new one.  This should work better from a
> framework point of view.

Ok. 

Cheers,
Marc
------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
