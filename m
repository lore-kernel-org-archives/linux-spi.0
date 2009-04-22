From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v6] spi: Add PPC4xx SPI driver
Date: Wed, 22 Apr 2009 10:29:38 +0200
Message-ID: <200904221029.38454.sr@denx.de>
References: <1231411250-25380-1-git-send-email-sr@denx.de>
	<200904212236.12904.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
To: David Brownell <david-b@pacbell.net>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <200904212236.12904.david-b@pacbell.net>
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

On Wednesday 22 April 2009, David Brownell wrote:
> On Thursday 08 January 2009, Stefan Roese wrote:
> > This adds a SPI driver for the SPI controller found in the IBM/AMCC
> > 4xx PowerPC's.
>
> Note that given some patches now in the mm tree, this needs
> something like the appended fixup.  Some common code has now
> moved into the spi core.

So would you accept the driver for 2.6.31 merge with your suggested change 
below? If yes, I'll generate a 7th version.

Thanks.

Best regards,
Stefan
