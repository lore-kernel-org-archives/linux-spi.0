From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH v2 0/8] spi_mpc8xxx: Add support for DMA transfers
Date: Wed, 19 Aug 2009 02:03:04 +0400
Message-ID: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
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

Hi all,

In v2:

- Fix build issues in fsl_qe_udc;
- Some minor cosmetic changes in "Add support for QE DMA mode and
  CPM1/CPM2 chips" patch.


David/Greg, could you Ack drivers/usb/gadget/fsl_qe_udc.h's changes 
in "[PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
non-QE/CPM builds", so we could merge that patch via powerpc tree?

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
