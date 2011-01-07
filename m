From: Milton Miller <miltonm-ogEGBHC/i9Y@public.gmane.org>
Subject: Re: [PATCH 1/3] spi_topcliff_pch: support new device ML7213
Date: Fri, 07 Jan 2011 03:45:03 -0600
Message-ID: <topcliff-split-resend@mdm.bga.com>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
	<20101229064937.GC8172@angua.secretlab.ca>
	<280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com>
	<20110105163835.GD17272@angua.secretlab.ca>
	<46862922F48B45F781832619CF3F4B79@hacdom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46862922F48B45F781832619CF3F4B79-c0cKtqp5df7I9507bXv2FdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On: Mon, 27 Dec 2010 at about 11:23:45 -0000, Tomoya MORINAGA wrote:
> On Thursday, January 06, 2011 1:39 AM, Grant Likely wrote:
> > As far as examples go, drivers/mfd/timberdale.c seems reasonable, if a 
> > bit larger than what you need.
> 
> Thank you for your suggestion.
> However, though seeing this driver, I didn't understand your intention.
> It seems platform_device/platform_driver are not used in this.
> Which part of this driver do you want to show me as reference ?

follow mfd_add_devices into drivers/mfd/mfd-core.c

milton

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
