From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] spi_mpc8xxx: fix buffer overrun when sending only/receiving
	only more than PAGE_SIZE bytes
Date: Thu, 16 Sep 2010 09:40:24 +0200
Message-ID: <OFD056F539.7143D21A-ONC12577A0.002A0D53-C12577A0.002A26CB@transmode.se>
References: <20100916070525.4882CC7391@messagerie.si.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net
To: christophe leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100916070525.4882CC7391@messagerie.si.c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> From: christophe leroy <christophe.leroy@c-s.fr>
> To: David Brownell <dbrownell@users.sourceforge.net>, Grant Likely
> <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-
> kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> Date: 2010/09/16 09:07
> Subject: [PATCH] spi_mpc8xxx: fix buffer overrun when sending only/receiving
> only more than PAGE_SIZE bytes
> Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
>
> This patch applies to 2.6.34.7 and 2.6.35.4
> It fixes an issue when sending only or receiving only more than PAGE_SIZE bytes
>
> Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
