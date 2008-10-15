From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 6/9] mpc52xx_psc_spi: remove code
	associated with !CONFIG_PPC_MERGE
Date: Wed, 15 Oct 2008 16:23:33 -0500
Message-ID: <764B32F3-E12E-4649-A2BB-3F94044D371F@kernel.crashing.org>
References: <1219294018-12557-1-git-send-email-galak@kernel.crashing.org>
	<1219294018-12557-2-git-send-email-galak@kernel.crashing.org>
	<1219294018-12557-3-git-send-email-galak@kernel.crashing.org>
	<1219294018-12557-4-git-send-email-galak@kernel.crashing.org>
	<1219294018-12557-5-git-send-email-galak@kernel.crashing.org>
	<1219294018-12557-6-git-send-email-galak@kernel.crashing.org>
	<1219294018-12557-7-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1219294018-12557-7-git-send-email-galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Aug 20, 2008, at 11:46 PM, Kumar Gala wrote:

> Now that arch/ppc is gone we don't need CONFIG_PPC_MERGE anymore
> remove the dead code associated with !CONFIG_PPC_MERGE.
>
> Signed-off-by: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> ---
> drivers/spi/mpc52xx_psc_spi.c |   55  
> -----------------------------------------
> 1 files changed, 0 insertions(+), 55 deletions(-)

Any update on acceptance of this patch?

- k

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
