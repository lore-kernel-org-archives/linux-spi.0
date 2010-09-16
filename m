From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] spi_mpc8xxx: fix writing to adress 0
Date: Thu, 16 Sep 2010 09:39:09 +0200
Message-ID: <OFE491C952.64B1BE24-ONC12577A0.0029DACE-C12577A0.002A0993@transmode.se>
References: <20100916070420.95083C7391@messagerie.si.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net
To: christophe leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100916070420.95083C7391@messagerie.si.c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> From: christophe leroy <christophe.leroy@c-s.fr>
> To: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely
> <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-
> kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> Date: 2010/09/16 09:06
> Subject: [PATCH] spi_mpc8xxx: fix writing to adress 0
> Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
>
> This patch applies to 2.6.34.7 (already included in 2.6.35.4)
> It fixes an issue when sending only or receiving only (mspi->tx-dma was reset
> as when no tx_buf is defined, tx_dma is 0)
>
> Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
