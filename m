From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Mon, 4 May 2009 18:29:28 +0200
Message-ID: <20090504162928.GD15603@pengutronix.de>
References: <20090220144126.GA9203@pengutronix.de>
	<200902201641.21168.hs4233@mail.mn-solutions.de>
	<20090226103844.GB3058@pengutronix.de>
	<20090226232639.GF5811@n2100.arm.linux.org.uk>
	<20090227103840.GC3481@pengutronix.de>
	<20090302205826.GG25699@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.0904302343470.9542@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0904302343470.9542-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Guennadi,

On Thu, Apr 30, 2009 at 11:44:43PM +0200, Guennadi Liakhovetski wrote:
> Hi,
> 
> what's the state of this patch? Is a new revision planned soon to go in 
> for 2.6.31?

I'm currently working on pimping the Freescale driver and so far it
looks much better and more flexible than the in Kernel driver. I'll post
a patch later this evening.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
