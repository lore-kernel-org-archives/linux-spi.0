From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] fixes probe issue and hangup in spi_mpc8xxx.c for data bigger
	than PAGE_SIZE
Date: Wed, 15 Sep 2010 17:08:16 +0200
Message-ID: <OFE529E700.F5762D7C-ONC125779F.0052EF12-C125779F.005327C5@transmode.se>
References: <4C90CA4D.2020902@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	spi-devel-general@lists.sourceforge.net
To: LEROY Christophe <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C90CA4D.2020902@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>
>   This patch applies to 2.6.34.7. It also applies to 2.6.35.4 althought
> part of it is already included in 2.6.35.4
> It fixed a problem with spi_mpc8xxx.c when transmitting or receiving
> data bigger than PAGE_SIZE when doing a read only or write only operation
> It also fixed an issue with the init probe when fetching the information
> on parameter RAM from the DTB.

I think you need to break this up into 3 patches. It can't go into Linus
tree as is and it can't go into stable before it is in Linus tree.

    Jocke
