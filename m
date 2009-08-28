From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2 0/8] spi_mpc8xxx: Add support for DMA transfers
Date: Thu, 27 Aug 2009 21:41:59 -0700
Message-ID: <200908272141.59796.david-b@pacbell.net>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: avorontsov@ru.mvista.com
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 18 August 2009, Anton Vorontsov wrote:

> - Fix build issues in fsl_qe_udc;
> - Some minor cosmetic changes in "Add support for QE DMA mode and
>   CPM1/CPM2 chips" patch.

Hmm ... the first four of these are pure PPC stuff and thus
not appropriate to send as SPI patches; but the second four
depend on them.

So I'll just say

  Acked-by: David Brownell <dbrownell@users.sourceforge.net>

and ask you to merge via the PPC tree.  (And hope that you
verified these are bisectable...)
