From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: spi-bitbang inverted logic?
Date: Thu, 15 Mar 2012 15:31:50 -0600
Message-ID: <20120315213150.C36853E04E5@localhost>
References: <Pine.LNX.4.64.1203151201040.2988@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1203151201040.2988-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 15 Mar 2012 12:09:42 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> Hi all
> 
> I stumbled across this code in spi-bitbang.c:
> 
> 		list_for_each_entry (t, &m->transfers, transfer_list) {
> 			...
> 			cs_change = t->cs_change;
> 			...
> 			if (!cs_change)
> 				continue;
> 			...
> 			/* sometimes a short mid-message deselect of the chip
> 			 * may be needed to terminate a mode or command
> 			 */
> 			ndelay(nsecs);
> 			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> 			ndelay(nsecs);
> 		}
> 		...
> 
> 		/* normally deactivate chipselect ... unless no error and
> 		 * cs_change has hinted that the next message will probably
> 		 * be for this chip too.
> 		 */
> 		if (!(status == 0 && cs_change)) {
> 			ndelay(nsecs);
> 			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
> 			ndelay(nsecs);
> 		}
> 
> So, IIUC, on the first occurrance cs_change is interpreted as "true == 
> have to disable CD," whereas the second one does the opposite. Shouldn't 
> the latter one be inverted?

Actually, I suspect that cs_change is being abused here to allow multiple
messages to operate over a single cs_change assertion.  It does look dodgy,
but I think you'll need to audit the users of cs_change to ensure that every
'normal' message has cs_change asserted for the last transfer in a message.

g.


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
