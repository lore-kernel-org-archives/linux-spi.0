From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Mon, 2 Mar 2009 20:58:26 +0000
Message-ID: <20090302205826.GG25699@n2100.arm.linux.org.uk>
References: <20090220144126.GA9203@pengutronix.de>
	<200902201641.21168.hs4233@mail.mn-solutions.de>
	<20090226103844.GB3058@pengutronix.de>
	<20090226232639.GF5811@n2100.arm.linux.org.uk>
	<20090227103840.GC3481@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090227103840.GC3481-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 27, 2009 at 11:38:40AM +0100, Wolfram Sang wrote:
> > What it does do though is want to naturally align structure members, so
> > it's a good idea to group u8's together up to the next members natural
> > boundary.  So:
> 
> All the hot-path variables are u32 as I don't want to do shifting there.
> The u8-members are all cold-path, so I can use them as shift counters.

What shifting are you referring to?  ARM GCC doesn't load a word and then
shift to get at the byte it's interested in.  It uses the ARM byte load
instruction or byte store instruction which are just as fast as word
loads or stores.

> One more thing I had in mind: As every access to a register now looks
> like
> 
>  'regs + drv_data->version->$some_offset'
> 
> I also wondered if it would pay off to add the register base to the
> offset already in the probe routine, so we then can reduce the access to
> simply
> 
> 'drv_data->version->$some_reg'
> 
> But this is for later, after the driver is stable, I think.

The load instruction combines addition or subtraction:

	ldr	rd, [rn, rm]

optionally with a constant shift for 'rm', so the first version is
entirely possible for the compiler to use one instruction to access
[regs + offset] in one instruction.

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
