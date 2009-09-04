From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 0/8] spi_mpc8xxx: Add support for DMA transfers
Date: Fri, 4 Sep 2009 20:37:27 +0400
Message-ID: <20090904163727.GA27358@oksana.dev.rtsoft.ru>
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<200908272141.59796.david-b@pacbell.net>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <200908272141.59796.david-b@pacbell.net>
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

On Thu, Aug 27, 2009 at 09:41:59PM -0700, David Brownell wrote:
> On Tuesday 18 August 2009, Anton Vorontsov wrote:
> 
> > - Fix build issues in fsl_qe_udc;
> > - Some minor cosmetic changes in "Add support for QE DMA mode and
> >   CPM1/CPM2 chips" patch.
> 
> Hmm ... the first four of these are pure PPC stuff and thus
> not appropriate to send as SPI patches; but the second four
> depend on them.
> 
> So I'll just say
> 
>   Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> and ask you to merge via the PPC tree.  (And hope that you
> verified these are bisectable...)

Thanks David.

Kumar, can you please merge the SPI part of this patch set?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
