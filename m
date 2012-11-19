From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix the redifine warning
Date: Mon, 19 Nov 2012 11:33:00 +0100
Message-ID: <87ehjpnaqr.fsf@dell.be.48ers.dk>
References: <1353307349-4611-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <spi-devel-general@lists.sourceforge.net>,
	linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com,
	linux-kernel@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1353307349-4611-1-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Mon, 19 Nov 2012 12:12:29 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>>>>> "Shubhrajyoti" == Shubhrajyoti D <shubhrajyoti@ti.com> writes:

 Shubhrajyoti> Fix the below warning

 Shubhrajyoti> drivers/spi/spi-omap2-mcspi.c:336:34: warning: symbol
 Shubhrajyoti> 'tx' shadows an earlier one
 Shubhrajyoti> drivers/spi/spi-omap2-mcspi.c:327:12: originally declared
 Shubhrajyoti> here

 Shubhrajyoti> So delete the u8 tx as it is assigned and not
 Shubhrajyoti> used(resigned afterwards).

 Shubhrajyoti> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
