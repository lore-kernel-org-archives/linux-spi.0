From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi_mpc8xxx: fix writing to adress 0
Date: Thu, 16 Sep 2010 14:11:14 -0600
Message-ID: <20100916201114.GA11972@angua.secretlab.ca>
References: <20100916070420.95083C7391@messagerie.si.c-s.fr>
 <OFE491C952.64B1BE24-ONC12577A0.0029DACE-C12577A0.002A0993@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christophe leroy <christophe.leroy@c-s.fr>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OFE491C952.64B1BE24-ONC12577A0.0029DACE-C12577A0.002A0993@transmode.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 16, 2010 at 09:39:09AM +0200, Joakim Tjernlund wrote:
> > From: christophe leroy <christophe.leroy@c-s.fr>
> > To: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely
> > <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-
> > kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> > Date: 2010/09/16 09:06
> > Subject: [PATCH] spi_mpc8xxx: fix writing to adress 0
> > Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
> >
> > This patch applies to 2.6.34.7 (already included in 2.6.35.4)
> > It fixes an issue when sending only or receiving only (mspi->tx-dma was reset
> > as when no tx_buf is defined, tx_dma is 0)
> >
> > Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>
> 
> Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> 

You need to send this to the linux-stable list and include the sha1
commit id that fixes it in mainline.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
