From: David Brownell <david-b@pacbell.net>
Subject: Re: general SPI question (WAS: [PATCH v6] spi: Add PPC4xx SPI driver)
Date: Thu, 23 Apr 2009 23:20:30 -0700
Message-ID: <200904232320.30609.david-b@pacbell.net>
References: <1231411250-25380-1-git-send-email-sr@denx.de>
	<200904221300.39747.david-b@pacbell.net>
	<8ee9e87c0904232032sc7ef5e7ibf058618fca8c1a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	spi-devel-general@lists.sourceforge.net
To: Arnav Das <arnavdas29@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <8ee9e87c0904232032sc7ef5e7ibf058618fca8c1a0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Thursday 23 April 2009, Arnav Das wrote:
> i am a newbie

Lesson #1:  make sure your Subject: lines match the message
topic (I did a partial repair) and don't post to the wrong
list (e.g. PPC lists for OMAP questions).


> and am doing a project on beagle board(running 
> omap3530). i am interfacing an adc(ads7886) to the beagleboard via
> spi. need to know how the spi works

Read the ads7886 data sheet, in this case.  It uses
a subset of SPI ... no input commands, just a 12-bit
sample returned each time chipselect pulses.


> and how a module can access the 
> spi registers of the omap. if someones already made an adc driver can
> they mail me?

Use drivers/spi/omap2_mcspi.c on OMAP3 boards, at
least to start with.  If you want streaming conversions
you may want to use different modes than are currently
supported by that driver.

- Dave
