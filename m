From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card
	detect line
Date: Fri, 23 May 2008 19:42:04 +0400
Message-ID: <20080523154204.GA19803@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru> <20080517133633.5aa26938@mjolnir.drzeus.cx> <20080521184713.GA30284@polina.dev.rtsoft.ru> <20080521212831.523f344b@mjolnir.drzeus.cx> <20080522181713.GA26918@polina.dev.rtsoft.ru> <20080522213432.4a50629b@mjolnir.drzeus.cx>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Jochen Friedrich <jochen@scram.de>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758795AbYEWPmU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080522213432.4a50629b@mjolnir.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 22, 2008 at 09:34:32PM +0200, Pierre Ossman wrote:
[...]
> > Ok. How about this version?
> > 
> 
> Perfect. Unless there is some way you can pass flags in platform data?
> Using the lack of an init() to determine the need for polling is a bit
> circumstantial.

Aha, that's an idea, thanks. Implemented in the updated patches.

p.s.
I think, in case of capabilities, it's users' responsibility to not
issue bogus flags, so mmc_spi doesn't mask anything, it just passes
platform's caps. This also avoids drivers update when (if) new caps
will be implemented.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
