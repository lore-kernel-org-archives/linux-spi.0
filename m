From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/3] spi_topcliff_pch: support new device ML7213
Date: Fri, 07 Jan 2011 03:57:58 -0600
Message-ID: <topcliff-split-resend2@mdm.bga.com>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
	<20101229064937.GC8172@angua.secretlab.ca>
	<280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com>
	<20110105163835.GD17272@angua.secretlab.ca>
	<46862922F48B45F781832619CF3F4B79@hacdom.okisemi.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, <qi.wang@intel.com>,
	<yong.y.wang@intel.com>, <joel.clark@intel.com>,
	<kok.howg.ewe@intel.com>
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46862922F48B45F781832619CF3F4B79@hacdom.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
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
