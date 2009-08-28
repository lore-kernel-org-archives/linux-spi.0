From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for non-QE/CPM builds
Date: Fri, 28 Aug 2009 00:45:56 -0500
Message-ID: <04A4E77E-C7A2-46B7-8AF4-966868E3AEDA@kernel.crashing.org>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru> <20090818220418.GD25090@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751923AbZH1Fqy@vger.kernel.org>
In-Reply-To: <20090818220418.GD25090@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


On Aug 18, 2009, at 5:04 PM, Anton Vorontsov wrote:

> This is needed to avoid ugly #ifdefs in drivers. Also update  
> fsl_qe_udc
> driver so that now it doesn't define its own versions that cause build
> breakage when the generic stubs are used.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/cpm.h  |   44 ++++++++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/include/asm/qe.h   |   11 ++++++++-
> drivers/usb/gadget/fsl_qe_udc.h |   15 -------------
> 3 files changed, 54 insertions(+), 16 deletions(-)


applied to next

- k
