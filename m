From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: dw_spi: refine the IRQ
 mode working flow
Date: Thu, 21 Jan 2010 10:47:26 +0800
Message-ID: <20100121104726.0fea94e5@feng-desktop>
References: <20100119112033.74a0f5be@feng-desktop> <4B55BFC5.506@octasic.com>
	<20100120111827.6ebd4cc8@feng-desktop>
	<4B56FA93.1030507@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4B56FA93.1030507-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 20 Jan 2010 20:44:03 +0800
Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org> wrote:

>
> >>     
> >
> > For FIFO depth, it depends on each specific implementation based on
> > DW core, and interface driver would better set it. If fifo_len is
> > not set in IRQ mode, core driver will set 0 as the TX interrupt
> > threshold, which will only trigger the TXE IRQ when the TX FIFO is
> > fully empty. This is my design thought. 
> I'm sorry; At first, I was under the impression that it referred to a 
> software FIFO.
> ...So could this be auto-detected from the [RT]XFTLR registers, then?
> 

Yep, really a good idea, from the HW spec, the depth could be detected
from [RT}XTLR, will submit a patch for this.

Thanks,
Feng

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
