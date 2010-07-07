From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/1] davinci: spi:
	replaceexisting driver
Date: Wed, 7 Jul 2010 16:50:50 +0530
Message-ID: <28140.2893168435$1278501951@news.gmane.org>
References: <1278110334-13943-1-git-send-email-bniebuhr@efjohnson.com>
	<002301cb1ce6$64fba3e0$2ef2eba0$@raj@ti.com>
	<BA34378D1528D04CB3C865B8BAB2472B035F78@transmx01.transcrypt.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "'Brian Niebuhr'" <BNiebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>,
	"'Brian Niebuhr'" <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BA34378D1528D04CB3C865B8BAB2472B035F78-mqUZVEcnZosHtCCSzi1I5PfQPhDVBs+grNQQ6b5fDX0@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Brian,

On Tue, Jul 06, 2010 at 19:45:56, Brian Niebuhr wrote:
> > On Sat, Jul 03, 2010 at 04:08:53, Brian Niebuhr wrote:
> > > I have included all of the recommended changes in this 

[...]

> > 
> > Quick update.
> > 
> > I tested this patch on DM355 and DM365 EVMs. On DM355 all the 
> > 3 modes (DMA,
> > Polled and Interrupt) worked fine. But in interrupt mode, on 
> > DM355, if I set
> > "intr_level = 1", then kernel hangs during booting after printing
> > "spi spi0.0: DaVinci SPI driver in Interrupt mode" on the console.
> 
> Sudhakar - 
> 
> When you changed the interrupt level, did you also change the
> IORESOURCE_IRQ entry for SPI0?  Maybe we could set the interrupt level
> automatically based on the IORESOURCE_IRQ provided?

IORESOURCE_IRQ entry for dm365 were already present in dm365.c.

>  
> > On DM365 only DMA and Polled mode worked fine. In interrupt 
> > mode, whether I
> > set intr_level to ZERO or ONE, kernel booting hangs, similar to DM355.
> 
> Does the interrupt mode of the existing driver work on DM365?  
> 

AFAIK, support for interrupt mode was not present in the earlier driver
by Sandeep Paulraj.

> I don't have one of these boards, so I can't debug the issue.  If you
> have any ideas where the problem might be I'd appreciate the help in
> getting this resolved.

As I mentioned in my earlier e-mail, on DM365 kernel booting hangs after
Printing "spi spi0.0: DaVinci SPI driver in Interrupt mode" on the console.
Control is in spi_sync() function waiting for completion.

> If the change I mentioned above fixes the issue on DM355, then

I am not sure whether my earlier mail was clear in this regard or not
but interrupt mode works fine on DM355 if intr_level = 0. Kernel booting
hangs on DM355 if intr_level = 1.

> I've got to imagine that it's just a configuration issue
> of some sort on DM365.
> 

I am also of the same opinion.

Thanks,
Sudhakar



------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
