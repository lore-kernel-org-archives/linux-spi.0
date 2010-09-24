From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] spi_mpc8xxx: issue with using definition of pram in
 Device Tree
Date: Fri, 24 Sep 2010 10:07:35 -0500
Message-ID: <20100924100735.47b49580@udp111988uds.am.freescale.net>
References: <20100916070503.10046C7391@messagerie.si.c-s.fr>
	<20100924071006.GA21318@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: christophe leroy <christophe.leroy@c-s.fr>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	linuxppc-dev@lists.ozlabs.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100924071006.GA21318@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 24 Sep 2010 01:10:06 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Thu, Sep 16, 2010 at 09:05:03AM +0200, christophe leroy wrote:
> > This patch applies to 2.6.34.7 and 2.6.35.4
> > It fixes an issue during the probe for CPM1 with definition of parameter ram from DTS
> > 
> > Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>
> 
> I'm sorry, I don't understand the fix from the given description.
> What is the problem, and why is cpm_muram_alloc_fixed() the wrong
> thing to call on CPM1?  Does CPM2 still need it?

I don't see how cpm_muram_alloc_fixed() can be used safely at all.  If
you need a fixed address, it shouldn't be part of the general
allocation pool, or something else might get it first.

-Scott
