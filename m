From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for non-QE/CPM builds
Date: Thu, 5 Nov 2009 07:46:48 -0600
Message-ID: <F65088B7-CBE6-4CD5-8715-E3C504C99A6E@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru> <20091012164920.GD4578@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756872AbZKENrZ@vger.kernel.org>
In-Reply-To: <20091012164920.GD4578@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Oct 12, 2009, at 11:49 AM, Anton Vorontsov wrote:

> This is needed to avoid ugly #ifdefs in drivers. Also update  
> fsl_qe_udc
> driver so that now it doesn't define its own versions that cause build
> breakage when the generic stubs are used.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> arch/powerpc/include/asm/cpm.h  |   44 ++++++++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/include/asm/qe.h   |   11 ++++++++-
> drivers/usb/gadget/fsl_qe_udc.h |   15 -------------
> 3 files changed, 54 insertions(+), 16 deletions(-)

applied to next

- k
