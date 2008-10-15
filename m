From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/9] mpc52xx_psc_spi: remove code associated with !CONFIG_PPC_MERGE
Date: Wed, 15 Oct 2008 14:34:33 -0700
Message-ID: <200810151434.33693.david-b@pacbell.net>
References: <1219294018-12557-1-git-send-email-galak@kernel.crashing.org> <1219294018-12557-7-git-send-email-galak@kernel.crashing.org> <764B32F3-E12E-4649-A2BB-3F94044D371F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net, akpm@linux-foundation.org
To: Kumar Gala <galak@kernel.crashing.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755553AbYJOVeq@vger.kernel.org>
In-Reply-To: <764B32F3-E12E-4649-A2BB-3F94044D371F@kernel.crashing.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 15 October 2008, Kumar Gala wrote:
> 
> On Aug 20, 2008, at 11:46 PM, Kumar Gala wrote:
> 
> > Now that arch/ppc is gone we don't need CONFIG_PPC_MERGE anymore
> > remove the dead code associated with !CONFIG_PPC_MERGE.
> >
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > ---
> > drivers/spi/mpc52xx_psc_spi.c |   55  
> > -----------------------------------------
> > 1 files changed, 0 insertions(+), 55 deletions(-)
> 
> Any update on acceptance of this patch?

Still seems to be in the MM queue ready to merge
a bit later in the window.

- Dave
