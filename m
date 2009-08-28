From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/8] powerpc/qe&cpm2: Avoid
	redefinitions in CPM2 and QE headers
Date: Fri, 28 Aug 2009 00:45:45 -0500
Message-ID: <4B4F10E3-C09C-4C26-9D42-4CC297021F0F@kernel.crashing.org>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220415.GB25090@oksana.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090818220415.GB25090-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


On Aug 18, 2009, at 5:04 PM, Anton Vorontsov wrote:

> struct mcc defined in both immap_qe.h and immap_cpm2.h, so they will
> conflic when included in a single file. The mcc struct is easy to deal
> with, since it isn't used in any driver (yet), so let's just rename QE
> version to qe_mcc.
>
> The ucb_ctlr is a bit trickier, since it is used by fsl_qe_udc driver,
> and the driver supports both CPM and QE UDCs, plus the QE version is
> used to form a bigger immap struct.
>
> I don't want to touch too much of USB code in this series, so for now
> let's just copy most generic version into the common cpm.h header,
> later we'll create cpm_usb.h where we'll place common USB structs that
> are used by QE/CPM UDC and QE Host drivers (FHCI).
>
> And as for the structs in qe.h and cpm2.h, just prefix them with qe_
> and cpm_.
>
> Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> ---
> arch/powerpc/include/asm/cpm.h        |   22 ++++++++++++++++++++++
> arch/powerpc/include/asm/immap_cpm2.h |    2 +-
> arch/powerpc/include/asm/immap_qe.h   |    8 ++++----
> 3 files changed, 27 insertions(+), 5 deletions(-)


applied to next

- k

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
