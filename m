From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/1] davinci: spi: replace
	existing driver
Date: Tue, 6 Jul 2010 14:06:57 +0530
Message-ID: <20343.3002614931$1278405721@news.gmane.org>
References: <1278110334-13943-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "'Brian Niebuhr'" <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1278110334-13943-1-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
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

Hi,

On Sat, Jul 03, 2010 at 04:08:53, Brian Niebuhr wrote:
> I have included all of the recommended changes in this version of the patch.
> I also combined the patches into one patch to avoid bisecting issues.  This
> makes the diff on davinci_spi.c very large.
> 
> If people who are using this driver could test this version of the driver
> and Ack it, I would appreciate it.
> 
> ** NOTE **
> 
> This patch requires the EDMA patch at:
> 
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-March/018022.html
> 
> which is queued waiting on another driver fix, for DMA mode to work correctly.
> 
> 
> Brian Niebuhr (1):
>   davinci: spi: replace existing driver
> 
>  arch/arm/mach-davinci/board-dm355-evm.c     |   10 +
>  arch/arm/mach-davinci/board-dm355-leopard.c |   10 +
>  arch/arm/mach-davinci/board-dm365-evm.c     |   10 +
>  arch/arm/mach-davinci/dm355.c               |   12 +-
>  arch/arm/mach-davinci/dm365.c               |   12 +-
>  arch/arm/mach-davinci/include/mach/spi.h    |   37 +-
>  drivers/spi/davinci_spi.c                   | 1328 ++++++++++++---------------
>  7 files changed, 648 insertions(+), 771 deletions(-)
> 

Quick update.

I tested this patch on DM355 and DM365 EVMs. On DM355 all the 3 modes (DMA,
Polled and Interrupt) worked fine. But in interrupt mode, on DM355, if I set
"intr_level = 1", then kernel hangs during booting after printing
"spi spi0.0: DaVinci SPI driver in Interrupt mode" on the console.

On DM365 only DMA and Polled mode worked fine. In interrupt mode, whether I
set intr_level to ZERO or ONE, kernel booting hangs, similar to DM355.

I'll update the status of testing on OMAP-L1x EVMs later.

I am using the Linux kernel from [1] for testing.

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary

Regards,
Sudhakar



------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
